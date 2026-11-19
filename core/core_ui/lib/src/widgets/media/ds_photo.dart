import 'package:core_ui/src/foundation/ds_gradients.dart';
import 'package:core_ui/src/foundation/ds_radius.dart';
import 'package:flutter/widgets.dart';

/// Rounded photo. Shows a placeholder gradient while [image] is null.
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
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: DsGradients.photoPlaceholders[placeholderIndex % DsGradients.photoPlaceholders.length],
        image: photo == null ? null : DecorationImage(image: photo, fit: BoxFit.cover),
      ),
    );
  }
}
