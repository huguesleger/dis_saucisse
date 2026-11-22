import 'dart:async';
import 'dart:ui' as ui;

import 'package:core_ui/core_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _PendingImage extends ImageProvider<_PendingImage> {
  const _PendingImage(this.codec);

  final Completer<ui.Codec> codec;

  @override
  Future<_PendingImage> obtainKey(ImageConfiguration configuration) => SynchronousFuture<_PendingImage>(this);

  @override
  ImageStreamCompleter loadImage(_PendingImage key, ImageDecoderCallback decode) =>
      MultiFrameImageStreamCompleter(codec: codec.future, scale: 1);
}

void main() {
  Future<void> pumpImage(WidgetTester tester, ImageProvider image) => tester.pumpWidget(
    MaterialApp(
      home: SizedBox(width: 200, height: 300, child: DsImage(image: image)),
    ),
  );

  testWidgets('shows a skeleton while the image loads', (WidgetTester tester) async {
    await pumpImage(tester, _PendingImage(Completer<ui.Codec>()));

    expect(find.byType(DsSkeletonizer), findsOneWidget);
  });

  testWidgets('shows the placeholder gradient when the image cannot be loaded', (WidgetTester tester) async {
    final Completer<ui.Codec> codec = Completer<ui.Codec>();
    await pumpImage(tester, _PendingImage(codec));

    codec.completeError(StateError('No image'));
    await tester.pumpAndSettle();

    expect(find.byType(DsPhoto), findsOneWidget);
    expect(find.byType(DsSkeletonizer), findsNothing);
  });
}
