import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class StoragePreviewFolder extends StatelessWidget {
  const StoragePreviewFolder({
    super.key,
    required this.name,
    required this.depth,
    required this.emphasized,
    required this.muted,
  });

  final String name;
  final int depth;
  final bool emphasized;
  final bool muted;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(left: DsSpacing.s * depth, top: DsSpacing.xxs, bottom: DsSpacing.xxs),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsSpacing.xs,
      children: <Widget>[
        Icon(Icons.folder_outlined, size: 18, color: muted ? DsColors.textSoft : DsColors.text),
        Expanded(
          child: Text(
            name,
            style: (emphasized ? DsTextStyles.bodyBold : DsTextStyles.body).copyWith(
              fontSize: 14,
              color: muted ? DsColors.textSoft : DsColors.text,
            ),
          ),
        ),
      ],
    ),
  );
}
