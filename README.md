# Dis Saucisse !

Trier les photos du téléphone rafale par rafale, puis les envoyer sur l'ordinateur de la maison par le Wi-Fi local, rangées par année, mois et événement. Sans cloud.

- `apps/dis_saucisse_mobile` : app mobile (Android, iOS)
- `apps/dis_saucisse_desktop` : app ordinateur (Windows, macOS)
- `core/core` : fondations partagées (`SafeCubit`, `AppFailure`)
- `core/core_ui` : design system
- `shared_packages/transfer_protocol` : contrat de transfert téléphone ↔ ordinateur

Voir [coding_rules.md](coding_rules.md) pour les règles de code.

## Démarrer

```bash
fvm install
fvm flutter pub get
fvm flutter analyze
```

```bash
cd apps/dis_saucisse_mobile && fvm flutter run
```

```bash
cd apps/dis_saucisse_desktop && fvm flutter run -d macos
```
