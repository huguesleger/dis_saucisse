import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:flutter/widgets.dart';

class DiscardedPhotosRestoreButton extends StatelessWidget {
  const DiscardedPhotosRestoreButton({super.key, required this.selectedCount, required this.onRestore});

  final int selectedCount;
  final VoidCallback onRestore;

  @override
  Widget build(BuildContext context) => AnimatedSize(
    duration: const Duration(milliseconds: 200),
    curve: Curves.easeOut,
    child: selectedCount == 0
        ? const SizedBox(width: double.infinity)
        : Padding(
            padding: const EdgeInsets.fromLTRB(DsSpacing.l, DsSpacing.s, DsSpacing.l, DsSpacing.l),
            child: DsButton(
              label: selectedCount == 1
                  ? t.discarded.restore.single
                  : t.discarded.restore.several(count: selectedCount),
              variant: DsButtonVariant.dark,
              onPressed: onRestore,
            ),
          ),
  );
}
