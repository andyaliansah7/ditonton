import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/detail/tv_series_detail_event.dart';

void main() {
  group('TvSeriesDetailEvent', () {
    test('props should contain id', () {
      const id = 1;
      expect(const TvSeriesDetailEvent(id).props, [id]);
    });

    test('props should not be equal for different queries', () {
      const id1 = 1;
      const id2 = 2;
      expect(const TvSeriesDetailEvent(id1).props,
          isNot(equals(const TvSeriesDetailEvent(id2).props)));
    });
  });
}
