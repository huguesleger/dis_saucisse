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
	late final Translations$burstSort$fr burstSort = Translations$burstSort$fr.internal(_root);
	late final Translations$events$fr events = Translations$events$fr.internal(_root);
	late final Translations$failures$fr failures = Translations$failures$fr.internal(_root);
	late final Translations$freeSpace$fr freeSpace = Translations$freeSpace$fr.internal(_root);
	late final Translations$home$fr home = Translations$home$fr.internal(_root);
	late final Translations$memories$fr memories = Translations$memories$fr.internal(_root);
	late final Translations$navigation$fr navigation = Translations$navigation$fr.internal(_root);
	late final Translations$pairing$fr pairing = Translations$pairing$fr.internal(_root);
	late final Translations$quality$fr quality = Translations$quality$fr.internal(_root);
	late final Translations$settings$fr settings = Translations$settings$fr.internal(_root);
	late final Translations$sorting$fr sorting = Translations$sorting$fr.internal(_root);
	late final Translations$transfer$fr transfer = Translations$transfer$fr.internal(_root);
}

// Path: burstSort
class Translations$burstSort$fr {
	Translations$burstSort$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Retour à l'accueil'
	String get backHome => 'Retour à l\'accueil';

	/// fr: 'Rafale {position} sur {count}'
	String burstPosition({required Object position, required Object count}) => 'Rafale ${position} sur ${count}';

	late final Translations$burstSort$finished$fr finished = Translations$burstSort$finished$fr.internal(_root);
	late final Translations$burstSort$sheet$fr sheet = Translations$burstSort$sheet$fr.internal(_root);
}

// Path: events
class Translations$events$fr {
	Translations$events$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Du {startDay} au {endDate}'
	String dateRangeTitle({required Object startDay, required Object endDate}) => 'Du ${startDay} au ${endDate}';

	late final Translations$events$subtitle$fr subtitle = Translations$events$subtitle$fr.internal(_root);
	late final Translations$events$burstsToSort$fr burstsToSort = Translations$events$burstsToSort$fr.internal(_root);
	late final Translations$events$monthEventCount$fr monthEventCount = Translations$events$monthEventCount$fr.internal(_root);
	late final Translations$events$actions$fr actions = Translations$events$actions$fr.internal(_root);
	late final Translations$events$nameSheet$fr nameSheet = Translations$events$nameSheet$fr.internal(_root);
	late final Translations$events$splitSheet$fr splitSheet = Translations$events$splitSheet$fr.internal(_root);
	late final Translations$events$splitOption$fr splitOption = Translations$events$splitOption$fr.internal(_root);
}

// Path: failures
class Translations$failures$fr {
	Translations$failures$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Réessayer'
	String get retry => 'Réessayer';

	late final Translations$failures$accessDenied$fr accessDenied = Translations$failures$accessDenied$fr.internal(_root);
	late final Translations$failures$libraryUnavailable$fr libraryUnavailable = Translations$failures$libraryUnavailable$fr.internal(_root);
	late final Translations$failures$analysis$fr analysis = Translations$failures$analysis$fr.internal(_root);
	late final Translations$failures$deletion$fr deletion = Translations$failures$deletion$fr.internal(_root);
	late final Translations$failures$history$fr history = Translations$failures$history$fr.internal(_root);
	late final Translations$failures$computerUnreachable$fr computerUnreachable = Translations$failures$computerUnreachable$fr.internal(_root);
	late final Translations$failures$storage$fr storage = Translations$failures$storage$fr.internal(_root);
	late final Translations$failures$unknown$fr unknown = Translations$failures$unknown$fr.internal(_root);
}

// Path: freeSpace
class Translations$freeSpace$fr {
	Translations$freeSpace$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$freeSpace$ready$fr ready = Translations$freeSpace$ready$fr.internal(_root);
	late final Translations$freeSpace$nothingToFree$fr nothingToFree = Translations$freeSpace$nothingToFree$fr.internal(_root);
	late final Translations$freeSpace$done$fr done = Translations$freeSpace$done$fr.internal(_root);
}

// Path: home
class Translations$home$fr {
	Translations$home$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$home$accessDenied$fr accessDenied = Translations$home$accessDenied$fr.internal(_root);

	/// fr: 'Coucou ! Prête pour le tri ?'
	String get greeting => 'Coucou ! Prête pour le tri ?';

	late final Translations$home$photosToSort$fr photosToSort = Translations$home$photosToSort$fr.internal(_root);
	late final Translations$home$quality$fr quality = Translations$home$quality$fr.internal(_root);
	late final Translations$home$topBar$fr topBar = Translations$home$topBar$fr.internal(_root);

	/// fr: 'Tout'
	String get allMonths => 'Tout';

	/// fr: 'Tout est trié pour le moment. Saucisse !'
	String get allSorted => 'Tout est trié pour le moment. Saucisse !';

	/// fr: 'Lancer le tri'
	String get startSorting => 'Lancer le tri';
}

// Path: memories
class Translations$memories$fr {
	Translations$memories$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$memories$photoCount$fr photoCount = Translations$memories$photoCount$fr.internal(_root);
	late final Translations$memories$eventCount$fr eventCount = Translations$memories$eventCount$fr.internal(_root);

	/// fr: 'Envoyé le {date}'
	String sentOn({required Object date}) => 'Envoyé le ${date}';

	late final Translations$memories$empty$fr empty = Translations$memories$empty$fr.internal(_root);
	late final Translations$memories$header$fr header = Translations$memories$header$fr.internal(_root);

	/// fr: 'Tout'
	String get allYears => 'Tout';

	late final Translations$memories$monthCard$fr monthCard = Translations$memories$monthCard$fr.internal(_root);
	late final Translations$memories$recap$fr recap = Translations$memories$recap$fr.internal(_root);
	late final Translations$memories$months$fr months = Translations$memories$months$fr.internal(_root);
}

// Path: navigation
class Translations$navigation$fr {
	Translations$navigation$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Photos à trier'
	String get photos => 'Photos à trier';

	/// fr: 'Souvenirs'
	String get memories => 'Souvenirs';

	/// fr: 'Réglages'
	String get settings => 'Réglages';
}

// Path: pairing
class Translations$pairing$fr {
	Translations$pairing$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Association avec {computerName}…'
	String pairingWith({required Object computerName}) => 'Association avec ${computerName}…';

	late final Translations$pairing$paired$fr paired = Translations$pairing$paired$fr.internal(_root);
	late final Translations$pairing$invalidCode$fr invalidCode = Translations$pairing$invalidCode$fr.internal(_root);
	late final Translations$pairing$unreachable$fr unreachable = Translations$pairing$unreachable$fr.internal(_root);
	late final Translations$pairing$refused$fr refused = Translations$pairing$refused$fr.internal(_root);

	/// fr: 'Réessayer'
	String get retry => 'Réessayer';

