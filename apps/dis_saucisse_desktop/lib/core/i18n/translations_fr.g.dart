///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsFr = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	dynamic operator[](String key) => _meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$failures$fr failures = Translations$failures$fr.internal(_root);
	late final Translations$history$fr history = Translations$history$fr.internal(_root);
	late final Translations$pairing$fr pairing = Translations$pairing$fr.internal(_root);
	late final Translations$reception$fr reception = Translations$reception$fr.internal(_root);
	late final Translations$shell$fr shell = Translations$shell$fr.internal(_root);
	late final Translations$storage$fr storage = Translations$storage$fr.internal(_root);
}

// Path: failures
class Translations$failures$fr {
	Translations$failures$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Réessayer'
	String get retry => 'Réessayer';

	late final Translations$failures$history$fr history = Translations$failures$history$fr.internal(_root);
	late final Translations$failures$storageSettings$fr storageSettings = Translations$failures$storageSettings$fr.internal(_root);
	late final Translations$failures$unknown$fr unknown = Translations$failures$unknown$fr.internal(_root);
}

// Path: history
class Translations$history$fr {
	Translations$history$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$history$empty$fr empty = Translations$history$empty$fr.internal(_root);
	late final Translations$history$header$fr header = Translations$history$header$fr.internal(_root);
	late final Translations$history$stats$fr stats = Translations$history$stats$fr.internal(_root);
	late final Translations$history$transfers$fr transfers = Translations$history$transfers$fr.internal(_root);
	late final Translations$history$transferRow$fr transferRow = Translations$history$transferRow$fr.internal(_root);
	late final Translations$history$dates$fr dates = Translations$history$dates$fr.internal(_root);
}

// Path: pairing
class Translations$pairing$fr {
	Translations$pairing$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$pairing$header$fr header = Translations$pairing$header$fr.internal(_root);
	late final Translations$pairing$qrCard$fr qrCard = Translations$pairing$qrCard$fr.internal(_root);
	late final Translations$pairing$statusPill$fr statusPill = Translations$pairing$statusPill$fr.internal(_root);
	late final Translations$pairing$pairedPhones$fr pairedPhones = Translations$pairing$pairedPhones$fr.internal(_root);
	late final Translations$pairing$failed$fr failed = Translations$pairing$failed$fr.internal(_root);
}

// Path: reception
class Translations$reception$fr {
	Translations$reception$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$reception$receivedPhotos$fr receivedPhotos = Translations$reception$receivedPhotos$fr.internal(_root);
	late final Translations$reception$progress$fr progress = Translations$reception$progress$fr.internal(_root);
	late final Translations$reception$countCard$fr countCard = Translations$reception$countCard$fr.internal(_root);
	late final Translations$reception$safetyNote$fr safetyNote = Translations$reception$safetyNote$fr.internal(_root);
	late final Translations$reception$currentFolder$fr currentFolder = Translations$reception$currentFolder$fr.internal(_root);
	late final Translations$reception$done$fr done = Translations$reception$done$fr.internal(_root);
	late final Translations$reception$doneSummary$fr doneSummary = Translations$reception$doneSummary$fr.internal(_root);
}

// Path: shell
class Translations$shell$fr {
	Translations$shell$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Dis Saucisse !'
	String get appTitle => 'Dis Saucisse !';

	late final Translations$shell$navigation$fr navigation = Translations$shell$navigation$fr.internal(_root);
	late final Translations$shell$phone$fr phone = Translations$shell$phone$fr.internal(_root);
	late final Translations$shell$network$fr network = Translations$shell$network$fr.internal(_root);
	late final Translations$shell$tray$fr tray = Translations$shell$tray$fr.internal(_root);
}

// Path: storage
class Translations$storage$fr {
	Translations$storage$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$storage$header$fr header = Translations$storage$header$fr.internal(_root);
	late final Translations$storage$folderRow$fr folderRow = Translations$storage$folderRow$fr.internal(_root);
	late final Translations$storage$options$fr options = Translations$storage$options$fr.internal(_root);
	late final Translations$storage$preview$fr preview = Translations$storage$preview$fr.internal(_root);
}

// Path: failures.history
class Translations$failures$history$fr {
	Translations$failures$history$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Historique illisible'
	String get title => 'Historique illisible';

