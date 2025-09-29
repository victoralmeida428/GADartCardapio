// test/parse_bin_test.dart

import 'package:dart_genetic_algorithm/utils.dart';
import 'package:test/test.dart';

void main() {
  group('parseBin', () {
    test('should correctly convert a small positive number to binary', () {
      expect(parseBin(5, 4), equals([0, 1, 0, 1]));
    });

    test('should correctly convert a large positive number to binary', () {
      expect(parseBin(255, 8), equals([1, 1, 1, 1, 1, 1, 1, 1]));
    });

    test('should correctly pad with leading zeros', () {
      expect(parseBin(1, 8), equals([0, 0, 0, 0, 0, 0, 0, 1]));
    });

    test('should handle zero correctly', () {
      expect(parseBin(0, 5), equals([0, 0, 0, 0, 0]));
    });

    test('should throw an ArgumentError for a value too large', () {
      expect(() => parseBin(256, 8), throwsA(isA<ArgumentError>()));
    });
  });

  group('parseInt', () {
    test('should correctly convert a binary list for the number 42', () {
      expect(parseInt([1, 0, 1, 0, 1, 0]), equals(42));
    });

    test('should correctly convert a binary list for the number 5', () {
      expect(parseInt([1, 0, 1]), equals(5));
    });

    test('should correctly handle a binary list with leading zeros', () {
      expect(parseInt([0, 0, 0, 0, 1, 0, 1, 0]), equals(10));
    });

    test('should correctly handle a binary list for a large number (255)', () {
      expect(parseInt([1, 1, 1, 1, 1, 1, 1, 1]), equals(255));
    });

    test('should correctly handle a binary list with a single bit (1)', () {
      expect(parseInt([1]), equals(1));
    });

    test('should correctly handle a binary list with a single bit (0)', () {
      expect(parseInt([0]), equals(0));
    });

    test('should correctly handle an empty list (returning 0)', () {
      expect(parseInt([]), equals(0));
    });
  });
}