	late final Translations$pairing$topBar$fr topBar = Translations$pairing$topBar$fr.internal(_root);
	late final Translations$pairing$help$fr help = Translations$pairing$help$fr.internal(_root);
}

// Path: quality
class Translations$quality$fr {
	Translations$quality$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$quality$title$fr title = Translations$quality$title$fr.internal(_root);
	late final Translations$quality$intro$fr intro = Translations$quality$intro$fr.internal(_root);
	late final Translations$quality$empty$fr empty = Translations$quality$empty$fr.internal(_root);
	late final Translations$quality$photoCount$fr photoCount = Translations$quality$photoCount$fr.internal(_root);
	late final Translations$quality$done$fr done = Translations$quality$done$fr.internal(_root);
	late final Translations$quality$review$fr review = Translations$quality$review$fr.internal(_root);
	late final Translations$quality$photoTile$fr photoTile = Translations$quality$photoTile$fr.internal(_root);
}

// Path: settings
class Translations$settings$fr {
	Translations$settings$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$settings$header$fr header = Translations$settings$header$fr.internal(_root);
	late final Translations$settings$computer$fr computer = Translations$settings$computer$fr.internal(_root);
	late final Translations$settings$sorting$fr sorting = Translations$settings$sorting$fr.internal(_root);
	late final Translations$settings$startDateSheet$fr startDateSheet = Translations$settings$startDateSheet$fr.internal(_root);
	late final Translations$settings$ignored$fr ignored = Translations$settings$ignored$fr.internal(_root);
	late final Translations$settings$afterSending$fr afterSending = Translations$settings$afterSending$fr.internal(_root);
}

// Path: sorting
class Translations$sorting$fr {
	Translations$sorting$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$sorting$header$fr header = Translations$sorting$header$fr.internal(_root);

	/// fr: 'Tes photos restent chez toi : elles ne partent que vers ton ordinateur, par ton Wi-Fi.'
	String get privacyNote => 'Tes photos restent chez toi : elles ne partent que vers ton ordinateur, par ton Wi-Fi.';

	/// fr: 'C'est parti !'
	String get start => 'C\'est parti !';

	late final Translations$sorting$status$fr status = Translations$sorting$status$fr.internal(_root);
	late final Translations$sorting$options$fr options = Translations$sorting$options$fr.internal(_root);
}

// Path: transfer
class Translations$transfer$fr {
	Translations$transfer$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Retour à l’accueil'
	String get backHome => 'Retour à l’accueil';

	/// fr: 'Réessayer'
	String get retry => 'Réessayer';

	late final Translations$transfer$needsPairing$fr needsPairing = Translations$transfer$needsPairing$fr.internal(_root);
	late final Translations$transfer$nothingToSend$fr nothingToSend = Translations$transfer$nothingToSend$fr.internal(_root);
	late final Translations$transfer$unreachable$fr unreachable = Translations$transfer$unreachable$fr.internal(_root);
	late final Translations$transfer$failed$fr failed = Translations$transfer$failed$fr.internal(_root);
	late final Translations$transfer$header$fr header = Translations$transfer$header$fr.internal(_root);
	late final Translations$transfer$remainingTime$fr remainingTime = Translations$transfer$remainingTime$fr.internal(_root);
	late final Translations$transfer$details$fr details = Translations$transfer$details$fr.internal(_root);
	late final Translations$transfer$done$fr done = Translations$transfer$done$fr.internal(_root);
}

// Path: burstSort.finished
class Translations$burstSort$finished$fr {
	Translations$burstSort$finished$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Tout est trié !'
	String get title => 'Tout est trié !';

	/// fr: 'Bravo, il ne reste plus aucune rafale à trier ici.'
	String get message => 'Bravo, il ne reste plus aucune rafale à trier ici.';
}

// Path: burstSort.sheet
class Translations$burstSort$sheet$fr {
	Translations$burstSort$sheet$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$burstSort$sheet$photoCount$fr photoCount = Translations$burstSort$sheet$photoCount$fr.internal(_root);

	/// fr: 'Glisse vers le haut pour garder, vers le bas pour écarter'
	String get swipeHint => 'Glisse vers le haut pour garder, vers le bas pour écarter';

	/// fr: 'Écarter'
	String get discard => 'Écarter';

	/// fr: 'Garder'
	String get keep => 'Garder';
}

// Path: events.subtitle
class Translations$events$subtitle$fr {
	Translations$events$subtitle$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: '{dates} · {count} photo'
	String single({required Object dates, required Object count}) => '${dates} · ${count} photo';

	/// fr: '{dates} · {count} photos'
	String several({required Object dates, required Object count}) => '${dates} · ${count} photos';
}

// Path: events.burstsToSort
class Translations$events$burstsToSort$fr {
	Translations$events$burstsToSort$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: '1 rafale à trier'
	String get single => '1 rafale à trier';

	/// fr: '{count} rafales à trier'
	String several({required Object count}) => '${count} rafales à trier';
}

// Path: events.monthEventCount
class Translations$events$monthEventCount$fr {
	Translations$events$monthEventCount$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: '1 événement'
	String get single => '1 événement';

	/// fr: '{count} événements'
	String several({required Object count}) => '${count} événements';
}

// Path: events.actions
class Translations$events$actions$fr {
	Translations$events$actions$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Renommer'
	String get rename => 'Renommer';

	/// fr: 'Fusionner avec l'événement d'avant'
	String get mergeWithPrevious => 'Fusionner avec l\'événement d\'avant';

	/// fr: 'Fusionner avec l'événement d'après'
	String get mergeWithNext => 'Fusionner avec l\'événement d\'après';

	/// fr: 'Séparer en deux'
	String get split => 'Séparer en deux';

	/// fr: 'Choisis la rafale qui commence le nouvel événement'
	String get splitHint => 'Choisis la rafale qui commence le nouvel événement';
}

// Path: events.nameSheet
class Translations$events$nameSheet$fr {
	Translations$events$nameSheet$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Nomme l'événement'
	String get title => 'Nomme l\'événement';

	/// fr: 'Enregistrer'
	String get save => 'Enregistrer';
}

// Path: events.splitSheet
class Translations$events$splitSheet$fr {
	Translations$events$splitSheet$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Où commence le nouvel événement ?'
	String get title => 'Où commence le nouvel événement ?';

	/// fr: 'Tout ce qui suit la rafale choisie part dans le nouvel événement.'
	String get subtitle => 'Tout ce qui suit la rafale choisie part dans le nouvel événement.';
}

// Path: events.splitOption
class Translations$events$splitOption$fr {
	Translations$events$splitOption$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: '{day} à {time}'
	String startedAt({required Object day, required Object time}) => '${day} à ${time}';

	/// fr: '1 photo'
	String get photoSingle => '1 photo';

	/// fr: '{count} photos'
	String photoSeveral({required Object count}) => '${count} photos';
}

