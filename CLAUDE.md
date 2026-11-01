## Agent skills

### Issue tracker

GitHub Issues in this repo (via the `gh` CLI). See `docs/agents/issue-tracker.md`.

Usa `nix develop -c gh ...` (no hay `gh` instalado en el sistema).

### Wayfinder

El mapa de este esfuerzo ya existe: issue #1 de `imsoka/thunar-nextcloud-plugin-vfs` (`wayfinder:map`, "Mapa: plugin de Thunar para Nextcloud"). Sus hijos son los tickets (#2 a #9). Cuando se invoque `/wayfinder` sin idea nueva, no preguntes por la idea ni por el destino: léelo del mapa (`nix develop -c gh issue view 1`) y sigue por la frontera (`nix develop -c gh api repos/imsoka/thunar-nextcloud-plugin-vfs/issues/1/sub_issues`).

### Triage labels

Default triage labels: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`. See `docs/agents/triage-labels.md`.

### Domain docs

Single-context layout: `GLOSSARY.md` and `docs/adr/` at the repo root. See `docs/agents/domain.md`.
