import 'package:core/data/models/movie_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tMovieTable = MovieTable(
      id: 1, title: "title", posterPath: "posterPath", overview: "overview");

  const Map<String, dynamic> tMovieTableJson = {
    "id": 1,
    "title": "title",
    "posterPath": "posterPath",
    "overview": "overview"
  };

  test('toJson should return a valid Map', () async {
    final result = tMovieTable.toJson();
    expect(result, tMovieTableJson);
  });
}
