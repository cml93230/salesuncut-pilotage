-- 0002 — contenu initial du tableau de bord, issu du bilan du 23/09/2026.
-- Rejouable : vide d'abord les trois tables (elles n'existaient pas avant ce jour).
truncate public.pilotage_commentaires, public.pilotage_taches, public.pilotage_chapitres restart identity;

insert into public.pilotage_chapitres (id, titre, ordre) values
 (1,'Le test — l''appel et la note',10),
 (2,'Le site — vitrine, inscription, espace candidat',20),
 (3,'L''espace recruteur',30),
 (4,'Paiement et offre',40),
 (5,'Juridique et conformité',50),
 (6,'Fiabilité, sécurité, coûts',60),
 (7,'Lancement et acquisition',70),
 (8,'Circuit de travail',80);
select setval('public.pilotage_chapitres_id_seq', 8);

insert into public.pilotage_taches (chapitre_id, titre, detail, qui, statut, ordre) values
-- 1 · le test
 (1,'Chaîne complète prouvée : appel → double lecture → revue → e-mail','Appel réel du 14/09 (Thomas, 96) : zéro geste manuel, zéro incident. 9 appels réels notés et envoyés au 23/09.','les deux','fait',10),
 (1,'Anonymat automatique sous le seuil','En service depuis le 21/09. Jamais déclenché par un vrai appel : sera constaté au premier appel sous 50.','claude','fait',20),
 (1,'Faire passer 5 vrais candidats extérieurs','La validité du test repose sur 2 personnes (David 31, Chloé 62). Point n°1 : sans ça, on ne sait pas si la note veut dire quelque chose.','anthony','a_faire',30),
 (1,'Voix d''attente de Julien : fabriquer les 4 phrases','Couvre les ~3,6 s de silence entre deux répliques. Fabrication par le banc audition, puis Anthony écoute (seul verrou), puis fichiers dans le dépôt.','claude','a_faire',40),
 (1,'Écouter et valider la voix d''attente','','anthony','a_faire',50),
 (1,'Alerte e-mail si un appel terminé n''est pas noté dans l''heure','Aujourd''hui une panne de la chaîne est silencieuse.','claude','a_faire',60),
 (1,'Lien de transparence manquant sur 5 fiches sur 6','Défaut mesuré le 14/09, se rejoue à chaque nouvel appel.','claude','a_faire',70),
 (1,'Une réplique par appel fabriquée et payée deux fois','19 synthèses pour 18 tours, cause non instrumentée.','claude','a_faire',80),
 (1,'Test « réseau coupé pendant l''envoi de l''audio »','Seule preuve qui manque à la chaîne audio.','claude','a_faire',90),
 (1,'Trancher l''effort du correcteur','Plus rapide ou plus juste : la note du candidat en dépend. Comparer la qualité, pas les millisecondes.','anthony','a_faire',100),
 (1,'Trancher la durée annoncée du test','La page dit « vingt minutes », les appels réels durent 4 à 11 min.','anthony','a_faire',110),
 (1,'Remesurer la constance du correcteur sur la version en service','Le seuil de seconde lecture (5 points) a été calibré sur une ancienne version. Il faut une poignée d''appels réels de la version actuelle.','claude','bloque',120),
 (1,'Jour J : éteindre le code d''accès','Réglage en base, sans redéploiement.','claude','a_faire',130),
 (1,'Jour J : repassage à 90 jours (deux endroits) et audio à 90 jours','Secret serveur + espace candidat + page des mentions légales, ensemble.','claude','a_faire',140),
