import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/top_rated/movie_top_rated_state.dart';

void main() {
  group('MovieTopRatedState', () {
    test('props should contain message in empty state', () {
      expect(const MovieTopRatedEmpty("").props, [""]);
    });
  });
}
