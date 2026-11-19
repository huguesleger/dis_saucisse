import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/formatting/french_dates.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/rules/sorting_progress.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/widgets/home_event_card.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/month_events.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_events/presentation/event_labels.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/widgets.dart';

class HomeEventsSection extends StatelessWidget {
  const HomeEventsSection({
    super.key,
    required this.eventsByMonth,
    required this.decisions,
    required this.onEventTap,
    required this.onEventMore,
  });

  final List<MonthEvents> eventsByMonth;
  final Map<PhotoId, PhotoDecision> decisions;
  final ValueChanged<PhotoEvent> onEventTap;
  final ValueChanged<PhotoEvent> onEventMore;

  @override
  Widget build(BuildContext context) => eventsByMonth.isEmpty
      ? Text(
          'Tout est trié pour le moment. Saucisse !',
          style: DsTextStyles.body.copyWith(color: DsColors.textSoft),
        )
      : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: DsSpacing.xl,
          children: <Widget>[
            for (final MonthEvents group in eventsByMonth)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: DsSpacing.s,
                children: <Widget>[
                  DsSectionHeader(
                    title: '${capitalizedFrenchMonthName(group.month.month)} ${group.month.year}',
                    trailing: monthEventCountLabel(group.events.length),
                  ),
                  for (final PhotoEvent event in group.events)
                    HomeEventCard(
                      event: event,
                      burstsToSortCount: burstsToSort(event, decisions).length,
                      onTap: () => onEventTap(event),
                      onMore: () => onEventMore(event),
                    ),
                ],
              ),
          ],
        );
}
