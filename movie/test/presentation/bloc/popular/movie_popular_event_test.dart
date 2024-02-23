import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/popular/movie_popular_event.dart';

void main() {
  group('Movie Popular', () {
    test('props should empty', () {
      expect(MoviePopularEvent().props, []);
    });
  });
}
