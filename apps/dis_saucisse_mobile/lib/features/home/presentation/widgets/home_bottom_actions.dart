import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class HomeBottomActions extends StatelessWidget {
  const HomeBottomActions({super.key});

  static const List<DsNavDestination> _destinations = <DsNavDestination>[
    DsNavDestination(icon: Icons.photo_outlined, label: 'Photos à trier'),
    DsNavDestination(icon: Icons.favorite_border_rounded, label: 'Souvenirs'),
    DsNavDestination(icon: Icons.tune_rounded, label: 'Réglages'),
  ];

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
        padding: const EdgeInsets.fromLTRB(DsSpacing.l, DsSpacing.xxl, DsSpacing.l, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DsButton(label: 'Lancer le tri', onPressed: () {}),
            const SizedBox(height: DsSpacing.m),
            DsFloatingNavBar(destinations: _destinations, selectedIndex: 0, onDestinationSelected: (_) {}),
          ],
        ),
      ),
    ),
  );
}
