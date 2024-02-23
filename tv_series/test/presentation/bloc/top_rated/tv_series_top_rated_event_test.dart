import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/top_rated/tv_series_top_rated_event.dart';

void main() {
  group('TvSeriesTopRatedEvent', () {
    test('props should empty', () {
      expect(TvSeriesTopRatedEvent().props, []);
    });
  });
}
