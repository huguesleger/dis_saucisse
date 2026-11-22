import 'package:core_ui/src/foundation/ds_gradients.dart';
import 'package:core_ui/src/foundation/ds_radius.dart';
import 'package:core_ui/src/widgets/media/ds_image.dart';
import 'package:flutter/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Rounded photo: a shimmering skeleton while [image] loads, then a fade in.
///
/// Shows a placeholder gradient when there is no [image] or when it fails to load.
/// Inside an enabled [DsSkeletonizer], it is drawn as a plain grey shape.
class DsPhoto extends StatelessWidget {
  const DsPhoto({
    super.key,
    this.image,
    this.placeholderIndex = 0,
    this.borderRadius = DsRadius.mediumAll,
    this.width,
    this.height,
  });

  final ImageProvider? image;
  final int placeholderIndex;
  final BorderRadius borderRadius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final ImageProvider? photo = image;
    return Skeleton.leaf(
      child: SizedBox(
        width: width,
        height: height,
        child: photo == null
            ? DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  gradient: DsGradients.photoPlaceholders[placeholderIndex % DsGradients.photoPlaceholders.length],
                ),
                child: const SizedBox.expand(),
              )
            : DsImage(image: photo, borderRadius: borderRadius, placeholderIndex: placeholderIndex),
      ),
    );
  }
}
