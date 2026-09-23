-- ============================================================
-- 0001 — TABLEAU DE BORD DE PILOTAGE (23/09/2026)
-- Trois tables neuves + une fonction de chiffres. Réservées au compte
-- administrateur du site (table administrateurs, via est_administrateur()).
-- Aucune table existante n'est touchée.
-- ============================================================

create table if not exists public.pilotage_chapitres (
  id        serial primary key,
  titre     text not null,
  ordre     int  not null default 100,
  cree_le   timestamptz not null default now()
);

create table if not exists public.pilotage_taches (
  id          uuid primary key default gen_random_uuid(),
  chapitre_id int  not null references public.pilotage_chapitres(id) on delete cascade,
  titre       text not null,
  detail      text,
  qui         text not null default 'claude' check (qui in ('claude','anthony','les deux')),
  statut      text not null default 'a_faire' check (statut in ('a_faire','en_cours','fait','bloque')),
  ordre       int  not null default 100,
  cree_le     timestamptz not null default now(),
  maj_le      timestamptz not null default now()
);

create table if not exists public.pilotage_commentaires (
  id        uuid primary key default gen_random_uuid(),
  tache_id  uuid not null references public.pilotage_taches(id) on delete cascade,
  intitule  text not null,
  contenu   text not null,
  auteur    text not null default 'anthony' check (auteur in ('claude','anthony')),
  cree_le   timestamptz not null default now()
);

create index if not exists pilotage_taches_chapitre_idx on public.pilotage_taches(chapitre_id, ordre);
create index if not exists pilotage_commentaires_tache_idx on public.pilotage_commentaires(tache_id, intitule);

-- maj_le suit chaque modification
create or replace function public.pilotage_touch()
returns trigger language plpgsql set search_path = public as $$
begin new.maj_le := now(); return new; end $$;
drop trigger if exists pilotage_taches_touch on public.pilotage_taches;
create trigger pilotage_taches_touch before update on public.pilotage_taches
  for each row execute function public.pilotage_touch();

-- Règles d'accès : admin seul, dans les deux sens (lecture et écriture).
alter table public.pilotage_chapitres    enable row level security;
alter table public.pilotage_taches       enable row level security;
alter table public.pilotage_commentaires enable row level security;

drop policy if exists pilotage_admin on public.pilotage_chapitres;
create policy pilotage_admin on public.pilotage_chapitres
  for all to authenticated using (est_administrateur()) with check (est_administrateur());
drop policy if exists pilotage_admin on public.pilotage_taches;
create policy pilotage_admin on public.pilotage_taches
  for all to authenticated using (est_administrateur()) with check (est_administrateur());
drop policy if exists pilotage_admin on public.pilotage_commentaires;
create policy pilotage_admin on public.pilotage_commentaires
  for all to authenticated using (est_administrateur()) with check (est_administrateur());

-- Droits de table : rien pour anon, tout pour authenticated (la règle filtre).
revoke all on public.pilotage_chapitres, public.pilotage_taches, public.pilotage_commentaires from anon, public;
grant select, insert, update, delete on public.pilotage_chapitres, public.pilotage_taches, public.pilotage_commentaires to authenticated;
grant usage, select on sequence public.pilotage_chapitres_id_seq to authenticated;
revoke all on sequence public.pilotage_chapitres_id_seq from anon, public;

-- Chiffres vivants du tableau de bord. Gardée par admin_exige(), comme les admin_*.
create or replace function public.pilotage_chiffres()
returns jsonb language plpgsql stable security definer set search_path = public as $$
declare r jsonb;
begin
  perform admin_exige();
  select jsonb_build_object(
    'candidats',           (select count(*) from candidates),
    'candidats_visibles',  (select count(*) from get_public_candidates_pool()),
    'recruteurs',          (select count(*) from recruiters),
    'appels_reels',        (select count(*) from labo_appels where est_banc is not true),
    'appels_externes',     (select count(distinct candidat_id) from labo_appels where est_banc is not true and candidat_id is not null),
    'dernier_appel_reel',  (select max(demarre_le) from labo_appels where est_banc is not true),
    'appels_non_notes',    (select count(*) from labo_appels where est_banc is not true and termine_le is not null and notee_le is null),
    'visites_30j',         (select count(*) from visites where cree_le > now() - interval '30 days' and interne is not true),
    'audio_octets',        (select coalesce(sum((metadata->>'size')::bigint),0) from storage.objects where bucket_id = 'reponses-audio'),
    'code_acces_actif',    (select actif from reglages where cle = 'code_acces_test'),
    'plafond_jour',        (select valeur from reglages where cle = 'plafond_appels_par_jour'),
    'taches_total',        (select count(*) from pilotage_taches),
    'taches_faites',       (select count(*) from pilotage_taches where statut = 'fait')
  ) into r;
  return r;
end $$;
revoke execute on function public.pilotage_chiffres() from public, anon;
grant execute on function public.pilotage_chiffres() to authenticated;