-- 2 · le site
 (2,'Nouvelle page d''accueil en ligne','Chantier 26, 18/09. Copywriting acté, huit blocs.','claude','fait',10),
 (2,'Banderole, pied de page, fiche unique candidat/recruteur, photos et CV privés','Chantiers 17 à 29.','claude','fait',20),
 (2,'Page candidat : textes faux en ligne','« 30 minutes », « du paiement », ElevenLabs, GPT-4o : rien n''est vrai. Priorité.','claude','a_faire',30),
 (2,'Page marketplace : « 99 €/mois » jamais acté','','claude','a_faire',40),
 (2,'Quatre phrases parlent au recruteur sur des écrans candidat','Dont deux messages d''erreur d''écoute et la demi-phrase du quota.','claude','a_faire',50),
 (2,'Bouton de téléchargement de la bannière LinkedIn non branché','banniere.js n''est chargé par aucune page.','claude','a_faire',60),
 (2,'Sort des 8 profils de démonstration','Leur audio pointe vers des fichiers absents : rendu sans lecteur, ou retrait de la fiche publique.','les deux','a_faire',70),
 (2,'Relire l''accueil au navigateur à 1280 / 1440 / 390 px','Personne ne l''a fait depuis la mise en ligne.','claude','a_faire',80),
 (2,'Parcourir l''espace candidat connecté','Jamais vu par personne. Compte candidat jetable.','claude','a_faire',90),
 (2,'Valider l''accueil à l''œil','','anthony','a_faire',100),
 (2,'Phrase sous « Révéler ce candidat »','Proposée : « Nom, photo et extraits audio masqués jusqu''au déblocage ».','anthony','a_faire',110),
 (2,'Police Playfair Display : décision à part','Elle n''est pas chargée ; l''appeler la remplacerait en silence.','anthony','a_faire',120),
-- 3 · recruteur
 (3,'Application recruteur : vivier, filtres, shortlist, partage manager, rendez-vous, déblocage, écoute','','claude','fait',10),
 (3,'Trancher l''offre recruteur','Abonnement 99/199 €, ou 39 € par profil révélé, ou % à l''embauche. Rien n''est acté ; « Upgrader » ouvre un simple e-mail.','anthony','a_faire',20),
 (3,'L''écoute recruteur a-t-elle déjà été vue connectée ?','L''état se contredit (17/09 validé vs jamais vu). Toi seul peux trancher.','anthony','a_faire',30),
 (3,'Repasser le compte recruteur en gratuit après la recette','Et vérifier la vue freemium et « crédit épuisé ».','claude','a_faire',40),
 (3,'Empêcher le téléchargement des extraits','Le lien du fichier se lit dans la page. Voies : liens très courts, ou découpe servie par le serveur (recommandée). À trancher avant l''ouverture.','les deux','a_faire',50),
 (3,'Trouver 2 ou 3 recruteurs pilotes','Avant l''école.','anthony','a_faire',60),
-- 4 · paiement
 (4,'Statut juridique de l''activité','Micro-entreprise ou société.','anthony','a_faire',10),
 (4,'Compte Stripe','Identité + IBAN.','anthony','a_faire',20),
 (4,'Fixer le prix recruteur','Dépend de l''offre tranchée (chapitre 3).','anthony','a_faire',30),
 (4,'Brancher le paiement','Page de paiement, plan du recruteur mis à jour automatiquement, facture envoyée. 1 à 2 chantiers.','claude','bloque',40),
-- 5 · juridique
 (5,'Identité de l''éditeur et adresse RGPD','Nom, SIREN, adresse, adresse de contact.','anthony','a_faire',10),
 (5,'Mentions légales : 8 « à compléter » et 2 lignes fausses','Audio « 7 jours » contre 90 décidés ; finalité de la voix incomplète.','claude','bloque',20),
 (5,'Rédiger CGU candidat, CGV recruteur, politique de confidentialité','Sous-traitants nommés (Supabase Irlande ; Anthropic, Resend, Vercel États-Unis ; Mistral France).','claude','a_faire',30),
 (5,'Notice « comment vous êtes évalué » avant l''appel','Information préalable du candidat sur la méthode (code du travail, règlement IA).','claude','a_faire',40),
 (5,'Registre des traitements','','claude','a_faire',50),
 (5,'Pages contact et à propos, brancher les 5 liens du pied de page','','claude','a_faire',60),
 (5,'Relecture par un avocat','Mes brouillons sont une base, pas une garantie.','anthony','a_faire',70),
 (5,'Ne jamais analyser les émotions dans la voix','Interdit par le règlement européen sur l''IA. Enterrer l''idée des « signaux prosodiques ».','les deux','fait',80),
