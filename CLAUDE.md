# Dis Saucisse !

Trier les photos du téléphone rafale par rafale, puis les envoyer sur l'ordinateur de la maison par le Wi-Fi local, rangées par année, mois et événement. Sans cloud.

Workspace Dart (`pubspec.yaml` à la racine) :

- `apps/dis_saucisse_mobile` : app mobile (iOS, Android)
- `apps/dis_saucisse_desktop` : app ordinateur (macOS, Windows), sans iOS ni Android
- `core/core` : fondations partagées (`SafeCubit`, `AppFailure`, `withMinimalDelay`)
- `core/core_ui` : design system (`Ds*`), assets (logo, mascotte, polices, animation du loader)
- `shared_packages/transfer_protocol` : contrat de transfert téléphone ↔ ordinateur

## Règles de code

@coding_rules.md

## Commandes

Toujours passer par `fvm` (version de Flutter fixée dans `.fvmrc`). `fvm` est dans `~/.pub-cache/bin`.

- Dépendances : `fvm flutter pub get` à la racine.
- Analyse de tout le workspace : `fvm flutter analyze` à la racine.
- Formatage : `fvm dart format --line-length 120 <chemins>`.
- Tests : `fvm flutter test` dans chaque package (`core/core`, `core/core_ui`, `apps/dis_saucisse_mobile`, `apps/dis_saucisse_desktop`).
- Code généré (base drift, routes go_router) : `fvm dart run build_runner build` dans l'app concernée. Ne jamais éditer un `*.g.dart` à la main.
- Textes des apps (mobile et desktop) : un fichier `<namespace>_fr.i18n.json` par fonctionnalité (`lib/features/<feature>/`) ou dans `lib/core/presentation/`, sans tiret bas dans le nom du namespace (`freeSpace_fr`, pas `free_space_fr`). Après modification : `fvm dart run slang` (ou `fvm dart run slang watch`) dans le dossier de l'app pour régénérer `lib/core/i18n/translations*.g.dart`. Dans le code : `t.<namespace>.<clé>`.
- Assets de `core_ui` (images, animation, polices) : déclarés dans `core/core_ui/pubspec.yaml`, accessibles par la classe générée `Assets` (`Assets.images.mascot.svg()`, `Assets.animations.dsLoader.lottie()`) et `FontFamily`. Après ajout ou renommage d'un asset : `fvm dart run build_runner build` dans `core/core_ui` pour régénérer `lib/src/gen/`.
- Lancer les apps : configurations « Mobile (iOS / Android) » et « Desktop (macOS) » de `.vscode/launch.json`, ou `fvm flutter run` dans le dossier de l'app (`-d macos` pour le desktop).

## Splash screen et icône (app mobile)

Configurés dans `apps/dis_saucisse_mobile/pubspec.yaml`, images sources dans `apps/dis_saucisse_mobile/res/`.

- Splash : `fvm dart run flutter_native_splash:create`.
- Icône : `fvm dart run flutter_launcher_icons`. Ce générateur remplace à tort `ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = YES` par `= AppIcon` dans `ios/Runner.xcodeproj/project.pbxproj` : remettre `YES` après chaque génération.
- Le fond jaune est `#FFD23F` (`DsColors.mustardLight`).

## Icône (app desktop)

Configurée dans `apps/dis_saucisse_desktop/pubspec.yaml` pour macOS et Windows. L'image source `apps/dis_saucisse_desktop/res/icon/app_icon.png` suit la grille macOS (carré arrondi de 824 px avec ombre, dans une image de 1024 px aux bords transparents) : macOS n'arrondit pas les icônes lui-même.

- Icône : `fvm dart run flutter_launcher_icons` dans `apps/dis_saucisse_desktop`.

## Git

Ne jamais commit, ni proposer de commit : l'utilisateur commit lui-même.
