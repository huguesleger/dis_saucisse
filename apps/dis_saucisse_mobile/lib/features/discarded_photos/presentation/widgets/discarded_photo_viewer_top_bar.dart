import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/widgets/discarded_photo_progress.dart';
import 'package:flutter/material.dart';

class DiscardedPhotoViewerTopBar extends StatelessWidget {
  const DiscardedPhotoViewerTopBar({super.key, required this.position, required this.count});

  static const double _buttonSize = 44;

  final int position;
  final int count;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(DsSpacing.l, DsSpacing.xs, DsSpacing.l, 0),
    child: Column(
      spacing: DsSpacing.m,
      children: <Widget>[
        Row(
          children: <Widget>[
            DsRoundIconButton(
              icon: Icons.arrow_back_rounded,
              tooltip: t.discarded.viewer.back,
              size: _buttonSize,
              onPressed: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: Text(
                t.discarded.viewer.title,
                style: DsTextStyles.titleM.copyWith(color: DsColors.background),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: _buttonSize),
          ],
        ),
        if (count > 1) DiscardedPhotoProgress(position: position, count: count),
      ],
    ),
  );
}