// Path: failures.accessDenied
class Translations$failures$accessDenied$fr {
	Translations$failures$accessDenied$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Je n’ai pas accès à tes photos'
	String get title => 'Je n’ai pas accès à tes photos';

	/// fr: 'Autorise Dis Saucisse ! à lire tes photos dans les réglages du téléphone, puis reviens ici.'
	String get message => 'Autorise Dis Saucisse ! à lire tes photos dans les réglages du téléphone, puis reviens ici.';
}

// Path: failures.libraryUnavailable
class Translations$failures$libraryUnavailable$fr {
	Translations$failures$libraryUnavailable$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Tes photos ne répondent pas'
	String get title => 'Tes photos ne répondent pas';

	/// fr: 'Je n’arrive pas à lire la photothèque du téléphone. Réessaie dans un instant.'
	String get message => 'Je n’arrive pas à lire la photothèque du téléphone. Réessaie dans un instant.';
}

// Path: failures.analysis
class Translations$failures$analysis$fr {
	Translations$failures$analysis$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Analyse impossible'
	String get title => 'Analyse impossible';

	/// fr: 'Je n’ai pas réussi à examiner tes photos. Réessaie dans un instant.'
	String get message => 'Je n’ai pas réussi à examiner tes photos. Réessaie dans un instant.';
}

// Path: failures.deletion
class Translations$failures$deletion$fr {
	Translations$failures$deletion$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Rien n’a été supprimé'
	String get title => 'Rien n’a été supprimé';

	/// fr: 'La suppression a été annulée ou n’a pas abouti. Tes photos sont toujours là.'
	String get message => 'La suppression a été annulée ou n’a pas abouti. Tes photos sont toujours là.';
}

// Path: failures.history
class Translations$failures$history$fr {
	Translations$failures$history$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Souvenirs introuvables'
	String get title => 'Souvenirs introuvables';

	/// fr: 'Je n’arrive pas à retrouver la liste des photos déjà envoyées sur ton PC.'
	String get message => 'Je n’arrive pas à retrouver la liste des photos déjà envoyées sur ton PC.';
}

// Path: failures.computerUnreachable
class Translations$failures$computerUnreachable$fr {
	Translations$failures$computerUnreachable$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'PC introuvable'
	String get title => 'PC introuvable';

	/// fr: 'Vérifie que le PC est allumé, que l’app est ouverte et que vous êtes sur le même Wi-Fi.'
	String get message => 'Vérifie que le PC est allumé, que l’app est ouverte et que vous êtes sur le même Wi-Fi.';
}

// Path: failures.storage
class Translations$failures$storage$fr {
	Translations$failures$storage$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Je perds le fil'
	String get title => 'Je perds le fil';

	/// fr: 'Je n’arrive pas à relire ce que j’ai noté sur le téléphone. Réessaie, et relance l’app si ça continue.'
	String get message => 'Je n’arrive pas à relire ce que j’ai noté sur le téléphone. Réessaie, et relance l’app si ça continue.';
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

// Path: freeSpace.ready
class Translations$freeSpace$ready$fr {
	Translations$freeSpace$ready$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Libérer de la place'
	String get title => 'Libérer de la place';

	/// fr: 'Ces photos sont déjà rangées et vérifiées sur ton ordinateur.'
	String get subtitle => 'Ces photos sont déjà rangées et vérifiées sur ton ordinateur.';

	/// fr: '{count} photos gardées'
	String kept({required Object count}) => '${count} photos gardées';

	/// fr: 'Supprimer aussi les {count} écartées'
	String deleteDiscarded({required Object count}) => 'Supprimer aussi les ${count} écartées';

	/// fr: 'Elles partent dans la corbeille du téléphone : tu peux les récupérer pendant 30 jours.'
	String get trashNote => 'Elles partent dans la corbeille du téléphone : tu peux les récupérer pendant 30 jours.';

	/// fr: 'Libérer {size}'
	String free({required Object size}) => 'Libérer ${size}';

	/// fr: 'Garder sur le téléphone'
	String get keep => 'Garder sur le téléphone';
}

// Path: freeSpace.nothingToFree
class Translations$freeSpace$nothingToFree$fr {
	Translations$freeSpace$nothingToFree$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Rien à libérer'
	String get title => 'Rien à libérer';

	/// fr: 'Envoie d’abord des photos sur ton ordinateur : tu pourras ensuite faire de la place.'
	String get message => 'Envoie d’abord des photos sur ton ordinateur : tu pourras ensuite faire de la place.';
}

// Path: freeSpace.done
class Translations$freeSpace$done$fr {
	Translations$freeSpace$done$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: '{size} libérés !'
	String title({required Object size}) => '${size} libérés !';

	/// fr: '{count} photos sont dans la corbeille du téléphone. Elles restent rangées sur ton ordinateur.'
	String message({required Object count}) => '${count} photos sont dans la corbeille du téléphone. Elles restent rangées sur ton ordinateur.';
}

// Path: home.accessDenied
class Translations$home$accessDenied$fr {
	Translations$home$accessDenied$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Je n'ai pas accès à tes photos'
	String get title => 'Je n\'ai pas accès à tes photos';

	/// fr: 'Autorise Dis Saucisse ! à lire tes photos dans les réglages, puis reviens ici.'
	String get message => 'Autorise Dis Saucisse ! à lire tes photos dans les réglages, puis reviens ici.';

	/// fr: 'Ouvrir les réglages'
	String get openSettings => 'Ouvrir les réglages';

	/// fr: 'C'est fait, réessayer'
	String get retry => 'C\'est fait, réessayer';
}

// Path: home.photosToSort
class Translations$home$photosToSort$fr {
	Translations$home$photosToSort$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Aucune photo à trier'
	String get zero => 'Aucune photo\nà trier';

	/// fr: '1 photo à trier'
	String get single => '1 photo\nà trier';

	/// fr: '{count} photos à trier'
	String several({required Object count}) => '${count} photos\nà trier';
}

// Path: home.quality
class Translations$home$quality$fr {
	Translations$home$quality$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'doublons'
	String get duplicates => 'doublons';

	/// fr: 'photos floues'
	String get blurry => 'photos floues';

	/// fr: 'Analyse en cours… encore 1 photo'
	String get analyzingSingle => 'Analyse en cours… encore 1 photo';

	/// fr: 'Analyse en cours… encore {count} photos'
	String analyzingSeveral({required Object count}) => 'Analyse en cours… encore ${count} photos';
}

// Path: home.topBar
class Translations$home$topBar$fr {
	Translations$home$topBar$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Calendrier'
	String get calendar => 'Calendrier';

	/// fr: 'Ordinateur'
	String get computer => 'Ordinateur';
}

// Path: memories.photoCount
class Translations$memories$photoCount$fr {
	Translations$memories$photoCount$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: '1 photo'
	String get single => '1 photo';

	/// fr: '{count} photos'
	String several({required Object count}) => '${count} photos';
}

// Path: memories.eventCount
class Translations$memories$eventCount$fr {
	Translations$memories$eventCount$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'aucun événement'
	String get zero => 'aucun événement';

