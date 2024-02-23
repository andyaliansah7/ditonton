import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/top_rated/tv_series_top_rated_state.dart';

void main() {
  group('TvSeriesTopRatedState', () {
    test('props should contain message in empty state', () {
      expect(const TvSeriesTopRatedEmpty("").props, [""]);
    });
  });
}
