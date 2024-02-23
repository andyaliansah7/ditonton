import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/popular/tv_series_popular_state.dart';

void main() {
  group('TvSeriesPopularState', () {
    test('props should contain message in empty state', () {
      expect(const TvSeriesPopularEmpty("").props, [""]);
    });
  });
}