	/// fr: 'Je n’arrive pas à relire la liste des envois reçus sur ce PC. Réessaie dans un instant.'
	String get message => 'Je n’arrive pas à relire la liste des envois reçus sur ce PC. Réessaie dans un instant.';
}

// Path: failures.storageSettings
class Translations$failures$storageSettings$fr {
	Translations$failures$storageSettings$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Réglages illisibles'
	String get title => 'Réglages illisibles';

	/// fr: 'Je n’arrive pas à relire où ranger tes photos. Réessaie, et relance l’app si ça continue.'
	String get message => 'Je n’arrive pas à relire où ranger tes photos. Réessaie, et relance l’app si ça continue.';
}

// Path: failures.unknown
class Translations$failures$unknown$fr {
	Translations$failures$unknown$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Oups !'
	String get title => 'Oups !';

	/// fr: 'Quelque chose s’est mal passé. Réessaie dans un instant.'
	String get message => 'Quelque chose s’est mal passé. Réessaie dans un instant.';
}

// Path: history.empty
class Translations$history$empty$fr {
	Translations$history$empty$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Aucune photo reçue pour l’instant'
	String get title => 'Aucune photo reçue pour l’instant';

	/// fr: 'Associe ton téléphone depuis l’écran Réception, puis envoie tes photos triées : chaque envoi apparaîtra ici.'
	String get message => 'Associe ton téléphone depuis l’écran Réception, puis envoie tes photos triées : chaque envoi apparaîtra ici.';

	/// fr: 'Aller à la réception'
	String get goToReception => 'Aller à la réception';
}

// Path: history.header
class Translations$history$header$fr {
	Translations$history$header$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Tout ce qui a été reçu sur ce PC'
	String get subtitle => 'Tout ce qui a été reçu sur ce PC';

	/// fr: 'Historique'
	String get title => 'Historique';
}

// Path: history.stats
class Translations$history$stats$fr {
	Translations$history$stats$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'photos rangées en {year}'
	String photos({required Object year}) => 'photos rangées en ${year}';

	/// fr: 'événements'
	String get events => 'événements';

	/// fr: 'sur le disque'
	String get onDisk => 'sur le disque';

	/// fr: 'photo perdue'
	String get lostPhotos => 'photo perdue';
}

// Path: history.transfers
class Translations$history$transfers$fr {
	Translations$history$transfers$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Envois'
	String get title => 'Envois';
}

// Path: history.transferRow
class Translations$history$transferRow$fr {
	Translations$history$transferRow$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: '{photoCount} photos · {eventCount} événements · {size} · depuis {phoneName}'
	String summary({required Object photoCount, required Object eventCount, required Object size, required Object phoneName}) => '${photoCount} photos · ${eventCount} événements · ${size} · depuis ${phoneName}';

	/// fr: 'Tout vérifié'
	String get allVerified => 'Tout vérifié';

	/// fr: '{count} en échec'
	String failed({required Object count}) => '${count} en échec';

	/// fr: 'Ouvrir'
	String get open => 'Ouvrir';
}

// Path: history.dates
class Translations$history$dates$fr {
	Translations$history$dates$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	List<String> get weekdays => [
		'Lun.',
		'Mar.',
		'Mer.',
		'Jeu.',
		'Ven.',
		'Sam.',
		'Dim.',
	];
	List<String> get months => [
		'janv.',
		'févr.',
		'mars',
		'avr.',
		'mai',
		'juin',
		'juil.',
		'août',
		'sept.',
		'oct.',
		'nov.',
		'déc.',
	];
}

// Path: pairing.header
class Translations$pairing$header$fr {
	Translations$pairing$header$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Bonjour ! Le PC est prêt à recevoir les photos'
	String get greeting => 'Bonjour ! Le PC est prêt à recevoir les photos';

	/// fr: 'Associer un téléphone'
	String get title => 'Associer un téléphone';
}

// Path: pairing.qrCard
class Translations$pairing$qrCard$fr {
	Translations$pairing$qrCard$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Scanne avec Dis Saucisse !'
	String get title => 'Scanne avec Dis Saucisse !';

	/// fr: 'Dans l’app, touche le bouton ordinateur en haut de l’accueil.'
	String get hint => 'Dans l’app, touche le bouton ordinateur en haut de l’accueil.';
}

