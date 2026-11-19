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

String frenchMonthName(int month) => _monthNames[month - 1];

String capitalizedFrenchMonthName(int month) {
  final String name = frenchMonthName(month);
  return '${name[0].toUpperCase()}${name.substring(1)}';
}

String frenchLongDate(DateTime date) => '${date.day} ${frenchMonthName(date.month)} ${date.year}';
