import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

class HomeFaceAvatar extends StatelessWidget {
  const HomeFaceAvatar({super.key, required this.name, required this.placeholderIndex});

  final String name;
  final int placeholderIndex;

  @override
  Widget build(BuildContext context) => Column(
    spacing: DsSpacing.xs - 2,
    children: <Widget>[
      DsPhoto(placeholderIndex: placeholderIndex, width: 56, height: 56, borderRadius: DsRadius.mediumAll),
      Text(name, style: DsTextStyles.caption.copyWith(color: DsColors.text, fontSize: 11)),
    ],
  );
}