// Path: pairing.statusPill
class Translations$pairing$statusPill$fr {
	Translations$pairing$statusPill$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'En attente du téléphone…'
	String get waiting => 'En attente du téléphone…';

	/// fr: '{name} est associé'
	String paired({required Object name}) => '${name} est associé';
}

// Path: pairing.pairedPhones
class Translations$pairing$pairedPhones$fr {
	Translations$pairing$pairedPhones$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Téléphones associés'
	String get title => 'Téléphones associés';

	/// fr: 'Aucun téléphone pour l’instant.'
	String get empty => 'Aucun téléphone pour l’instant.';

	/// fr: 'Associé'
	String get paired => 'Associé';

	/// fr: 'Prêt'
	String get ready => 'Prêt';
}

// Path: pairing.failed
class Translations$pairing$failed$fr {
	Translations$pairing$failed$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$pairing$failed$noNetwork$fr noNetwork = Translations$pairing$failed$noNetwork$fr.internal(_root);
	late final Translations$pairing$failed$serverUnavailable$fr serverUnavailable = Translations$pairing$failed$serverUnavailable$fr.internal(_root);

	/// fr: 'Réessayer'
	String get retry => 'Réessayer';
}

// Path: reception.receivedPhotos
class Translations$reception$receivedPhotos$fr {
	Translations$reception$receivedPhotos$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'photos reçues'
	String get noEstimate => 'photos reçues';

	/// fr: 'photos reçues · encore quelques secondes'
	String get fewSeconds => 'photos reçues · encore quelques secondes';

	/// fr: 'photos reçues · encore ~{minutes} min'
	String minutes({required Object minutes}) => 'photos reçues · encore ~${minutes} min';
}

// Path: reception.progress
class Translations$reception$progress$fr {
	Translations$reception$progress$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Le téléphone attend que tu reprennes'
	String get phoneWaiting => 'Le téléphone attend que tu reprennes';

	/// fr: '{phoneName} envoie ses photos'
	String phoneSending({required Object phoneName}) => '${phoneName} envoie ses photos';

	/// fr: 'Réception en pause'
	String get titlePaused => 'Réception en pause';

	/// fr: 'Réception en cours'
	String get titleRunning => 'Réception en cours';

	/// fr: 'Reprendre'
	String get resume => 'Reprendre';

	/// fr: 'Mettre en pause'
	String get pause => 'Mettre en pause';
}

// Path: reception.countCard
class Translations$reception$countCard$fr {
	Translations$reception$countCard$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'vérifiées'
	String get verified => 'vérifiées';

	/// fr: 'erreur'
	String get errorSingle => 'erreur';

	/// fr: 'erreurs'
	String get errorSeveral => 'erreurs';

	/// fr: 'reçus'
	String get received => 'reçus';
}

// Path: reception.safetyNote
class Translations$reception$safetyNote$fr {
	Translations$reception$safetyNote$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Chaque photo est vérifiée avant d’être marquée comme rangée. '
	String get verified => 'Chaque photo est vérifiée avant d’être marquée comme rangée. ';

	/// fr: 'Rien n’est supprimé du téléphone sans son accord.'
	String get nothingDeleted => 'Rien n’est supprimé du téléphone sans son accord.';
}

// Path: reception.currentFolder
class Translations$reception$currentFolder$fr {
	Translations$reception$currentFolder$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'En train de ranger dans'
	String get storingIn => 'En train de ranger dans';

	/// fr: 'En attente de la première photo…'
	String get waitingFirstPhoto => 'En attente de la première photo…';

	/// fr: 'Événement {event} · {count} photo rangée ici'
	String eventSingle({required Object event, required Object count}) => 'Événement ${event} · ${count} photo rangée ici';

	/// fr: 'Événement {event} · {count} photos rangées ici'
	String eventSeveral({required Object event, required Object count}) => 'Événement ${event} · ${count} photos rangées ici';
}

// Path: reception.done
class Translations$reception$done$fr {
	Translations$reception$done$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Saucisse !'
	String get title => 'Saucisse !';

	/// fr: 'Ouvrir le dossier'
	String get openFolder => 'Ouvrir le dossier';

	/// fr: 'Fermer'
	String get close => 'Fermer';

	/// fr: 'Le téléphone propose maintenant de libérer de la place. Le PC n’a plus rien à faire.'
	String get phoneNext => 'Le téléphone propose maintenant de libérer de la place. Le PC n’a plus rien à faire.';
}

