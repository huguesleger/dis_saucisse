import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/photo_quality.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/photo_quality_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/bloc/photo_quality_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/photo_fixtures.dart';

class _MockPhotoQualityRepository extends Mock implements PhotoQualityRepository {}

PhotoQuality _quality(String id) => PhotoQuality(photoId: PhotoId(id), sharpness: 100, fingerprint: 0);

void main() {
  late _MockPhotoQualityRepository repository;

  setUpAll(() => registerFallbackValue(const PhotoId('fallback')));

  setUp(() {
    repository = _MockPhotoQualityRepository();
    when(() => repository.analyzePhoto(any())).thenAnswer(
      (Invocation invocation) => TaskEither.right(_quality((invocation.positionalArguments.first as PhotoId).value)),
    );
  });

  blocTest<PhotoQualityCubit, PhotoQualityState>(
    'analyzes only the photos without a stored analysis, newest first',
    setUp: () => when(
      () => repository.loadQualities(),
    ).thenReturn(TaskEither.right(<PhotoId, PhotoQuality>{const PhotoId('cake-1'): _quality('cake-1')})),
    build: () => PhotoQualityCubit(repository: repository, emitEvery: 1),
    act: (PhotoQualityCubit cubit) => cubit.analyze(saturdayPhotos),
    expect: () => <Matcher>[
      isA<PhotoQualityAnalyzing>().having((PhotoQualityAnalyzing s) => s.remaining, 'remaining', 3),
      isA<PhotoQualityAnalyzing>().having((PhotoQualityAnalyzing s) => s.remaining, 'remaining', 2),
      isA<PhotoQualityAnalyzing>().having((PhotoQualityAnalyzing s) => s.remaining, 'remaining', 1),
      isA<PhotoQualityReady>().having((PhotoQualityReady s) => s.qualities.length, 'qualities', 4),
    ],
    verify: (_) {
      verifyInOrder(<void Function()>[
        () => repository.analyzePhoto(const PhotoId('walk')),
        () => repository.analyzePhoto(const PhotoId('candles')),
        () => repository.analyzePhoto(const PhotoId('cake-2')),
      ]);
      verifyNever(() => repository.analyzePhoto(const PhotoId('cake-1')));
    },
  );

  blocTest<PhotoQualityCubit, PhotoQualityState>(
    'goes on when a photo cannot be analyzed',
    setUp: () {
      when(() => repository.loadQualities()).thenReturn(TaskEither.right(<PhotoId, PhotoQuality>{}));
      when(() => repository.analyzePhoto(const PhotoId('walk'))).thenReturn(TaskEither.left(const UnknownFailure()));
    },
    build: () => PhotoQualityCubit(repository: repository),
    act: (PhotoQualityCubit cubit) => cubit.analyze(saturdayPhotos),
    expect: () => <Matcher>[
      isA<PhotoQualityAnalyzing>(),
      isA<PhotoQualityReady>().having((PhotoQualityReady s) => s.qualities.keys, 'analyzed', <PhotoId>[
        const PhotoId('candles'),
        const PhotoId('cake-2'),
        const PhotoId('cake-1'),
      ]),
    ],
  );
}
