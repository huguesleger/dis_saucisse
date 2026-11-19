import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/foundation/ds_text_styles.dart';
import 'package:flutter/widgets.dart';

class DsGallerySection extends StatelessWidget {
  const DsGallerySection({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: DsSpacing.xxl),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: DsTextStyles.titleL),
        const SizedBox(height: DsSpacing.s),
        child,
      ],
    ),
  );
}
