import 'package:equatable/equatable.dart';

class MovieRecommendationEvent extends Equatable {
  final int id;

  const MovieRecommendationEvent(this.id);

  @override
  List<Object> get props => [id];
}
