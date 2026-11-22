import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_radius.dart';
import 'package:core_ui/src/foundation/ds_shadows.dart';
import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/foundation/ds_text_styles.dart';
import 'package:flutter/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// "Dis Saucisse !" logo in a white pill, shown at the top of the home screen and in the desktop sidebar.
class DsLogoPill extends StatelessWidget {
  const DsLogoPill({super.key, this.elevated = true});

  final bool elevated;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: DsColors.background,
      borderRadius: DsRadius.pillAll,
      boxShadow: elevated ? DsShadows.card : null,
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(DsSpacing.xxs, DsSpacing.xxs, DsSpacing.m, DsSpacing.xxs),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Skeleton.replace(
            replacement: const Bone.circle(size: 36),
            child: Image.asset(
              'assets/images/face.png',
              package: 'core_ui',
              width: 36,
              height: 36,
              semanticLabel: 'Saucisse',
            ),
          ),
          const SizedBox(width: DsSpacing.xs),
          Flexible(
            child: Text('Dis Saucisse !', style: DsTextStyles.label, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    ),
  );
}
