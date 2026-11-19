import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_text_styles.dart';
import 'package:core_ui/src/widgets/media/ds_photo.dart';
import 'package:flutter/widgets.dart';

/// Overlapping round thumbnails with a "+N" counter.
class DsAvatarStack extends StatelessWidget {
  const DsAvatarStack({super.key, required this.images, this.extraCount = 0, this.size = 28});

  final List<ImageProvider?> images;
  final int extraCount;
  final double size;

  @override
  Widget build(BuildContext context) {
    final double step = size * 0.7;
    final int count = images.length + (extraCount > 0 ? 1 : 0);
    return SizedBox(
      width: count == 0 ? 0 : step * (count - 1) + size,
      height: size,
      child: Stack(
        children: <Widget>[
          for (final (int index, ImageProvider? image) in images.indexed)
            Positioned(
              left: step * index,
              child: Container(
                width: size,
                height: size,
                padding: const EdgeInsets.all(1.5),
                decoration: const BoxDecoration(color: DsColors.background, shape: BoxShape.circle),
                child: DsPhoto(
                  image: image,
                  placeholderIndex: index,
                  borderRadius: BorderRadius.circular(size),
                ),
              ),
            ),
          if (extraCount > 0)
            Positioned(
              left: step * images.length,
              child: Container(
                width: size,
                height: size,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: DsColors.mustard,
                  shape: BoxShape.circle,
                  border: Border.all(color: DsColors.background, width: 1.5),
                ),
                child: Text('+$extraCount', style: DsTextStyles.caption.copyWith(color: DsColors.onMustard)),
              ),
            ),
        ],
      ),
    );
  }
}
