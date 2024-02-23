import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tGenreModel = GenreModel(id: 1, name: 'name');
  const tGenre = Genre(id: 1, name: 'name');

  const Map<String, dynamic> tGenreModelJson = {"id": 1, "name": 'name'};

  test('should be a subclass of Genre entity', () async {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });

  test('toJson should return a valid Map', () async {
    final result = tGenreModel.toJson();
    expect(result, tGenreModelJson);
  });

  test('props should return a list of all properties', () async {
    final props = tGenreModel.props;

    expect(props.length, 2);

    expect(props.contains(tGenreModel.id), true);
    expect(props.contains(tGenreModel.name), true);
  });
}
