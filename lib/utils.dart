import 'dart:math';

List<int> parseBin(int value, int bit) {
  final maximo = pow(2, bit) - 1;
  if (value > maximo) {
    throw ArgumentError('Valor $value não pode ser maior que $maximo');
  }
  final valorBinStr = value.toRadixString(2);
  final valorBinStrPadded = valorBinStr.padLeft(bit, '0');
  return valorBinStrPadded.split('').map(int.parse).toList();
}

int parseInt(List<int> values) {
  int decimalValue = 0;
  for (int bit in values) {
    decimalValue = (decimalValue << 1) | bit;
  }
  return decimalValue;
}
