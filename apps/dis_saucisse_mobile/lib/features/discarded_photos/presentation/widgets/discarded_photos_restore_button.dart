import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:flutter/widgets.dart';

class DiscardedPhotosRestoreButton extends StatelessWidget {
  const DiscardedPhotosRestoreButton({super.key, required this.selectedCount, required this.onRestore});

  final int selectedCount;
  final VoidCallback onRestore;

  @override
  Widget build(BuildContext context) => DsButton(
    label: switch (selectedCount) {
      0 => t.discarded.restore.zero,
      1 => t.discarded.restore.single,
      _ => t.discarded.restore.several(count: selectedCount),
    },
    variant: DsButtonVariant.dark,
    onPressed: selectedCount == 0 ? null : onRestore,
  );
}
