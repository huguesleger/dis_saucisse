const List<String> _monthNames = <String>[
  'janvier',
  'février',
  'mars',
  'avril',
  'mai',
  'juin',
  'juillet',
  'août',
  'septembre',
  'octobre',
  'novembre',
  'décembre',
];

const List<String> _shortMonthNames = <String>[
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

const List<String> _weekdayNames = <String>['lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi', 'dimanche'];

String _capitalized(String text) => '${text[0].toUpperCase()}${text.substring(1)}';

String frenchMonthName(int month) => _monthNames[month - 1];

String capitalizedFrenchMonthName(int month) => _capitalized(frenchMonthName(month));

String frenchLongDate(DateTime date) => '${date.day} ${frenchMonthName(date.month)} ${date.year}';

String frenchWeekdayAndDay(DateTime date) =>
    '${_capitalized(_weekdayNames[date.weekday - 1])} ${date.day} ${frenchMonthName(date.month)}';

String frenchShortWeekdayAndDay(DateTime date) =>
    '${_capitalized(_weekdayNames[date.weekday - 1].substring(0, 3))}. ${date.day} ${_shortMonthNames[date.month - 1]}';

String frenchShortDay(DateTime date) => '${date.day} ${_shortMonthNames[date.month - 1]}';

String frenchTime(DateTime date) => '${date.hour} h ${date.minute.toString().padLeft(2, '0')}';
