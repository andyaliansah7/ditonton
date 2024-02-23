import 'package:flutter_test/flutter_test.dart';
import 'package:search/presentation/bloc/movie/search_movie_event.dart';

void main() {
  group('SearchMovieEvent', () {
    test('props should contain query', () {
      const query = 'query';
      expect(const SearchMovieEvent(query).props, [query]);
    });

    test('props should not be equal for different queries', () {
      const query1 = 'Query 1';
      const query2 = 'Query 2';
      expect(const SearchMovieEvent(query1).props,
          isNot(equals(const SearchMovieEvent(query2).props)));
    });
  });
}
