import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class MovieRecommendationState extends Equatable {
  const MovieRecommendationState();

  @override
  List<Object> get props => [];
}

class MovieRecommendationEmpty extends MovieRecommendationState {
  final String message;

  const MovieRecommendationEmpty([this.message = ""]);

  @override
  List<Object> get props => [message];
}

class MovieRecommendationLoading extends MovieRecommendationState {}

class MovieRecommendationHasData extends MovieRecommendationState {
  final List<Movie> movies;

  const MovieRecommendationHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieRecommendationError extends MovieRecommendationState {
  final String message;

  const MovieRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}
