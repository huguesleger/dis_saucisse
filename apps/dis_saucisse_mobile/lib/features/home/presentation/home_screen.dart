import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/widgets/home_bottom_actions.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/widgets/home_events_section.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/widgets/home_faces_section.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/widgets/home_greeting.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/widgets/home_month_filters.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/widgets/home_quality_tiles.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/widgets/home_top_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const EdgeInsets _gutter = EdgeInsets.symmetric(horizontal: DsSpacing.l);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: DsMeshBackground(
      meshHeight: 340,
      child: Stack(
        children: <Widget>[
          SafeArea(
            bottom: false,
            child: ListView(
              padding: const EdgeInsets.only(top: DsSpacing.m, bottom: 200),
              children: const <Widget>[
                Padding(padding: _gutter, child: HomeTopBar()),
                SizedBox(height: DsSpacing.xl),
                Padding(padding: _gutter, child: HomeGreeting(photosToSortCount: 248)),
                SizedBox(height: DsSpacing.m),
                HomeMonthFilters(labels: <String>['Tout', 'Novembre', 'Octobre', 'Septembre'], selectedIndex: 0),
                SizedBox(height: DsSpacing.xl),
                Padding(
                  padding: _gutter,
                  child: HomeFacesSection(names: <String>['Petit loup', 'Maman', 'Papa', 'Mamie', 'Tonton']),
                ),
                SizedBox(height: DsSpacing.xl),
                Padding(padding: _gutter, child: HomeQualityTiles(duplicateCount: 31, blurryCount: 12)),
                SizedBox(height: DsSpacing.xl),
                Padding(padding: _gutter, child: HomeEventsSection()),
              ],
            ),
          ),
          const Positioned(left: 0, right: 0, bottom: 0, child: HomeBottomActions()),
        ],
      ),
    ),
  );
}
