import 'package:equatable/equatable.dart';

class TvSeriesDetailEvent extends Equatable {
  final int id;

  const TvSeriesDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}
