import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/detail/movie_detail_event.dart';

void main() {
  group('MovieDetailEvent', () {
    test('props should contain id', () {
      const id = 1;
      expect(const MovieDetailEvent(id).props, [id]);
    });

    test('props should not be equal for different queries', () {
      const id1 = 1;
      const id2 = 2;
      expect(const MovieDetailEvent(id1).props,
          isNot(equals(const MovieDetailEvent(id2).props)));
    });
  });
}
