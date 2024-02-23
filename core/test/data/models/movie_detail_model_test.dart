import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/movie_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieDetailModel = MovieDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 1,
      genres: List<GenreModel>.empty(),
      homepage: 'homepage',
      id: 1,
      imdbId: 'imdbId',
      originalLanguage: 'originalLanguage',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1.0,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 1,
      runtime: 1,
      status: 'status',
      tagline: 'tagline',
      title: 'title',
      video: true,
      voteAverage: 1.0,
      voteCount: 1);

  final Map<String, dynamic> tMovieDetailModelJson = {
    "adult": false,
    "backdrop_path": 'backdropPath',
    "budget": 1,
    "genres": List<GenreModel>.empty(),
    "homepage": 'homepage',
    "id": 1,
    "imdb_id": 'imdbId',
    "original_language": 'originalLanguage',
    "original_title": 'originalTitle',
    "overview": 'overview',
    "popularity": 1.0,
    "poster_path": 'posterPath',
    "release_date": 'releaseDate',
    "revenue": 1,
    "runtime": 1,
    "status": 'status',
    "tagline": 'tagline',
    "title": 'title',
    "video": true,
    "vote_average": 1.0,
    "vote_count": 1
  };

  test('toJson should return a valid Map', () async {
    final result = tMovieDetailModel.toJson();
    expect(result, tMovieDetailModelJson);
  });
}
