String byteSizeLabel(int bytes) {
  const int megabyte = 1000 * 1000;
  const int gigabyte = 1000 * megabyte;
  String oneDecimal(double value) => value.toStringAsFixed(1).replaceAll('.', ',');
  return bytes >= gigabyte ? '${oneDecimal(bytes / gigabyte)} Go' : '${(bytes / megabyte).ceil()} Mo';
}
