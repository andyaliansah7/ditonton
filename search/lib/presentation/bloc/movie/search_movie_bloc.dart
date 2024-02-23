import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/presentation/bloc/movie/search_movie_event.dart';
import 'package:search/presentation/bloc/movie/search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies _searchMovies;

  SearchMovieBloc(this._searchMovies) : super(const SearchMovieEmpty()) {
    on<SearchMovieEvent>((event, emit) async {
      final query = event.query;

      emit(SearchMovieLoading());
      final result = await _searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(SearchMovieError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(const SearchMovieEmpty("No Movies Found"));
          } else {
            emit(SearchMovieHasData(data));
          }
        },
      );
    }, transformer: debounceMovie(const Duration(milliseconds: 500)));
  }
}
