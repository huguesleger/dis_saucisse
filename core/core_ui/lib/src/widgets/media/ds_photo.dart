import 'package:core_ui/src/foundation/ds_gradients.dart';
import 'package:core_ui/src/foundation/ds_radius.dart';
import 'package:flutter/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Rounded photo. Shows a placeholder gradient while [image] is null or fails to load.
///
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
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: DsGradients.photoPlaceholders[placeholderIndex % DsGradients.photoPlaceholders.length],
          image: photo == null ? null : DecorationImage(image: photo, fit: BoxFit.cover, onError: (_, _) {}),
        ),
      ),
    );
  }
}
