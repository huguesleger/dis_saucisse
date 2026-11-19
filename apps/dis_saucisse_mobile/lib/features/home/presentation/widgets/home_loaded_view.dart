import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/router/routes.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/bloc/home_cubit.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/home_event_menu.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/home_navigation.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/widgets/home_bottom_actions.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/widgets/home_events_section.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/widgets/home_greeting.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/widgets/home_month_filters.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/widgets/home_quality_tiles.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/widgets/home_top_bar.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class HomeLoadedView extends StatelessWidget {
  const HomeLoadedView({super.key, required this.state});

  final HomeLoaded state;

  static const EdgeInsets _gutter = EdgeInsets.symmetric(horizontal: DsSpacing.l);

  @override
  Widget build(BuildContext context) => Stack(
    children: <Widget>[
      SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.only(top: DsSpacing.m, bottom: 200),
          children: <Widget>[
            Padding(
              padding: _gutter,
              child: HomeTopBar(onComputerTap: () => const TransferPageRoute().push<void>(context)),
            ),
            const SizedBox(height: DsSpacing.xl),
            Padding(
              padding: _gutter,
              child: HomeGreeting(photosToSortCount: state.visiblePhotoCount),
            ),
            const SizedBox(height: DsSpacing.m),
            HomeMonthFilters(
              months: state.months,
              selectedMonth: state.selectedMonth,
              onSelected: context.read<HomeCubit>().selectMonth,
            ),
            const SizedBox(height: DsSpacing.xl),
            const Padding(padding: _gutter, child: HomeQualityTiles(duplicateCount: 31, blurryCount: 12)),
            const SizedBox(height: DsSpacing.xl),
            Padding(
              padding: _gutter,
              child: HomeEventsSection(
                eventsByMonth: state.visibleEventsByMonth,
                decisions: state.library.decisions,
                onEventTap: (PhotoEvent event) =>
                    openBurstSort(context, cubit: context.read<HomeCubit>(), eventId: some(event.id)),
                onEventMore: (PhotoEvent event) =>
                    openEventMenu(context, cubit: context.read<HomeCubit>(), event: event),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: HomeBottomActions(
          onStartSorting: state.photosLeftToSort.isEmpty
              ? null
              : () => openBurstSort(context, cubit: context.read<HomeCubit>(), eventId: none()),
        ),
      ),
    ],
  );
}
