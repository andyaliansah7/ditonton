import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/recommendation/tv_series_recommendation_event.dart';

void main() {
  group('TvSeriesRecommendationEvent', () {
    test('props should contain id', () {
      const id = 1;
      expect(const TvSeriesRecommendationEvent(id).props, [id]);
    });

    test('props should not be equal for different queries', () {
      const id1 = 1;
      const id2 = 2;
      expect(const TvSeriesRecommendationEvent(id1).props,
          isNot(equals(const TvSeriesRecommendationEvent(id2).props)));
    });
  });
}
