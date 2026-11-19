import 'dart:io';

import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class ReceptionPhotoTile extends StatelessWidget {
  const ReceptionPhotoTile({super.key, required this.filePath, required this.placeholderIndex});

  final Option<String> filePath;
  final int placeholderIndex;

  @override
  Widget build(BuildContext context) => filePath.match(
    () => Opacity(
      opacity: 0.35,
      child: DsPhoto(placeholderIndex: placeholderIndex, borderRadius: DsRadius.smallAll),
    ),
    (String path) => Stack(
      fit: StackFit.expand,
      children: <Widget>[
        DsPhoto(
          image: ResizeImage(FileImage(File(path)), width: 160),
          placeholderIndex: placeholderIndex,
          borderRadius: DsRadius.smallAll,
        ),
        const Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.all(DsSpacing.xxs),
            child: DecoratedBox(
              decoration: BoxDecoration(color: DsColors.background, shape: BoxShape.circle),
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Icon(Icons.check_rounded, size: 14, color: DsColors.success),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
