import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/pairing_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image/image.dart' as img;
import 'package:zxing2/qrcode.dart';

class QrImageDataSource {
  static const int _maxSide = 1600;

  TaskEither<AppFailure, Option<String>> readQrCode(String imagePath) =>
      TaskEither<AppFailure, Option<String>>.tryCatch(() async {
        final Uint8List bytes = await File(imagePath).readAsBytes();
        return Isolate.run(() => _decode(bytes));
      }, _failure);

  static Option<String> _decode(Uint8List bytes) => Option<img.Image>.fromNullable(img.decodeImage(bytes))
      .map(
        (img.Image image) => image.width > _maxSide || image.height > _maxSide
            ? img.copyResize(
                image,
                width: image.width >= image.height ? _maxSide : null,
                height: image.height > image.width ? _maxSide : null,
              )
            : image,
      )
      .flatMap((img.Image image) {
        final Int32List pixels = image
            .convert(numChannels: 4)
            .getBytes(order: img.ChannelOrder.bgra)
            .buffer
            .asInt32List();
        final BinaryBitmap bitmap = BinaryBitmap(
          HybridBinarizer(RGBLuminanceSource(image.width, image.height, pixels)),
        );
        return Either<Object, String>.tryCatch(
          () => QRCodeReader().decode(bitmap).text,
          (Object error, StackTrace _) => error,
        ).toOption();
      });

  AppFailure _failure(Object error, StackTrace stackTrace) {
    log('QR image unreadable', error: error, stackTrace: stackTrace, name: 'pairing');
    return const QrImageUnreadableFailure();
  }
}
