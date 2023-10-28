import 'dart:convert';

import 'package:hive/hive.dart';

import '../../../../core/utils/app_strings.dart';
import '../../models/movie_model.dart';
import 'local_data_source.dart';

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<void> cache(
      {required String key,
      required List<MovieModel> movies,
      required int page}) async {
    if (page == 1) {
      final movieBox = await Hive.openBox(AppStrings.hiveBox);
      return movieBox.put(
          key, json.encode(movies.map((e) => e.toJson()).toList()));
    }
  }

  @override
  Future<List<MovieModel>> get({required String key, required int page}) async {
    if (page == 1) {
      final movieBox = await Hive.openBox(AppStrings.hiveBox);
      final cachedMovies = movieBox.get(key);
      if (cachedMovies != null) {
        return json
            .decode(cachedMovies)
            .map<MovieModel>((e) => MovieModel.fromJson(e))
            .toList();
      } else {
        throw 'Empty Cache !!';
      }
    } else {
      return <MovieModel>[];
    }
  }
}
