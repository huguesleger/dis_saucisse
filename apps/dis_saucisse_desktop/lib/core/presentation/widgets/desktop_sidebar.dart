import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class DesktopSidebar extends StatelessWidget {
  const DesktopSidebar({super.key, required this.phoneStatus, required this.networkStatus});

  final DsConnectionCard phoneStatus;
  final DsConnectionCard networkStatus;

  @override
  Widget build(BuildContext context) => Container(
    width: 248,
    color: DsColors.background,
    padding: const EdgeInsets.all(DsSpacing.m),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Align(alignment: Alignment.centerLeft, child: DsLogoPill(elevated: false)),
        const SizedBox(height: DsSpacing.xl),
        DsSidebarItem(
          destination: const DsNavDestination(icon: Icons.image_outlined, label: 'Réception'),
          selected: true,
          onTap: () {},
        ),
        const Spacer(),
        phoneStatus,
        const SizedBox(height: DsSpacing.xs),
        networkStatus,
      ],
    ),
  );
}