// Path: reception.doneSummary
class Translations$reception$doneSummary$fr {
	Translations$reception$doneSummary$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'La '
	String get articleSingle => 'La ';

	/// fr: 'Les '
	String get articleSeveral => 'Les ';

	/// fr: '1 photo'
	String get photosSingle => '1 photo';

	/// fr: '{count} photos'
	String photosSeveral({required Object count}) => '${count} photos';

	/// fr: ' du téléphone est bien rangée'
	String get storedSingle => ' du téléphone est bien rangée';

	/// fr: ' du téléphone sont bien rangées'
	String get storedSeveral => ' du téléphone sont bien rangées';

	/// fr: ' dans '
	String get inEvents => ' dans ';

	/// fr: '1 événement'
	String get eventsSingle => '1 événement';

	/// fr: '{count} événements'
	String eventsSeveral({required Object count}) => '${count} événements';

	/// fr: ', toutes vérifiées.'
	String get allVerified => ', toutes vérifiées.';

	/// fr: '. {count} photo n’a pas pu être rangée : le téléphone la renverra au prochain envoi.'
	String rejectedSingle({required Object count}) => '. ${count} photo n’a pas pu être rangée : le téléphone la renverra au prochain envoi.';

	/// fr: '. {count} photos n’ont pas pu être rangées : le téléphone les renverra au prochain envoi.'
	String rejectedSeveral({required Object count}) => '. ${count} photos n’ont pas pu être rangées : le téléphone les renverra au prochain envoi.';
}

// Path: shell.navigation
class Translations$shell$navigation$fr {
	Translations$shell$navigation$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Réception'
	String get reception => 'Réception';

	/// fr: 'Dossier de rangement'
	String get storage => 'Dossier de rangement';

	/// fr: 'Historique'
	String get history => 'Historique';
}

// Path: shell.phone
class Translations$shell$phone$fr {
	Translations$shell$phone$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Téléphone'
	String get title => 'Téléphone';

	/// fr: 'Associé'
	String get paired => 'Associé';

	/// fr: 'Pas encore associé'
	String get notPaired => 'Pas encore associé';
}

// Path: shell.network
class Translations$shell$network$fr {
	Translations$shell$network$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Réseau Wi-Fi'
	String get title => 'Réseau Wi-Fi';

	/// fr: 'Hors ligne'
	String get offline => 'Hors ligne';
}

// Path: shell.tray
class Translations$shell$tray$fr {
	Translations$shell$tray$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Dis Saucisse ! est prêt à recevoir des photos'
	String get tooltip => 'Dis Saucisse ! est prêt à recevoir des photos';

	/// fr: 'Ouvrir Dis Saucisse !'
	String get open => 'Ouvrir Dis Saucisse !';

	/// fr: 'Quitter'
	String get quit => 'Quitter';
}

// Path: storage.header
class Translations$storage$header$fr {
	Translations$storage$header$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Choisis où et comment les photos sont classées'
	String get subtitle => 'Choisis où et comment les photos sont classées';

	/// fr: 'Dossier de rangement'
	String get title => 'Dossier de rangement';
}

// Path: storage.folderRow
class Translations$storage$folderRow$fr {
	Translations$storage$folderRow$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Dossier principal'
	String get label => 'Dossier principal';

	/// fr: 'Images / Dis Saucisse'
	String get defaultPath => 'Images / Dis Saucisse';

	/// fr: 'Dossier proposé par défaut'
	String get defaultFolder => 'Dossier proposé par défaut';

	/// fr: 'Choisi par toi'
	String get chosenFolder => 'Choisi par toi';

	/// fr: 'Parcourir…'
	String get browse => 'Parcourir…';
}

// Path: storage.options
class Translations$storage$options$fr {
	Translations$storage$options$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Dossier par année'
	String get byYear => 'Dossier par année';

	late final Translations$storage$options$byMonth$fr byMonth = Translations$storage$options$byMonth$fr.internal(_root);
	late final Translations$storage$options$byEvent$fr byEvent = Translations$storage$options$byEvent$fr.internal(_root);
	late final Translations$storage$options$discarded$fr discarded = Translations$storage$options$discarded$fr.internal(_root);
	late final Translations$storage$options$renameFiles$fr renameFiles = Translations$storage$options$renameFiles$fr.internal(_root);
}

