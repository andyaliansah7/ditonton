import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/episode/tv_series_episode_event.dart';

void main() {
  group('TvSeriesEpisodeEvent', () {
    test('props should contain id', () {
      const id = 1;
      const seasonNumber = 1;
      expect(const TvSeriesEpisodeEvent(id, seasonNumber).props,
          [id, seasonNumber]);
    });

    test('props should not be equal for different queries', () {
      const id1 = 1;
      const id2 = 2;

      const seasonNumber1 = 1;
      const seasonNumber2 = 2;
      expect(const TvSeriesEpisodeEvent(id1, seasonNumber1).props,
          isNot(equals(const TvSeriesEpisodeEvent(id2, seasonNumber2).props)));
    });
  });
}
