import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/bloc/reception_cubit.dart';
import 'package:dis_saucisse_desktop/features/reception/presentation/widgets/reception_photo_tile.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class ReceptionCurrentFolderCard extends StatelessWidget {
  const ReceptionCurrentFolderCard({super.key, required this.progress});

  final ReceptionInProgress progress;

  @override
  Widget build(BuildContext context) {
    final int upcoming = (progress.expected - progress.received - progress.rejected).clamp(
      0,
      ReceptionInProgress.shownFolderPhotos - progress.folderPhotoPaths.length,
    );
    return DsCard(
      padding: const EdgeInsets.all(DsSpacing.xl),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              spacing: DsSpacing.s,
              children: <Widget>[
                const DsIconSquare(icon: Icons.folder_open_rounded, size: 44),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(t.reception.currentFolder.storingIn, style: DsTextStyles.caption),
                      Text(
                        progress.currentFolder.match(
                          () => t.reception.currentFolder.waitingFirstPhoto,
                          (String folder) => folder.replaceAll('/', ' / '),
                        ),
                        style: DsTextStyles.titleM.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: DsSpacing.l),
            GridView.count(
              crossAxisCount: 6,
              mainAxisSpacing: DsSpacing.xs,
              crossAxisSpacing: DsSpacing.xs,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                for (final String path in progress.folderPhotoPaths)
                  ReceptionPhotoTile(filePath: some(path), placeholderIndex: path.hashCode),
                for (int index = 0; index < upcoming; index++)
                  ReceptionPhotoTile(filePath: none(), placeholderIndex: progress.received + index),
              ],
            ),
            const SizedBox(height: DsSpacing.s),
            Text(
              progress.folderPhotoCount > 1
                  ? t.reception.currentFolder.eventSeveral(
                      event: progress.events.length,
                      count: progress.folderPhotoCount,
                    )
                  : t.reception.currentFolder.eventSingle(
                      event: progress.events.length,
                      count: progress.folderPhotoCount,
                    ),
              style: DsTextStyles.caption,
            ),
          ],
        ),
      ),
    );
  }
}
