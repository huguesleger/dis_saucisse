import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/photo_library/presentation/sorting_start/bloc/sorting_start_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SortingStartFooter extends StatelessWidget {
  const SortingStartFooter({super.key, required this.state});

  final SortingStartState state;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(DsSpacing.l, DsSpacing.s, DsSpacing.l, DsSpacing.m),
    child: DsButton(
      label: "C'est parti !",
      variant: DsButtonVariant.dark,
      onPressed: switch (state) {
        SortingStartRequestingAccess() || SortingStartCompleted() => null,
        SortingStartEditing() ||
        SortingStartAccessDenied() ||
        SortingStartFailed() => context.read<SortingStartCubit>().confirm,
      },
    ),
  );
}
