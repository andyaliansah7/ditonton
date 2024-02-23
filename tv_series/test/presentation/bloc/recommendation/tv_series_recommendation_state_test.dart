import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/recommendation/tv_series_recommendation_state.dart';

void main() {
  group('TvSeriesRecommendationState', () {
    test('props should contain message in empty state', () {
      expect(const TvSeriesRecommendationEmpty("").props, [""]);
    });
  });
}
