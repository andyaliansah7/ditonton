import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:tv_series/presentation/bloc/top_rated/tv_series_top_rated_event.dart';
import 'package:tv_series/presentation/bloc/top_rated/tv_series_top_rated_state.dart';

class TvSeriesTopRatedBloc
    extends Bloc<TvSeriesTopRatedEvent, TvSeriesTopRatedState> {
  final GetTopRatedTvSeries _getTopRatedTvSeries;

  TvSeriesTopRatedBloc(this._getTopRatedTvSeries)
      : super(const TvSeriesTopRatedEmpty()) {
    on<TvSeriesTopRatedEvent>((event, emit) async {
      emit(TvSeriesTopRatedLoading());
      final result = await _getTopRatedTvSeries.execute();
      result.fold(
        (failure) {
          emit(TvSeriesTopRatedError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(const TvSeriesTopRatedEmpty("No Data"));
          } else {
            emit(TvSeriesTopRatedHasData(data));
          }
        },
      );
    });
  }
}
