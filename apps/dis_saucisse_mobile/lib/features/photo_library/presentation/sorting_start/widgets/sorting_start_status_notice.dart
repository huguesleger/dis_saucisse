import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/photo_library/presentation/sorting_start/bloc/sorting_start_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SortingStartStatusNotice extends StatelessWidget {
  const SortingStartStatusNotice({super.key, required this.state});

  final SortingStartState state;

  @override
  Widget build(BuildContext context) => switch (state) {
    SortingStartAccessDenied() => DsCard(
      color: DsColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: DsSpacing.s,
        children: <Widget>[
          Text(
            t.sorting.status.accessDenied,
            style: DsTextStyles.body,
          ),
          DsButton(
            label: t.sorting.status.openSettings,
            variant: DsButtonVariant.secondary,
            onPressed: context.read<SortingStartCubit>().openAccessSettings,
          ),
        ],
      ),
    ),
    SortingStartFailed() => DsCard(
      color: DsColors.surface,
      child: Text(t.sorting.status.failed, style: DsTextStyles.body),
    ),
    SortingStartEditing() || SortingStartRequestingAccess() || SortingStartCompleted() => const SizedBox.shrink(),
  };
}
