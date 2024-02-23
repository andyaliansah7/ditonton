import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
import 'package:search/presentation/bloc/tv_series/search_tv_series_event.dart';
import 'package:search/presentation/bloc/tv_series/search_tv_series_state.dart';

class SearchTvSeriesBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final SearchTvSeries _searchTvSeries;

  SearchTvSeriesBloc(this._searchTvSeries)
      : super(const SearchTvSeriesEmpty()) {
    on<SearchTvSeriesEvent>((event, emit) async {
      final query = event.query;

      emit(SearchTvSeriesLoading());
      final result = await _searchTvSeries.execute(query);

      result.fold(
        (failure) {
          emit(SearchTvSeriesError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(const SearchTvSeriesEmpty("No TV Series Found"));
          } else {
            emit(SearchTvSeriesHasData(data));
          }
        },
      );
    }, transformer: debounceTvSeries(const Duration(milliseconds: 500)));
  }
}