	/// fr: '1 événement'
	String get single => '1 événement';

	/// fr: '{count} événements'
	String several({required Object count}) => '${count} événements';
}

// Path: memories.empty
class Translations$memories$empty$fr {
	Translations$memories$empty$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Pas encore de souvenirs'
	String get title => 'Pas encore de souvenirs';

	/// fr: 'Envoie tes premières photos sur le PC : elles apparaîtront ici, rangées par mois.'
	String get message => 'Envoie tes premières photos sur le PC : elles apparaîtront ici, rangées par mois.';
}

// Path: memories.header
class Translations$memories$header$fr {
	Translations$memories$header$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Tout ce qui est rangé sur le PC'
	String get caption => 'Tout ce qui est rangé sur le PC';

	/// fr: '{photos} à l’abri'
	String photosSafe({required Object photos}) => '${photos}\nà l’abri';
}

// Path: memories.monthCard
class Translations$memories$monthCard$fr {
	Translations$memories$monthCard$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Sur le PC'
	String get onComputer => 'Sur le PC';
}

// Path: memories.recap
class Translations$memories$recap$fr {
	Translations$memories$recap$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'RÉCAP DU MOIS'
	String get caption => 'RÉCAP DU MOIS';

	/// fr: 'Ton mois de {month}'
	String title({required Object month}) => 'Ton mois de ${month}';

	/// fr: 'photo'
	String get photoSingle => 'photo';

	/// fr: 'photos'
	String get photoSeveral => 'photos';

	/// fr: 'événement'
	String get eventSingle => 'événement';

	/// fr: 'événements'
	String get eventSeveral => 'événements';

	/// fr: 'rangés'
	String get stored => 'rangés';
}

// Path: memories.months
class Translations$memories$months$fr {
	Translations$memories$months$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Mois rangés'
	String get title => 'Mois rangés';

	/// fr: '1 mois'
	String get countSingle => '1 mois';

	/// fr: '{count} mois'
	String countSeveral({required Object count}) => '${count} mois';
}

// Path: pairing.paired
class Translations$pairing$paired$fr {
	Translations$pairing$paired$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'C’est fait !'
	String get title => 'C’est fait !';

	/// fr: 'Ton téléphone est associé à {computerName}. Tu pourras y envoyer tes photos triées.'
	String message({required Object computerName}) => 'Ton téléphone est associé à ${computerName}. Tu pourras y envoyer tes photos triées.';

	/// fr: 'Retour à l’accueil'
	String get backHome => 'Retour à l’accueil';
}

// Path: pairing.invalidCode
class Translations$pairing$invalidCode$fr {
	Translations$pairing$invalidCode$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Ce n’est pas le bon QR code'
	String get title => 'Ce n’est pas le bon QR code';

	/// fr: 'Scanne le QR code affiché dans l’app Dis Saucisse ! sur ton PC.'
	String get message => 'Scanne le QR code affiché dans l’app Dis Saucisse ! sur ton PC.';
}

// Path: pairing.unreachable
class Translations$pairing$unreachable$fr {
	Translations$pairing$unreachable$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'PC introuvable'
	String get title => 'PC introuvable';

	/// fr: 'Vérifie que le PC est allumé, que l’app est ouverte et que vous êtes sur le même Wi-Fi.'
	String get message => 'Vérifie que le PC est allumé, que l’app est ouverte et que vous êtes sur le même Wi-Fi.';
}

// Path: pairing.refused
class Translations$pairing$refused$fr {
	Translations$pairing$refused$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Association refusée'
	String get title => 'Association refusée';

	/// fr: 'Le QR code a peut-être changé. Scanne celui affiché en ce moment sur le PC.'
	String get message => 'Le QR code a peut-être changé. Scanne celui affiché en ce moment sur le PC.';
}

// Path: pairing.topBar
class Translations$pairing$topBar$fr {
	Translations$pairing$topBar$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Fermer'
	String get close => 'Fermer';

	/// fr: 'Associer le PC'
	String get pill => 'Associer le PC';

	/// fr: 'Scanne le QR code affiché sur ton PC'
	String get scan => 'Scanne le QR code\naffiché sur ton PC';
}

// Path: pairing.help
class Translations$pairing$help$fr {
	Translations$pairing$help$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'C’est rapide !'
	String get title => 'C’est rapide !';

	/// fr: 'Une seule fois, ensuite tout est automatique'
	String get subtitle => 'Une seule fois, ensuite tout est automatique';

	/// fr: 'Ouvre Dis Saucisse ! sur le PC'
	String get step1 => 'Ouvre Dis Saucisse ! sur le PC';

	/// fr: 'Vérifie que les deux sont sur le même Wi-Fi'
	String get step2 => 'Vérifie que les deux sont sur le même Wi-Fi';

	/// fr: 'Vise le QR code, c’est tout'
	String get step3 => 'Vise le QR code, c’est tout';

	/// fr: 'Importer une image du QR code'
	String get importImage => 'Importer une image du QR code';

	/// fr: 'Les photos restent chez vous, sans passer par internet'
	String get privacy => 'Les photos restent chez vous, sans passer par internet';
}

// Path: quality.title
class Translations$quality$title$fr {
	Translations$quality$title$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Doublons'
	String get duplicates => 'Doublons';

	/// fr: 'Photos floues'
	String get blurry => 'Photos floues';
}

// Path: quality.intro
class Translations$quality$intro$fr {
	Translations$quality$intro$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Ces photos se ressemblent comme deux gouttes d’eau. La plus nette est gardée.'
	String get duplicates => 'Ces photos se ressemblent comme deux gouttes d’eau. La plus nette est gardée.';

	/// fr: 'Ces photos semblent floues. Décoche celles que tu veux garder.'
	String get blurry => 'Ces photos semblent floues. Décoche celles que tu veux garder.';
}

// Path: quality.empty
class Translations$quality$empty$fr {
	Translations$quality$empty$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Tout est propre !'
	String get title => 'Tout est propre !';

	/// fr: 'Aucun doublon parmi les photos à trier.'
	String get duplicates => 'Aucun doublon parmi les photos à trier.';

	/// fr: 'Aucune photo floue parmi les photos à trier.'
	String get blurry => 'Aucune photo floue parmi les photos à trier.';
}

// Path: quality.photoCount
class Translations$quality$photoCount$fr {
	Translations$quality$photoCount$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: '{count} photo'
	String single({required Object count}) => '${count} photo';

	/// fr: '{count} photos'
	String several({required Object count}) => '${count} photos';
}

// Path: quality.done
class Translations$quality$done$fr {
	Translations$quality$done$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: '{count} photo écartée'
	String titleSingle({required Object count}) => '${count} photo écartée';

	/// fr: '{count} photos écartées'
	String titleSeveral({required Object count}) => '${count} photos écartées';

