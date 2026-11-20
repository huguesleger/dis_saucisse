import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/presentation/main_tab.dart';
import 'package:flutter/material.dart';

class MainNavBar extends StatelessWidget {
  const MainNavBar({super.key, required this.selectedTab, required this.onSelected});

  static const double height = 68;

  final MainTab selectedTab;
  final ValueChanged<MainTab> onSelected;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Color(0x00F7F2EA), DsColors.pageBackground],
        stops: <double>[0, 0.35],
      ),
    ),
    child: SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: DsSpacing.s),
      child: Padding(
        padding: const EdgeInsets.only(top: DsSpacing.m),
        child: Center(
          child: DsFloatingNavBar(
            destinations: MainTab.values.map(_destinationOf).toList(),
            selectedIndex: selectedTab.index,
            onDestinationSelected: (int index) => onSelected(MainTab.values[index]),
          ),
        ),
      ),
    ),
  );

  DsNavDestination _destinationOf(MainTab tab) => switch (tab) {
    MainTab.photos => const DsNavDestination(icon: Icons.photo_outlined, label: 'Photos à trier'),
    MainTab.memories => const DsNavDestination(icon: Icons.favorite_border_rounded, label: 'Souvenirs'),
    MainTab.settings => const DsNavDestination(icon: Icons.tune_rounded, label: 'Réglages'),
  };
}
