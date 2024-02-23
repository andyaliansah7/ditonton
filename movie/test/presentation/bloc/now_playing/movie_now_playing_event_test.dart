import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/now_playing/movie_now_playing_event.dart';

void main() {
  group('MovieNowPlayingEvent', () {
    test('props should empty', () {
      expect(MovieNowPlayingEvent().props, []);
    });
  });
}
