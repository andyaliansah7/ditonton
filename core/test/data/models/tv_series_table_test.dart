import 'package:core/data/models/tv_series_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvSeriesTable = TvSeriesTable(
      id: 1, name: "name", posterPath: "posterPath", overview: "overview");

  const Map<String, dynamic> tTvSeriesTableJson = {
    "id": 1,
    "name": "name",
    "posterPath": "posterPath",
    "overview": "overview"
  };

  test('toJson should return a valid Map', () async {
    final result = tTvSeriesTable.toJson();
    expect(result, tTvSeriesTableJson);
  });
}
