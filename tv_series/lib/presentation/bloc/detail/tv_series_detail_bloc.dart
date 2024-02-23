import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail.dart';

import 'tv_series_detail_event.dart';
import 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail _getTvSeriesDetail;

  TvSeriesDetailBloc(this._getTvSeriesDetail) : super(TvSeriesDetailEmpty()) {
    on<TvSeriesDetailEvent>((event, emit) async {
      emit(TvSeriesDetailLoading());
      final result = await _getTvSeriesDetail.execute(event.id);
      result.fold(
        (failure) {
          emit(TvSeriesDetailError(failure.message));
        },
        (dataDetail) {
          emit(TvSeriesDetailHasData(dataDetail));
        },
      );
    });
  }
}
