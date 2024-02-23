import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/now_playing/tv_series_now_playing_state.dart';

void main() {
  group('TvSeriesNowPlayingState', () {
    test('props should contain message in empty state', () {
      expect(const TvSeriesNowPlayingEmpty("").props, [""]);
    });
  });
}
