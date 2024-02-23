import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/now_playing/tv_series_now_playing_event.dart';

void main() {
  group('TvSeriesNowPlayingEvent', () {
    test('props should empty', () {
      expect(TvSeriesNowPlayingEvent().props, []);
    });
  });
}
