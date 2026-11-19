import 'package:dis_saucisse_mobile/features/transfer/data/data_sources/heic_converter_data_source.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const MethodChannel channel = MethodChannel('test/heic');
  final Uint8List heic = Uint8List.fromList(<int>[1, 2, 3]);

  void answer(Object? Function(MethodCall call) handler) => TestDefaultBinaryMessengerBinding
      .instance
      .defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (MethodCall call) async => handler(call));

  tearDown(
    () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null),
  );

  test('asks the platform for a JPEG copy of the HEIC bytes', () async {
    late MethodCall received;
    answer((MethodCall call) {
      received = call;
      return Uint8List.fromList(<int>[9, 9]);
    });

    final Uint8List jpeg = await HeicConverterDataSource(channel: channel).toJpeg(heic);

    expect(jpeg, <int>[9, 9]);
    expect(received.method, 'toJpeg');
    expect((received.arguments as Map<Object?, Object?>)['bytes'], heic);
  });

  test('fails when the platform cannot convert the photo', () async {
    answer((MethodCall call) => throw PlatformException(code: 'conversion_failed'));

    await expectLater(HeicConverterDataSource(channel: channel).toJpeg(heic), throwsA(isA<PlatformException>()));
  });

  test('fails when the platform returns nothing', () async {
    answer((MethodCall call) => null);

    await expectLater(
      HeicConverterDataSource(channel: channel).toJpeg(heic),
      throwsA(isA<HeicConversionException>()),
    );
  });
}