	/// fr: 'Elle ira dans « Écartées » sur l’ordinateur. Rien n’est supprimé du téléphone.'
	String get messageSingle => 'Elle ira dans « Écartées » sur l’ordinateur. Rien n’est supprimé du téléphone.';

	/// fr: 'Elles iront dans « Écartées » sur l’ordinateur. Rien n’est supprimé du téléphone.'
	String get messageSeveral => 'Elles iront dans « Écartées » sur l’ordinateur. Rien n’est supprimé du téléphone.';
}

// Path: quality.review
class Translations$quality$review$fr {
	Translations$quality$review$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Retour'
	String get back => 'Retour';

	/// fr: 'Écarter {photos}'
	String discard({required Object photos}) => 'Écarter ${photos}';

	/// fr: 'Rien n’est supprimé : elles iront dans « Écartées » sur l’ordinateur.'
	String get nothingDeleted => 'Rien n’est supprimé : elles iront dans « Écartées » sur l’ordinateur.';
}

// Path: quality.photoTile
class Translations$quality$photoTile$fr {
	Translations$quality$photoTile$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Photo gardée'
	String get kept => 'Photo gardée';

	/// fr: 'Photo à écarter'
	String get toDiscard => 'Photo à écarter';
}

// Path: settings.header
class Translations$settings$header$fr {
	Translations$settings$header$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'L'app, à ta façon'
	String get subtitle => 'L\'app, à ta façon';

	/// fr: 'Réglages'
	String get title => 'Réglages';
}

// Path: settings.computer
class Translations$settings$computer$fr {
	Translations$settings$computer$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Aucun ordinateur'
	String get noComputer => 'Aucun ordinateur';

	/// fr: 'Associe ton PC pour y envoyer tes photos'
	String get pairHint => 'Associe ton PC pour y envoyer tes photos';

	/// fr: '{platform} · associé'
	String paired({required Object platform}) => '${platform} · associé';

	/// fr: 'Changer'
	String get change => 'Changer';

	/// fr: 'Associer'
	String get pair => 'Associer';

	/// fr: 'Le dossier de rangement et son format se choisissent dans l’app du PC.'
	String get folderHint => 'Le dossier de rangement et son format se choisissent dans l’app du PC.';

	/// fr: 'Mac'
	String get macos => 'Mac';

	/// fr: 'PC Windows'
	String get windows => 'PC Windows';
}

// Path: settings.sorting
class Translations$settings$sorting$fr {
	Translations$settings$sorting$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Tri'
	String get title => 'Tri';

	/// fr: 'Photos à trier depuis le'
	String get startDate => 'Photos à trier depuis le';

	/// fr: 'Pas encore choisi'
	String get notChosen => 'Pas encore choisi';
}

// Path: settings.startDateSheet
class Translations$settings$startDateSheet$fr {
	Translations$settings$startDateSheet$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Trier les photos depuis…'
	String get title => 'Trier les photos depuis…';

	/// fr: 'Valider'
	String get confirm => 'Valider';
}

// Path: settings.ignored
class Translations$settings$ignored$fr {
	Translations$settings$ignored$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Ce que l'app ignore'
	String get title => 'Ce que l\'app ignore';

	/// fr: 'Captures d'écran'
	String get screenshots => 'Captures d\'écran';

	/// fr: 'Images WhatsApp'
	String get whatsapp => 'Images WhatsApp';

	/// fr: 'Et des autres messageries'
	String get whatsappSubtitle => 'Et des autres messageries';

	/// fr: 'Vidéos'
	String get videos => 'Vidéos';

	/// fr: 'Toujours ignorées pour le moment'
	String get videosSubtitle => 'Toujours ignorées pour le moment';
}

// Path: settings.afterSending
class Translations$settings$afterSending$fr {
	Translations$settings$afterSending$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Après l'envoi'
	String get title => 'Après l\'envoi';

	/// fr: 'Libérer de la place'
	String get freeSpace => 'Libérer de la place';

	/// fr: 'Les photos déjà sur le PC passent par la corbeille, récupérables 30 jours'
	String get freeSpaceSubtitle => 'Les photos déjà sur le PC passent par la corbeille, récupérables 30 jours';
}

// Path: sorting.header
class Translations$sorting$header$fr {
	Translations$sorting$header$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Depuis quand on trie ?'
	String get title => 'Depuis quand\non trie ?';

	/// fr: 'Commence par tes photos récentes : tu pourras toujours remonter plus loin plus tard.'
	String get subtitle => 'Commence par tes photos récentes : tu pourras toujours remonter plus loin plus tard.';
}

// Path: sorting.status
class Translations$sorting$status$fr {
	Translations$sorting$status$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Sans accès à tes photos, je ne peux rien trier. Tu peux l'autoriser dans les réglages.'
	String get accessDenied => 'Sans accès à tes photos, je ne peux rien trier. Tu peux l\'autoriser dans les réglages.';

	/// fr: 'Ouvrir les réglages'
	String get openSettings => 'Ouvrir les réglages';

	/// fr: 'Oups, je n'ai pas réussi à lire tes photos. Réessaie.'
	String get failed => 'Oups, je n\'ai pas réussi à lire tes photos. Réessaie.';
}

// Path: sorting.options
class Translations$sorting$options$fr {
	Translations$sorting$options$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Trier les photos depuis le'
	String get datePickerHelp => 'Trier les photos depuis le';

	/// fr: '1 mois'
	String get oneMonth => '1 mois';

	/// fr: '3 mois'
	String get threeMonths => '3 mois';

	/// fr: '6 mois'
	String get sixMonths => '6 mois';

	/// fr: '1 an'
	String get oneYear => '1 an';

	/// fr: 'Autre date'
	String get otherDate => 'Autre date';

	/// fr: 'À partir du {date}'
	String startingFrom({required Object date}) => 'À partir du ${date}';
}

// Path: transfer.needsPairing
class Translations$transfer$needsPairing$fr {
	Translations$transfer$needsPairing$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Associe d’abord ton PC'
	String get title => 'Associe d’abord ton PC';

	/// fr: 'Ouvre Dis Saucisse ! sur ton ordinateur et scanne son QR code.'
	String get message => 'Ouvre Dis Saucisse ! sur ton ordinateur et scanne son QR code.';

	/// fr: 'Associer mon PC'
	String get pair => 'Associer mon PC';
}

// Path: transfer.nothingToSend
class Translations$transfer$nothingToSend$fr {
	Translations$transfer$nothingToSend$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Rien à envoyer'
	String get title => 'Rien à envoyer';

	/// fr: 'Trie des photos : celles que tu gardes ou écartes partiront sur ton PC.'
	String get message => 'Trie des photos : celles que tu gardes ou écartes partiront sur ton PC.';

	/// fr: 'Revérifier'
	String get recheck => 'Revérifier';
}

// Path: transfer.unreachable
class Translations$transfer$unreachable$fr {
	Translations$transfer$unreachable$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'PC introuvable'
	String get title => 'PC introuvable';

