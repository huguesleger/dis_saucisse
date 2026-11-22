import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/formatting/french_dates.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:flutter/material.dart';

class DiscardedPhotoDetails extends StatelessWidget {
  const DiscardedPhotoDetails({super.key, required this.photo});

  final LibraryPhoto photo;

  @override
  Widget build(BuildContext context) => Row(
    spacing: DsSpacing.xs,
    children: <Widget>[
      const Icon(Icons.calendar_today_outlined, size: 22, color: DsColors.text),
      Expanded(child: Text(frenchLongDate(photo.takenAt), style: DsTextStyles.bodyBold)),
    ],
  );
}
