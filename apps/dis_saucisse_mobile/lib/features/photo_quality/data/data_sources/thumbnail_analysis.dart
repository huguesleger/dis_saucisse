import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

typedef ThumbnailAnalysis = ({double sharpness, int fingerprint});

const int thumbnailAnalysisAlgorithm = 2;

class UnreadableThumbnailException implements Exception {
  const UnreadableThumbnailException();
}

ThumbnailAnalysis analyzeThumbnail(Uint8List bytes) {
  final img.Image decoded = img.decodeImage(bytes) ?? (throw const UnreadableThumbnailException());
  final img.Image gray = img.grayscale(
    decoded.width > 256 || decoded.height > 256
        ? img.copyResize(
            decoded,
            width: decoded.width >= decoded.height ? 256 : null,
            height: decoded.width < decoded.height ? 256 : null,
          )
        : decoded,
  );
  return (sharpness: laplacianVariance(gray), fingerprint: differenceHash(gray));
}

double laplacianVariance(img.Image gray) {
  double sum = 0;
  double squares = 0;
  int count = 0;
  for (int y = 1; y < gray.height - 1; y++) {
    for (int x = 1; x < gray.width - 1; x++) {
      final num laplacian =
          4 * gray.getPixel(x, y).r -
          gray.getPixel(x - 1, y).r -
          gray.getPixel(x + 1, y).r -
          gray.getPixel(x, y - 1).r -
          gray.getPixel(x, y + 1).r;
      sum += laplacian;
      squares += laplacian * laplacian;
      count++;
    }
  }
  if (count == 0) return 0;
  final double mean = sum / count;
  return squares / count - mean * mean;
}

int differenceHash(img.Image gray) {
  final img.Image small = img.copyResize(gray, width: 9, height: 8, interpolation: img.Interpolation.average);
  int hash = 0;
  for (int y = 0; y < 8; y++) {
    for (int x = 0; x < 8; x++) {
      hash = (hash << 1) | (small.getPixel(x, y).r < small.getPixel(x + 1, y).r ? 1 : 0);
    }
  }
  return hash;
}
