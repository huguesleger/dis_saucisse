import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';

String historyDate(DateTime date) =>
    '${t.history.dates.weekdays[date.weekday - 1]} ${date.day} ${t.history.dates.months[date.month - 1]} ${date.year}';
