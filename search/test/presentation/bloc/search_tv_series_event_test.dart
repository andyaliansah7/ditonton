import 'package:flutter_test/flutter_test.dart';
import 'package:search/presentation/bloc/tv_series/search_tv_series_event.dart';

void main() {
  group('SearchTvSeriesEvent', () {
    test('props should contain query', () {
      const query = 'query';
      expect(const SearchTvSeriesEvent(query).props, [query]);
    });

    test('props should not be equal for different queries', () {
      const query1 = 'Query 1';
      const query2 = 'Query 2';
      expect(const SearchTvSeriesEvent(query1).props,
          isNot(equals(const SearchTvSeriesEvent(query2).props)));
    });
  });
}
