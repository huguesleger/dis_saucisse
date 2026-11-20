import 'package:dis_saucisse_mobile/core/presentation/main_tab.dart';
import 'package:dis_saucisse_mobile/core/presentation/widgets/main_nav_bar.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/bloc/home_cubit.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/bloc/memories_cubit.dart';
import 'package:dis_saucisse_mobile/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => Material(
    type: MaterialType.transparency,
    child: Stack(
      children: <Widget>[
        navigationShell,
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: MainNavBar(
            selectedTab: MainTab.values[navigationShell.currentIndex],
            onSelected: (MainTab tab) => _open(context, tab),
          ),
        ),
      ],
    ),
  );

  void _open(BuildContext context, MainTab tab) {
    if (tab.index == navigationShell.currentIndex) return;
    switch (tab) {
      case MainTab.photos:
        context.read<HomeCubit>().refresh();
      case MainTab.memories:
        context.read<MemoriesCubit>().load();
      case MainTab.settings:
        context.read<SettingsCubit>().load();
    }
    navigationShell.goBranch(tab.index);
  }
}