// Path: storage.preview
class Translations$storage$preview$fr {
	Translations$storage$preview$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Aperçu'
	String get title => 'Aperçu';

	/// fr: 'avec les photos de novembre'
	String get subtitle => 'avec les photos de novembre';

	/// fr: 'Toutes les photos au même endroit'
	String get allInOnePlace => 'Toutes les photos au même endroit';

	/// fr: 'Les dossiers déjà existants sont réutilisés, rien n’est jamais écrasé.'
	String get noOverwrite => 'Les dossiers déjà existants sont réutilisés, rien n’est jamais écrasé.';
}

// Path: pairing.failed.noNetwork
class Translations$pairing$failed$noNetwork$fr {
	Translations$pairing$failed$noNetwork$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Pas de réseau Wi-Fi'
	String get title => 'Pas de réseau Wi-Fi';

	/// fr: 'Connecte l’ordinateur au Wi-Fi de la maison, puis réessaie.'
	String get message => 'Connecte l’ordinateur au Wi-Fi de la maison, puis réessaie.';
}

// Path: pairing.failed.serverUnavailable
class Translations$pairing$failed$serverUnavailable$fr {
	Translations$pairing$failed$serverUnavailable$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Réception impossible'
	String get title => 'Réception impossible';

	/// fr: 'Une autre copie de Dis Saucisse ! est peut-être déjà ouverte sur cet ordinateur.'
	String get message => 'Une autre copie de Dis Saucisse ! est peut-être déjà ouverte sur cet ordinateur.';
}

// Path: storage.options.byMonth
class Translations$storage$options$byMonth$fr {
	Translations$storage$options$byMonth$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Dossier par mois'
	String get title => 'Dossier par mois';

	/// fr: 'Choisis le format du nom'
	String get subtitle => 'Choisis le format du nom';
}

// Path: storage.options.byEvent
class Translations$storage$options$byEvent$fr {
	Translations$storage$options$byEvent$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Dossier par événement'
	String get title => 'Dossier par événement';

	/// fr: 'Daté et nommé : 2026-11-08 Anniversaire de mamie'
	String get subtitle => 'Daté et nommé : 2026-11-08 Anniversaire de mamie';
}

// Path: storage.options.discarded
class Translations$storage$options$discarded$fr {
	Translations$storage$options$discarded$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Photos écartées'
	String get title => 'Photos écartées';

	/// fr: 'Rangées dans un sous-dossier « {folderName} »'
	String inSubfolder({required Object folderName}) => 'Rangées dans un sous-dossier « ${folderName} »';

	/// fr: 'Rangées avec les autres photos'
	String get withOthers => 'Rangées avec les autres photos';
}

// Path: storage.options.renameFiles
class Translations$storage$options$renameFiles$fr {
	Translations$storage$options$renameFiles$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Renommer les fichiers'
	String get title => 'Renommer les fichiers';

	/// fr: 'Avec la date de prise de vue (2026-11-08 14.30.12.jpg)'
	String get withDate => 'Avec la date de prise de vue (2026-11-08 14.30.12.jpg)';

