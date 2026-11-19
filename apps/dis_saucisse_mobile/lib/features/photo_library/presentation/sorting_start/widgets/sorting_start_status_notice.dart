import 'package:core_ui/core_ui.dart';
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
            "Sans accès à tes photos, je ne peux rien trier. Tu peux l'autoriser dans les réglages.",
            style: DsTextStyles.body,
          ),
          DsButton(
            label: 'Ouvrir les réglages',
            variant: DsButtonVariant.secondary,
            onPressed: context.read<SortingStartCubit>().openAccessSettings,
          ),
        ],
      ),
    ),
    SortingStartFailed() => DsCard(
      color: DsColors.surface,
      child: Text("Oups, je n'ai pas réussi à lire tes photos. Réessaie.", style: DsTextStyles.body),
    ),
    SortingStartEditing() || SortingStartRequestingAccess() || SortingStartCompleted() => const SizedBox.shrink(),
  };
}
