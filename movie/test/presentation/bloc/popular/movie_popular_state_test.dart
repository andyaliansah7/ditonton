import 'package:flutter_test/flutter_test.dart';
import 'package:movie/movie.dart';

void main() {
  group('MoviePopularState', () {
    test('props should contain message in empty state', () {
      expect(const MoviePopularEmpty("").props, [""]);
    });
  });
}