	/// fr: 'Vérifie que le PC est allumé, que l’app est ouverte et que vous êtes sur le même Wi-Fi.'
	String get message => 'Vérifie que le PC est allumé, que l’app est ouverte et que vous êtes sur le même Wi-Fi.';
}

// Path: transfer.failed
class Translations$transfer$failed$fr {
	Translations$transfer$failed$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'L’envoi s’est arrêté'
	String get title => 'L’envoi s’est arrêté';

	/// fr: 'Les photos déjà envoyées sont à l’abri. Réessaie pour envoyer la suite.'
	String get message => 'Les photos déjà envoyées sont à l’abri. Réessaie pour envoyer la suite.';
}

// Path: transfer.header
class Translations$transfer$header$fr {
	Translations$transfer$header$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Envoi vers {computerName}'
	String sendingTo({required Object computerName}) => 'Envoi vers ${computerName}';

	/// fr: 'photos envoyées · {remainingTime}'
	String photosSent({required Object remainingTime}) => 'photos envoyées · ${remainingTime}';
}

// Path: transfer.remainingTime
class Translations$transfer$remainingTime$fr {
	Translations$transfer$remainingTime$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'calcul du temps restant…'
	String get computing => 'calcul du temps restant…';

	/// fr: 'encore quelques secondes'
	String get fewSeconds => 'encore quelques secondes';

	/// fr: 'encore ~{minutes} min'
	String minutes({required Object minutes}) => 'encore ~${minutes} min';
}

// Path: transfer.details
class Translations$transfer$details$fr {
	Translations$transfer$details$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'En pause'
	String get paused => 'En pause';

	/// fr: 'Le PC a mis la réception en pause, ça reprendra tout seul'
	String get computerPaused => 'Le PC a mis la réception en pause, ça reprendra tout seul';

	/// fr: 'Connecté en Wi-Fi'
	String get connected => 'Connecté en Wi-Fi';

	/// fr: 'vérifiées'
	String get checked => 'vérifiées';

	/// fr: 'écartées'
	String get discarded => 'écartées';

	/// fr: 'Préparation…'
	String get preparing => 'Préparation…';

	/// fr: 'En train de ranger dans'
	String get sortingInto => 'En train de ranger dans';

	/// fr: 'Reprendre'
	String get resume => 'Reprendre';

	/// fr: 'Mettre en pause'
	String get pause => 'Mettre en pause';
}

// Path: transfer.done
class Translations$transfer$done$fr {
	Translations$transfer$done$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Saucisse !'
	String get title => 'Saucisse !';

	/// fr: '{photos} sur {computerName}, dans {events}.'
	String summary({required Object photos, required Object computerName, required Object events}) => '${photos} sur ${computerName}, dans ${events}.';

	/// fr: '1 photo est bien rangée'
	String get photosSingle => '1 photo est bien rangée';

	/// fr: '{count} photos sont bien rangées'
	String photosSeveral({required Object count}) => '${count} photos sont bien rangées';

	/// fr: '1 événement'
	String get eventsSingle => '1 événement';

	/// fr: '{count} événements'
	String eventsSeveral({required Object count}) => '${count} événements';

	/// fr: ' libérables sur le téléphone'
	String get freeable => '  libérables sur le téléphone';

	/// fr: 'Libérer de la place'
	String get freeSpace => 'Libérer de la place';

	/// fr: 'Garder sur le téléphone'
	String get keep => 'Garder sur le téléphone';
}

// Path: burstSort.sheet.photoCount
class Translations$burstSort$sheet$photoCount$fr {
	Translations$burstSort$sheet$photoCount$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: '1 photo dans cette rafale'
	String get single => '1 photo dans cette rafale';