-- 6 · fiabilité
 (6,'Sécurité du 14/09 : jetons révoqués, clés changées, seaux privés prouvés','','claude','fait',10),
 (6,'Passer Supabase en plan Pro','Règle trois points : pause après 7 jours sans visite, aucune sauvegarde, place audio (768 Mo sur 1 Go). ~25 $/mois.','anthony','a_faire',20),
 (6,'Sauvegarde hebdomadaire automatique en attendant le plan Pro','','claude','a_faire',30),
 (6,'Plus aucun garde-fou contre la mise en pause de la base','Scénarios Make éteints, keep-alive disparu. Ce sont les visites quotidiennes qui la maintiennent éveillée.','les deux','a_faire',40),
 (6,'Lot mots de passe','Règle serveur + les 4 phrases de la page d''inscription, éprouvé sur un compte jetable.','claude','a_faire',50),
 (6,'Fermer aux visiteurs sans compte les 3 fonctions ouvertes pour rien','purger_visites, rls_auto_enable, debloquer_candidat.','claude','a_faire',60),
 (6,'Supprimer les 5 fonctions mortes','Depuis la session avec l''outil officiel, sinon 5 clics dans le tableau de bord Supabase. audition reste : elle est vivante.','claude','a_faire',70),
 (6,'Supprimer l''ancien projet salesuncut-moteur','Quand les trois mois seront passés (décembre 2026).','anthony','bloque',80),
-- 7 · lancement
 (7,'Convention avec l''école','Date, volume, gratuit ou 5–10 €/candidat (décision en attente depuis le 14/09).','anthony','a_faire',10),
 (7,'Mode d''emploi école','Une page : comment passer le test, avec le code.','claude','a_faire',20),
 (7,'E-mail de relance aux candidats qui n''ont pas fini leurs vingt questions','','claude','a_faire',30),
 (7,'Page recruteurs avec l''offre','Après décision du chapitre 3.','claude','bloque',40),
 (7,'Vignette de partage LinkedIn par candidat','Demande une fonction serveur : le robot LinkedIn n''exécute pas la page.','claude','a_faire',50),
 (7,'Recruteurs pilotes, réseau, LinkedIn','','anthony','a_faire',60),
-- 8 · circuit
 (8,'GitHub Desktop installé, dépôt cloné sur la machine d''Anthony','21/09.','anthony','fait',10),
 (8,'La session cloud peut de nouveau pousser sur GitHub','Prouvé le 23/09 : branche d''essai créée puis supprimée. Branche + aperçu Vercel + demande de fusion par Claude ; fusion par Anthony.','claude','fait',20),
 (8,'Adopter le nouveau circuit dès le prochain chantier','Mettre à jour CLAUDE.md (le circuit du 21/09 devient le secours).','les deux','a_faire',30),
 (8,'Tableau de bord de pilotage en ligne','Dépôt salesuncut-pilotage, projet Vercel séparé, accès par le compte admin.','claude','en_cours',40);

-- Quelques commentaires initiaux, groupés par intitulé
insert into public.pilotage_commentaires (tache_id, intitule, contenu, auteur)
select t.id, 'Mesure', 'Deux passages extérieurs le 12/09 : David (plombier, zéro vente) 31, Chloé (ex-négociatrice) 62. L''ordre est conforme au terrain : seul signe de validité externe à ce jour.', 'claude'
from public.pilotage_taches t where t.titre like 'Faire passer 5 vrais candidats%';
insert into public.pilotage_commentaires (tache_id, intitule, contenu, auteur)
select t.id, 'Comment faire', 'Le code d''accès du moment est dans le réglage code_acces_test. Chaque testeur crée un compte, entre le code, passe l''appel, puis répond aux vingt questions.', 'claude'
from public.pilotage_taches t where t.titre like 'Faire passer 5 vrais candidats%';
insert into public.pilotage_commentaires (tache_id, intitule, contenu, auteur)
select t.id, 'Contexte', 'Les deux scénarios Make (5692078, 6299432) sont inactifs et le scénario keep-alive 6680956 n''existe plus. Vérifié le 23/09.', 'claude'
from public.pilotage_taches t where t.titre like 'Plus aucun garde-fou%';
insert into public.pilotage_commentaires (tache_id, intitule, contenu, auteur)
select t.id, 'Ce que dit la loi', 'Un outil qui note des candidats est « à haut risque » (règlement européen sur l''IA, annexe III). Obligations complètes le 2 décembre 2027 ; dès aujourd''hui : RGPD, information préalable du candidat, interdiction d''analyser les émotions, supervision humaine.', 'claude'
from public.pilotage_taches t where t.titre like 'Notice « comment vous êtes évalué%';
