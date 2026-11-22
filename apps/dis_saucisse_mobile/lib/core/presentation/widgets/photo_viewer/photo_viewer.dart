import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/presentation/widgets/photo_viewer/photo_viewer_page.dart';
import 'package:dis_saucisse_mobile/core/presentation/widgets/photo_viewer/photo_viewer_top_bar.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/material.dart';

class PhotoViewer extends StatefulWidget {
  const PhotoViewer({
    super.key,
    required this.photos,
    required this.initialIndex,
    required this.title,
    required this.panelBuilder,
  });

  final List<PhotoId> photos;
  final int initialIndex;
  final String title;
  final Widget Function(BuildContext context, int index) panelBuilder;

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
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
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: DsColors.text,
    body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        PageView.builder(
          controller: _pages,
          itemCount: widget.photos.length,
          onPageChanged: (int index) => setState(() => _index = index),
          itemBuilder: (BuildContext context, int index) => PhotoViewerPage(
            photoId: widget.photos[index],
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
              _chrome(PhotoViewerTopBar(title: widget.title, position: _index, count: widget.photos.length)),
              const Spacer(),
              _chrome(widget.panelBuilder(context, _index)),
            ],
          ),
        ),
      ],
    ),
  );
}
