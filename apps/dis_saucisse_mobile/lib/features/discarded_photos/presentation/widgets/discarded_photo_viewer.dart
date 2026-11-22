import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/widgets/discarded_photo_viewer_page.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/widgets/discarded_photo_viewer_panel.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/widgets/discarded_photo_viewer_top_bar.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:flutter/material.dart';

class DiscardedPhotoViewer extends StatefulWidget {
  const DiscardedPhotoViewer({super.key, required this.photos, required this.initialIndex, required this.canRestore});

  final List<LibraryPhoto> photos;
  final int initialIndex;
  final bool canRestore;

  @override
  State<DiscardedPhotoViewer> createState() => _DiscardedPhotoViewerState();
}

class _DiscardedPhotoViewerState extends State<DiscardedPhotoViewer> {
  static const Duration _fade = Duration(milliseconds: 200);

  late final PageController _pages = PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;
  bool _chromeVisible = true;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  Widget _chrome(Widget child) => IgnorePointer(
    ignoring: !_chromeVisible,
    child: AnimatedOpacity(opacity: _chromeVisible ? 1 : 0, duration: _fade, child: child),
  );

  @override
  Widget build(BuildContext context) {
    final LibraryPhoto photo = widget.photos[_index];
    return Scaffold(
      backgroundColor: DsColors.text,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          PageView.builder(
            controller: _pages,
            itemCount: widget.photos.length,
            onPageChanged: (int index) => setState(() => _index = index),
            itemBuilder: (BuildContext context, int index) => DiscardedPhotoViewerPage(
              photoId: widget.photos[index].id,
              onTap: () => setState(() => _chromeVisible = !_chromeVisible),
            ),
          ),
          _chrome(
            const IgnorePointer(
              child: DecoratedBox(decoration: BoxDecoration(gradient: DsGradients.photoScrim)),
            ),
          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                _chrome(DiscardedPhotoViewerTopBar(position: _index, count: widget.photos.length)),
                const Spacer(),
                _chrome(
                  DiscardedPhotoViewerPanel(
                    photo: photo,
                    canRestore: widget.canRestore,
                    onRestore: () => Navigator.of(context).pop(photo.id),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
