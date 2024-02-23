import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/top_rated/movie_top_rated_event.dart';

void main() {
  group('MovieTopRatedEvent', () {
    test('props should empty', () {
      expect(MovieTopRatedEvent().props, []);
    });
  });
}
