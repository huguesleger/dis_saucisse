import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/quality_photo_status.dart';
import 'package:flutter/material.dart';

class QualityStatusDot extends StatelessWidget {
  const QualityStatusDot({super.key, required this.status, required this.onTap});

  static const double _dotSize = 26;

  final QualityPhotoStatus status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final (Color background, Color foreground, IconData icon) = switch (status) {
      QualityPhotoStatus.best => (DsColors.mustard, DsColors.onMustard, Icons.star_rounded),
      QualityPhotoStatus.kept => (DsColors.success, DsColors.background, Icons.check_rounded),
      QualityPhotoStatus.toDiscard => (DsColors.sausage, DsColors.onSausage, Icons.remove_rounded),
    };
    return Semantics(
      button: onTap != null,
      label: switch (status) {
        QualityPhotoStatus.best => t.quality.tile.best,
        QualityPhotoStatus.kept => t.quality.tile.discardIt,
        QualityPhotoStatus.toDiscard => t.quality.tile.keepIt,
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(DsSpacing.xs),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: _dotSize,
            height: _dotSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: background,
              border: Border.all(color: DsColors.background, width: 2),
            ),
            child: Icon(icon, size: 16, color: foreground),
          ),
        ),
      ),
    );
  }
}
