import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/popular/tv_series_popular_event.dart';

void main() {
  group('Tv Series Popular', () {
    test('props should empty', () {
      expect(TvSeriesPopularEvent().props, []);
    });
  });
}
