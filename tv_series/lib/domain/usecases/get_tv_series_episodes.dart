import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_series_episode.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';

class GetTvSeriesEpisodes {
  final TvSeriesRepository repository;

  GetTvSeriesEpisodes(this.repository);

  Future<Either<Failure, List<TvSeriesEpisode>>> execute(id, seasonNumber) {
    return repository.getTvSeriesEpisodes(id, seasonNumber);
  }
}
