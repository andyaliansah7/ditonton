import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/presentation/bloc/movie/search_movie_bloc.dart';
import 'package:search/presentation/bloc/movie/search_movie_event.dart';
import 'package:search/presentation/bloc/movie/search_movie_state.dart';

import 'search_movie_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMovieBloc searchMovieBloc;
  late MockSearchMovies mockSearchMovies;

  const tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchMovieBloc = SearchMovieBloc(mockSearchMovies);
  });

  test('Initial state should be empty', () {
    expect(searchMovieBloc.state, const SearchMovieEmpty());
  });

  blocTest<SearchMovieBloc, SearchMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      return searchMovieBloc;
    },
    act: (bloc) => bloc.add(const SearchMovieEvent(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchMovieLoading(),
      SearchMovieHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  blocTest<SearchMovieBloc, SearchMovieState>(
    'Should emit [Loading, Empty] when get search is return empty',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => const Right([]));
      return searchMovieBloc;
    },
    act: (bloc) => bloc.add(const SearchMovieEvent(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchMovieLoading(),
      const SearchMovieEmpty('No Movies Found'),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  blocTest<SearchMovieBloc, SearchMovieState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchMovieBloc;
    },
    act: (bloc) => bloc.add(const SearchMovieEvent(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchMovieLoading(),
      const SearchMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );
}
