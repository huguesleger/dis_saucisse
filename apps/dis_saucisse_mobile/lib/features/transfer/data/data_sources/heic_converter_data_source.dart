import 'package:flutter/services.dart';

class HeicConversionException implements Exception {
  const HeicConversionException();
}

class HeicConverterDataSource {
  HeicConverterDataSource({MethodChannel channel = const MethodChannel('fr.huguesleger.dissaucisse/heic')})
    : _channel = channel;

  static const double _quality = 0.92;

  final MethodChannel _channel;

  Future<Uint8List> toJpeg(Uint8List heic) async =>
      await _channel.invokeMethod<Uint8List>('toJpeg', <String, Object>{'bytes': heic, 'quality': _quality}) ??
      (throw const HeicConversionException());
}
