import 'package:core/data/models/tv_series_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';

const testTvSeries = TvSeries(
    backdropPath: '/uJUe985oIuRiD3hmHQYskIMc2WU.jpg',
    firstAirDate: '2015-06-24',
    genreIds: [80, 18],
    id: 62560,
    name: 'Mr. Robot',
    originalLanguage: 'en',
    originalName: 'Mr. Robot',
    overview:
        'A contemporary and culturally resonant drama about a young programmer, Elliot, who suffers from a debilitating anti-social disorder and decides that he can only connect to people by hacking them. He wields his skills as a weapon to protect the people that he cares about. Elliot will find himself in the intersection between a cybersecurity firm he works for and the underworld organizations that are recruiting him to bring down corporate America.',
    popularity: 408.127,
    posterPath: '/oKIBhzZzDX07SoE2bOLhq2EE8rf.jpg',
    voteAverage: 8.236,
    voteCount: 4293);

final testTvSeriesList = [testTvSeries];

const testTvSeriesDetail = TvSeriesDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    voteAverage: 1,
    voteCount: 1,
    seasons: [
      Season(
          airDate: 'airDate',
          episodeCount: 1,
          id: 1,
          name: 'name',
          overview: 'overview',
          posterPath: 'posterPath',
          seasonNumber: 1,
          voteAverage: 1)
    ]);

const testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesMap = {
  'id': 1,
  'name': 'name',
  'posterPath': 'posterPath',
  'overview': 'overview',
};
