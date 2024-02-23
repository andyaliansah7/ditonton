import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/recommendation/movie_recommendation_state.dart';

void main() {
  group('MovieRecommendationState', () {
    test('props should contain message in empty state', () {
      expect(const MovieRecommendationEmpty("").props, [""]);
    });
  });
}
