import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/presentation/widgets/main_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';

class HomeBottomActions extends StatelessWidget {
  const HomeBottomActions({super.key, required this.onStartSorting});

  final VoidCallback? onStartSorting;

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
        padding: const EdgeInsets.fromLTRB(DsSpacing.l, DsSpacing.xxl, DsSpacing.l, MainNavBar.height + DsSpacing.m),
        child: DsButton(label: t.home.startSorting, onPressed: onStartSorting),
      ),
    ),
  );
}
