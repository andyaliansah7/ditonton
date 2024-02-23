import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:tv_series/presentation/bloc/popular/tv_series_popular_event.dart';
import 'package:tv_series/presentation/bloc/popular/tv_series_popular_state.dart';

class TvSeriesPopularBloc
    extends Bloc<TvSeriesPopularEvent, TvSeriesPopularState> {
  final GetPopularTvSeries _getTvSeriesPopular;

  TvSeriesPopularBloc(this._getTvSeriesPopular)
      : super(const TvSeriesPopularEmpty()) {
    on<TvSeriesPopularEvent>((event, emit) async {
      emit(TvSeriesPopularLoading());
      final result = await _getTvSeriesPopular.execute();
      result.fold(
        (failure) {
          emit(TvSeriesPopularError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(const TvSeriesPopularEmpty("No Data"));
          } else {
            emit(TvSeriesPopularHasData(data));
          }
        },
      );
    });
  }
}
