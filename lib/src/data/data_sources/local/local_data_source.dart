import '../../models/movie_model.dart';

abstract class LocalDataSource {
  Future<void> cache({
    required String key,
    required List<MovieModel> movies,
    required int page,
  });

  Future<List<MovieModel>> get({required String key, required int page});
}
