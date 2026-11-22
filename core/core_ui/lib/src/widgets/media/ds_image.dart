import 'package:core_ui/src/widgets/feedback/ds_skeletonizer.dart';
import 'package:core_ui/src/widgets/media/ds_photo.dart';
import 'package:flutter/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Image that fills its space: a shimmering skeleton while it loads, then a fade in.
///
/// Shows the placeholder gradient of [DsPhoto] when the image cannot be loaded.
class DsImage extends StatelessWidget {
  const DsImage({super.key, required this.image, this.fit = BoxFit.cover, this.borderRadius = BorderRadius.zero});

  final ImageProvider image;
  final BoxFit fit;
  final BorderRadius borderRadius;

  static const Duration _fadeIn = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: borderRadius,
    child: Image(
      image: image,
      fit: fit,
      width: double.infinity,
      height: double.infinity,
      gaplessPlayback: true,
      frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) =>
          wasSynchronouslyLoaded
          ? child
          : AnimatedSwitcher(
              duration: _fadeIn,
              child: frame == null
                  ? LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) => DsSkeletonizer(
                        child: Bone(width: constraints.maxWidth, height: constraints.maxHeight),
                      ),
                    )
                  : child,
            ),
      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) => DsPhoto(borderRadius: borderRadius),
    ),
  );
}