	/// fr: '{count} photos dans cette rafale'
	String several({required Object count}) => '${count} photos dans cette rafale';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'burstSort.backHome' => 'Retour à l\'accueil',
			'burstSort.burstPosition' => ({required Object position, required Object count}) => 'Rafale ${position} sur ${count}',
			'burstSort.finished.title' => 'Tout est trié !',
			'burstSort.finished.message' => 'Bravo, il ne reste plus aucune rafale à trier ici.',
			'burstSort.sheet.photoCount.single' => '1 photo dans cette rafale',
			'burstSort.sheet.photoCount.several' => ({required Object count}) => '${count} photos dans cette rafale',
			'burstSort.sheet.swipeHint' => 'Glisse vers le haut pour garder, vers le bas pour écarter',
			'burstSort.sheet.discard' => 'Écarter',
			'burstSort.sheet.keep' => 'Garder',
			'events.dateRangeTitle' => ({required Object startDay, required Object endDate}) => 'Du ${startDay} au ${endDate}',
			'events.subtitle.single' => ({required Object dates, required Object count}) => '${dates} · ${count} photo',
			'events.subtitle.several' => ({required Object dates, required Object count}) => '${dates} · ${count} photos',
			'events.burstsToSort.single' => '1 rafale à trier',
			'events.burstsToSort.several' => ({required Object count}) => '${count} rafales à trier',
			'events.monthEventCount.single' => '1 événement',
			'events.monthEventCount.several' => ({required Object count}) => '${count} événements',
			'events.actions.rename' => 'Renommer',
			'events.actions.mergeWithPrevious' => 'Fusionner avec l\'événement d\'avant',
			'events.actions.mergeWithNext' => 'Fusionner avec l\'événement d\'après',
			'events.actions.split' => 'Séparer en deux',
			'events.actions.splitHint' => 'Choisis la rafale qui commence le nouvel événement',
			'events.nameSheet.title' => 'Nomme l\'événement',
			'events.nameSheet.save' => 'Enregistrer',
			'events.splitSheet.title' => 'Où commence le nouvel événement ?',
			'events.splitSheet.subtitle' => 'Tout ce qui suit la rafale choisie part dans le nouvel événement.',
			'events.splitOption.startedAt' => ({required Object day, required Object time}) => '${day} à ${time}',
			'events.splitOption.photoSingle' => '1 photo',
			'events.splitOption.photoSeveral' => ({required Object count}) => '${count} photos',
			'failures.retry' => 'Réessayer',
			'failures.accessDenied.title' => 'Je n’ai pas accès à tes photos',
			'failures.accessDenied.message' => 'Autorise Dis Saucisse ! à lire tes photos dans les réglages du téléphone, puis reviens ici.',
			'failures.libraryUnavailable.title' => 'Tes photos ne répondent pas',
			'failures.libraryUnavailable.message' => 'Je n’arrive pas à lire la photothèque du téléphone. Réessaie dans un instant.',
			'failures.analysis.title' => 'Analyse impossible',
			'failures.analysis.message' => 'Je n’ai pas réussi à examiner tes photos. Réessaie dans un instant.',
			'failures.deletion.title' => 'Rien n’a été supprimé',
			'failures.deletion.message' => 'La suppression a été annulée ou n’a pas abouti. Tes photos sont toujours là.',
			'failures.history.title' => 'Souvenirs introuvables',
			'failures.history.message' => 'Je n’arrive pas à retrouver la liste des photos déjà envoyées sur ton PC.',
			'failures.computerUnreachable.title' => 'PC introuvable',
			'failures.computerUnreachable.message' => 'Vérifie que le PC est allumé, que l’app est ouverte et que vous êtes sur le même Wi-Fi.',
			'failures.storage.title' => 'Je perds le fil',
			'failures.storage.message' => 'Je n’arrive pas à relire ce que j’ai noté sur le téléphone. Réessaie, et relance l’app si ça continue.',
			'failures.unknown.title' => 'Oups !',
			'failures.unknown.message' => 'Quelque chose s’est mal passé. Réessaie dans un instant.',
			'freeSpace.ready.title' => 'Libérer de la place',
			'freeSpace.ready.subtitle' => 'Ces photos sont déjà rangées et vérifiées sur ton ordinateur.',
			'freeSpace.ready.kept' => ({required Object count}) => '${count} photos gardées',
			'freeSpace.ready.deleteDiscarded' => ({required Object count}) => 'Supprimer aussi les ${count} écartées',
			'freeSpace.ready.trashNote' => 'Elles partent dans la corbeille du téléphone : tu peux les récupérer pendant 30 jours.',
			'freeSpace.ready.free' => ({required Object size}) => 'Libérer ${size}',
			'freeSpace.ready.keep' => 'Garder sur le téléphone',
			'freeSpace.nothingToFree.title' => 'Rien à libérer',
			'freeSpace.nothingToFree.message' => 'Envoie d’abord des photos sur ton ordinateur : tu pourras ensuite faire de la place.',
			'freeSpace.done.title' => ({required Object size}) => '${size} libérés !',
			'freeSpace.done.message' => ({required Object count}) => '${count} photos sont dans la corbeille du téléphone. Elles restent rangées sur ton ordinateur.',
			'home.accessDenied.title' => 'Je n\'ai pas accès à tes photos',
			'home.accessDenied.message' => 'Autorise Dis Saucisse ! à lire tes photos dans les réglages, puis reviens ici.',
			'home.accessDenied.openSettings' => 'Ouvrir les réglages',
			'home.accessDenied.retry' => 'C\'est fait, réessayer',
			'home.greeting' => 'Coucou ! Prête pour le tri ?',
			'home.photosToSort.zero' => 'Aucune photo\nà trier',
			'home.photosToSort.single' => '1 photo\nà trier',
			'home.photosToSort.several' => ({required Object count}) => '${count} photos\nà trier',
			'home.quality.duplicates' => 'doublons',
			'home.quality.blurry' => 'photos floues',
			'home.quality.analyzingSingle' => 'Analyse en cours… encore 1 photo',
			'home.quality.analyzingSeveral' => ({required Object count}) => 'Analyse en cours… encore ${count} photos',
			'home.topBar.calendar' => 'Calendrier',
			'home.topBar.computer' => 'Ordinateur',
			'home.allMonths' => 'Tout',
			'home.allSorted' => 'Tout est trié pour le moment. Saucisse !',
			'home.startSorting' => 'Lancer le tri',
			'memories.photoCount.single' => '1 photo',
			'memories.photoCount.several' => ({required Object count}) => '${count} photos',
			'memories.eventCount.zero' => 'aucun événement',
			'memories.eventCount.single' => '1 événement',
			'memories.eventCount.several' => ({required Object count}) => '${count} événements',
			'memories.sentOn' => ({required Object date}) => 'Envoyé le ${date}',
			'memories.empty.title' => 'Pas encore de souvenirs',
			'memories.empty.message' => 'Envoie tes premières photos sur le PC : elles apparaîtront ici, rangées par mois.',
			'memories.header.caption' => 'Tout ce qui est rangé sur le PC',
			'memories.header.photosSafe' => ({required Object photos}) => '${photos}\nà l’abri',
			'memories.allYears' => 'Tout',
			'memories.monthCard.onComputer' => 'Sur le PC',
			'memories.recap.caption' => 'RÉCAP DU MOIS',
			'memories.recap.title' => ({required Object month}) => 'Ton mois de ${month}',
			'memories.recap.photoSingle' => 'photo',
			'memories.recap.photoSeveral' => 'photos',
			'memories.recap.eventSingle' => 'événement',
			'memories.recap.eventSeveral' => 'événements',
			'memories.recap.stored' => 'rangés',
			'memories.months.title' => 'Mois rangés',
			'memories.months.countSingle' => '1 mois',
			'memories.months.countSeveral' => ({required Object count}) => '${count} mois',
			'navigation.photos' => 'Photos à trier',
			'navigation.memories' => 'Souvenirs',
			'navigation.settings' => 'Réglages',
			'pairing.pairingWith' => ({required Object computerName}) => 'Association avec ${computerName}…',
			'pairing.paired.title' => 'C’est fait !',
			'pairing.paired.message' => ({required Object computerName}) => 'Ton téléphone est associé à ${computerName}. Tu pourras y envoyer tes photos triées.',
			'pairing.paired.backHome' => 'Retour à l’accueil',
			'pairing.invalidCode.title' => 'Ce n’est pas le bon QR code',
			'pairing.invalidCode.message' => 'Scanne le QR code affiché dans l’app Dis Saucisse ! sur ton PC.',
			'pairing.unreachable.title' => 'PC introuvable',
			'pairing.unreachable.message' => 'Vérifie que le PC est allumé, que l’app est ouverte et que vous êtes sur le même Wi-Fi.',
			'pairing.refused.title' => 'Association refusée',
			'pairing.refused.message' => 'Le QR code a peut-être changé. Scanne celui affiché en ce moment sur le PC.',
			'pairing.retry' => 'Réessayer',
			'pairing.topBar.close' => 'Fermer',
			'pairing.topBar.pill' => 'Associer le PC',
			'pairing.topBar.scan' => 'Scanne le QR code\naffiché sur ton PC',
			'pairing.help.title' => 'C’est rapide !',
			'pairing.help.subtitle' => 'Une seule fois, ensuite tout est automatique',
			'pairing.help.step1' => 'Ouvre Dis Saucisse ! sur le PC',
			'pairing.help.step2' => 'Vérifie que les deux sont sur le même Wi-Fi',
			'pairing.help.step3' => 'Vise le QR code, c’est tout',
			'pairing.help.importImage' => 'Importer une image du QR code',
			'pairing.help.privacy' => 'Les photos restent chez vous, sans passer par internet',
			'quality.title.duplicates' => 'Doublons',
			'quality.title.blurry' => 'Photos floues',
			'quality.intro.duplicates' => 'Ces photos se ressemblent comme deux gouttes d’eau. La plus nette est gardée.',
			'quality.intro.blurry' => 'Ces photos semblent floues. Décoche celles que tu veux garder.',
			'quality.empty.title' => 'Tout est propre !',
			'quality.empty.duplicates' => 'Aucun doublon parmi les photos à trier.',
			'quality.empty.blurry' => 'Aucune photo floue parmi les photos à trier.',
			'quality.photoCount.single' => ({required Object count}) => '${count} photo',
			'quality.photoCount.several' => ({required Object count}) => '${count} photos',
			'quality.done.titleSingle' => ({required Object count}) => '${count} photo écartée',
			'quality.done.titleSeveral' => ({required Object count}) => '${count} photos écartées',
			'quality.done.messageSingle' => 'Elle ira dans « Écartées » sur l’ordinateur. Rien n’est supprimé du téléphone.',
			'quality.done.messageSeveral' => 'Elles iront dans « Écartées » sur l’ordinateur. Rien n’est supprimé du téléphone.',
			'quality.review.back' => 'Retour',
			'quality.review.discard' => ({required Object photos}) => 'Écarter ${photos}',
			'quality.review.nothingDeleted' => 'Rien n’est supprimé : elles iront dans « Écartées » sur l’ordinateur.',
			'quality.photoTile.kept' => 'Photo gardée',
			'quality.photoTile.toDiscard' => 'Photo à écarter',
			'settings.header.subtitle' => 'L\'app, à ta façon',
			'settings.header.title' => 'Réglages',
			'settings.computer.noComputer' => 'Aucun ordinateur',
			'settings.computer.pairHint' => 'Associe ton PC pour y envoyer tes photos',
			'settings.computer.paired' => ({required Object platform}) => '${platform} · associé',
			'settings.computer.change' => 'Changer',
			'settings.computer.pair' => 'Associer',
			'settings.computer.folderHint' => 'Le dossier de rangement et son format se choisissent dans l’app du PC.',
			'settings.computer.macos' => 'Mac',
			'settings.computer.windows' => 'PC Windows',
			'settings.sorting.title' => 'Tri',
			'settings.sorting.startDate' => 'Photos à trier depuis le',
			'settings.sorting.notChosen' => 'Pas encore choisi',
			'settings.startDateSheet.title' => 'Trier les photos depuis…',
			'settings.startDateSheet.confirm' => 'Valider',
			'settings.ignored.title' => 'Ce que l\'app ignore',
			'settings.ignored.screenshots' => 'Captures d\'écran',
			'settings.ignored.whatsapp' => 'Images WhatsApp',
			'settings.ignored.whatsappSubtitle' => 'Et des autres messageries',
			'settings.ignored.videos' => 'Vidéos',
			'settings.ignored.videosSubtitle' => 'Toujours ignorées pour le moment',
			'settings.afterSending.title' => 'Après l\'envoi',
			'settings.afterSending.freeSpace' => 'Libérer de la place',
			'settings.afterSending.freeSpaceSubtitle' => 'Les photos déjà sur le PC passent par la corbeille, récupérables 30 jours',
			'sorting.header.title' => 'Depuis quand\non trie ?',
			'sorting.header.subtitle' => 'Commence par tes photos récentes : tu pourras toujours remonter plus loin plus tard.',
			'sorting.privacyNote' => 'Tes photos restent chez toi : elles ne partent que vers ton ordinateur, par ton Wi-Fi.',
			'sorting.start' => 'C\'est parti !',
			'sorting.status.accessDenied' => 'Sans accès à tes photos, je ne peux rien trier. Tu peux l\'autoriser dans les réglages.',
			'sorting.status.openSettings' => 'Ouvrir les réglages',
			'sorting.status.failed' => 'Oups, je n\'ai pas réussi à lire tes photos. Réessaie.',
			'sorting.options.datePickerHelp' => 'Trier les photos depuis le',
			'sorting.options.oneMonth' => '1 mois',
			'sorting.options.threeMonths' => '3 mois',
			'sorting.options.sixMonths' => '6 mois',
			'sorting.options.oneYear' => '1 an',
			'sorting.options.otherDate' => 'Autre date',
			'sorting.options.startingFrom' => ({required Object date}) => 'À partir du ${date}',
			'transfer.backHome' => 'Retour à l’accueil',
			'transfer.retry' => 'Réessayer',
			'transfer.needsPairing.title' => 'Associe d’abord ton PC',
			'transfer.needsPairing.message' => 'Ouvre Dis Saucisse ! sur ton ordinateur et scanne son QR code.',
			'transfer.needsPairing.pair' => 'Associer mon PC',
			'transfer.nothingToSend.title' => 'Rien à envoyer',
			'transfer.nothingToSend.message' => 'Trie des photos : celles que tu gardes ou écartes partiront sur ton PC.',
			'transfer.nothingToSend.recheck' => 'Revérifier',
			'transfer.unreachable.title' => 'PC introuvable',
			'transfer.unreachable.message' => 'Vérifie que le PC est allumé, que l’app est ouverte et que vous êtes sur le même Wi-Fi.',
			'transfer.failed.title' => 'L’envoi s’est arrêté',
			'transfer.failed.message' => 'Les photos déjà envoyées sont à l’abri. Réessaie pour envoyer la suite.',
			'transfer.header.sendingTo' => ({required Object computerName}) => 'Envoi vers ${computerName}',
			'transfer.header.photosSent' => ({required Object remainingTime}) => 'photos envoyées · ${remainingTime}',
			'transfer.remainingTime.computing' => 'calcul du temps restant…',
			'transfer.remainingTime.fewSeconds' => 'encore quelques secondes',
			'transfer.remainingTime.minutes' => ({required Object minutes}) => 'encore ~${minutes} min',
			'transfer.details.paused' => 'En pause',
			'transfer.details.computerPaused' => 'Le PC a mis la réception en pause, ça reprendra tout seul',
			'transfer.details.connected' => 'Connecté en Wi-Fi',
			'transfer.details.checked' => 'vérifiées',
			'transfer.details.discarded' => 'écartées',
			'transfer.details.preparing' => 'Préparation…',
			'transfer.details.sortingInto' => 'En train de ranger dans',
			'transfer.details.resume' => 'Reprendre',
			'transfer.details.pause' => 'Mettre en pause',
			'transfer.done.title' => 'Saucisse !',
			'transfer.done.summary' => ({required Object photos, required Object computerName, required Object events}) => '${photos} sur ${computerName}, dans ${events}.',
			'transfer.done.photosSingle' => '1 photo est bien rangée',
			'transfer.done.photosSeveral' => ({required Object count}) => '${count} photos sont bien rangées',
			'transfer.done.eventsSingle' => '1 événement',
			'transfer.done.eventsSeveral' => ({required Object count}) => '${count} événements',
			'transfer.done.freeable' => '  libérables sur le téléphone',
			'transfer.done.freeSpace' => 'Libérer de la place',
			'transfer.done.keep' => 'Garder sur le téléphone',
			_ => null,
		};
	}
}
