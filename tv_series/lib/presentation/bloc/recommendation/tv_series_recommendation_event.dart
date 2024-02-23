import 'package:equatable/equatable.dart';

class TvSeriesRecommendationEvent extends Equatable {
  final int id;

  const TvSeriesRecommendationEvent(this.id);

  @override
  List<Object> get props => [id];
}
