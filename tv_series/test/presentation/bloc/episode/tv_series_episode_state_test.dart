import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/episode/tv_series_episode_state.dart';

void main() {
  group('TvSeriesEpisodeState', () {
    test('props should contain message in empty state', () {
      expect(const TvSeriesEpisodeEmpty("").props, [""]);
    });
  });
}