	/// fr: 'Garder les noms d’origine (IMG_2034.jpg)'
	String get keepOriginal => 'Garder les noms d’origine (IMG_2034.jpg)';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'failures.retry' => 'Réessayer',
			'failures.history.title' => 'Historique illisible',
			'failures.history.message' => 'Je n’arrive pas à relire la liste des envois reçus sur ce PC. Réessaie dans un instant.',
			'failures.storageSettings.title' => 'Réglages illisibles',
			'failures.storageSettings.message' => 'Je n’arrive pas à relire où ranger tes photos. Réessaie, et relance l’app si ça continue.',
			'failures.unknown.title' => 'Oups !',
			'failures.unknown.message' => 'Quelque chose s’est mal passé. Réessaie dans un instant.',
			'history.empty.title' => 'Aucune photo reçue pour l’instant',
			'history.empty.message' => 'Associe ton téléphone depuis l’écran Réception, puis envoie tes photos triées : chaque envoi apparaîtra ici.',
			'history.empty.goToReception' => 'Aller à la réception',
			'history.header.subtitle' => 'Tout ce qui a été reçu sur ce PC',
			'history.header.title' => 'Historique',
			'history.stats.photos' => ({required Object year}) => 'photos rangées en ${year}',
			'history.stats.events' => 'événements',
			'history.stats.onDisk' => 'sur le disque',
			'history.stats.lostPhotos' => 'photo perdue',
			'history.transfers.title' => 'Envois',
			'history.transferRow.summary' => ({required Object photoCount, required Object eventCount, required Object size, required Object phoneName}) => '${photoCount} photos · ${eventCount} événements · ${size} · depuis ${phoneName}',
			'history.transferRow.allVerified' => 'Tout vérifié',
			'history.transferRow.failed' => ({required Object count}) => '${count} en échec',
			'history.transferRow.open' => 'Ouvrir',
			'history.dates.weekdays.0' => 'Lun.',
			'history.dates.weekdays.1' => 'Mar.',
			'history.dates.weekdays.2' => 'Mer.',
			'history.dates.weekdays.3' => 'Jeu.',
			'history.dates.weekdays.4' => 'Ven.',
			'history.dates.weekdays.5' => 'Sam.',
			'history.dates.weekdays.6' => 'Dim.',
			'history.dates.months.0' => 'janv.',
			'history.dates.months.1' => 'févr.',
			'history.dates.months.2' => 'mars',
			'history.dates.months.3' => 'avr.',
			'history.dates.months.4' => 'mai',
			'history.dates.months.5' => 'juin',
			'history.dates.months.6' => 'juil.',
			'history.dates.months.7' => 'août',
			'history.dates.months.8' => 'sept.',
			'history.dates.months.9' => 'oct.',
			'history.dates.months.10' => 'nov.',
			'history.dates.months.11' => 'déc.',
			'pairing.header.greeting' => 'Bonjour ! Le PC est prêt à recevoir les photos',
			'pairing.header.title' => 'Associer un téléphone',
			'pairing.qrCard.title' => 'Scanne avec Dis Saucisse !',
			'pairing.qrCard.hint' => 'Dans l’app, touche le bouton ordinateur en haut de l’accueil.',
			'pairing.statusPill.waiting' => 'En attente du téléphone…',
			'pairing.statusPill.paired' => ({required Object name}) => '${name} est associé',
			'pairing.pairedPhones.title' => 'Téléphones associés',
			'pairing.pairedPhones.empty' => 'Aucun téléphone pour l’instant.',
			'pairing.pairedPhones.paired' => 'Associé',
			'pairing.pairedPhones.ready' => 'Prêt',
			'pairing.failed.noNetwork.title' => 'Pas de réseau Wi-Fi',
			'pairing.failed.noNetwork.message' => 'Connecte l’ordinateur au Wi-Fi de la maison, puis réessaie.',
			'pairing.failed.serverUnavailable.title' => 'Réception impossible',
			'pairing.failed.serverUnavailable.message' => 'Une autre copie de Dis Saucisse ! est peut-être déjà ouverte sur cet ordinateur.',
			'pairing.failed.retry' => 'Réessayer',
			'reception.receivedPhotos.noEstimate' => 'photos reçues',
			'reception.receivedPhotos.fewSeconds' => 'photos reçues · encore quelques secondes',
			'reception.receivedPhotos.minutes' => ({required Object minutes}) => 'photos reçues · encore ~${minutes} min',
			'reception.progress.phoneWaiting' => 'Le téléphone attend que tu reprennes',
			'reception.progress.phoneSending' => ({required Object phoneName}) => '${phoneName} envoie ses photos',
			'reception.progress.titlePaused' => 'Réception en pause',
			'reception.progress.titleRunning' => 'Réception en cours',
			'reception.progress.resume' => 'Reprendre',
			'reception.progress.pause' => 'Mettre en pause',
			'reception.countCard.verified' => 'vérifiées',
			'reception.countCard.errorSingle' => 'erreur',
			'reception.countCard.errorSeveral' => 'erreurs',
			'reception.countCard.received' => 'reçus',
			'reception.safetyNote.verified' => 'Chaque photo est vérifiée avant d’être marquée comme rangée. ',
			'reception.safetyNote.nothingDeleted' => 'Rien n’est supprimé du téléphone sans son accord.',
			'reception.currentFolder.storingIn' => 'En train de ranger dans',
			'reception.currentFolder.waitingFirstPhoto' => 'En attente de la première photo…',
			'reception.currentFolder.eventSingle' => ({required Object event, required Object count}) => 'Événement ${event} · ${count} photo rangée ici',
			'reception.currentFolder.eventSeveral' => ({required Object event, required Object count}) => 'Événement ${event} · ${count} photos rangées ici',
			'reception.done.title' => 'Saucisse !',
			'reception.done.openFolder' => 'Ouvrir le dossier',
			'reception.done.close' => 'Fermer',
			'reception.done.phoneNext' => 'Le téléphone propose maintenant de libérer de la place. Le PC n’a plus rien à faire.',
			'reception.doneSummary.articleSingle' => 'La ',
			'reception.doneSummary.articleSeveral' => 'Les ',
			'reception.doneSummary.photosSingle' => '1 photo',
			'reception.doneSummary.photosSeveral' => ({required Object count}) => '${count} photos',
			'reception.doneSummary.storedSingle' => ' du téléphone est bien rangée',
			'reception.doneSummary.storedSeveral' => ' du téléphone sont bien rangées',
			'reception.doneSummary.inEvents' => ' dans ',
			'reception.doneSummary.eventsSingle' => '1 événement',
			'reception.doneSummary.eventsSeveral' => ({required Object count}) => '${count} événements',
			'reception.doneSummary.allVerified' => ', toutes vérifiées.',
			'reception.doneSummary.rejectedSingle' => ({required Object count}) => '. ${count} photo n’a pas pu être rangée : le téléphone la renverra au prochain envoi.',
			'reception.doneSummary.rejectedSeveral' => ({required Object count}) => '. ${count} photos n’ont pas pu être rangées : le téléphone les renverra au prochain envoi.',
			'shell.appTitle' => 'Dis Saucisse !',
			'shell.navigation.reception' => 'Réception',
			'shell.navigation.storage' => 'Dossier de rangement',
			'shell.navigation.history' => 'Historique',
			'shell.phone.title' => 'Téléphone',
			'shell.phone.paired' => 'Associé',
			'shell.phone.notPaired' => 'Pas encore associé',
			'shell.network.title' => 'Réseau Wi-Fi',
			'shell.network.offline' => 'Hors ligne',
			'shell.tray.tooltip' => 'Dis Saucisse ! est prêt à recevoir des photos',
			'shell.tray.open' => 'Ouvrir Dis Saucisse !',
			'shell.tray.quit' => 'Quitter',
			'storage.header.subtitle' => 'Choisis où et comment les photos sont classées',
			'storage.header.title' => 'Dossier de rangement',
			'storage.folderRow.label' => 'Dossier principal',
			'storage.folderRow.defaultPath' => 'Images / Dis Saucisse',
			'storage.folderRow.defaultFolder' => 'Dossier proposé par défaut',
			'storage.folderRow.chosenFolder' => 'Choisi par toi',
			'storage.folderRow.browse' => 'Parcourir…',
			'storage.options.byYear' => 'Dossier par année',
			'storage.options.byMonth.title' => 'Dossier par mois',
			'storage.options.byMonth.subtitle' => 'Choisis le format du nom',
			'storage.options.byEvent.title' => 'Dossier par événement',
			'storage.options.byEvent.subtitle' => 'Daté et nommé : 2026-11-08 Anniversaire de mamie',
			'storage.options.discarded.title' => 'Photos écartées',
			'storage.options.discarded.inSubfolder' => ({required Object folderName}) => 'Rangées dans un sous-dossier « ${folderName} »',
			'storage.options.discarded.withOthers' => 'Rangées avec les autres photos',
			'storage.options.renameFiles.title' => 'Renommer les fichiers',
			'storage.options.renameFiles.withDate' => 'Avec la date de prise de vue (2026-11-08 14.30.12.jpg)',
			'storage.options.renameFiles.keepOriginal' => 'Garder les noms d’origine (IMG_2034.jpg)',
			'storage.preview.title' => 'Aperçu',
			'storage.preview.subtitle' => 'avec les photos de novembre',
			'storage.preview.allInOnePlace' => 'Toutes les photos au même endroit',
			'storage.preview.noOverwrite' => 'Les dossiers déjà existants sont réutilisés, rien n’est jamais écrasé.',
			_ => null,
		};
	}
}
