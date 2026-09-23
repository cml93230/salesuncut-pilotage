# salesuncut-pilotage

Tableau de bord de pilotage du lancement SalesUncut. Une seule page, sans build,
servie par Vercel. Les données vivent dans la base du site (tables `pilotage_*`),
lisibles et modifiables uniquement par le compte administrateur du site.

- `index.html` — la page.
- `supabase/0001_pilotage.sql` — les tables, les règles d'accès et la fonction de chiffres (appliquée le 23/09/2026).
- `supabase/0002_contenu_initial.sql` — le contenu initial, issu du bilan du 23/09/2026.

Mise en ligne : Vercel, projet `salesuncut-pilotage`, relié au dépôt le 23/09/2026.
