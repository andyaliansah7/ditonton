import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/recommendation/movie_recommendation_event.dart';

void main() {
  group('MovieRecommendationEvent', () {
    test('props should contain id', () {
      const id = 1;
      expect(const MovieRecommendationEvent(id).props, [id]);
    });

    test('props should not be equal for different queries', () {
      const id1 = 1;
      const id2 = 2;
      expect(const MovieRecommendationEvent(id1).props,
          isNot(equals(const MovieRecommendationEvent(id2).props)));
    });
  });
}
