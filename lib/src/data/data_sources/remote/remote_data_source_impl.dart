import '../../../../core/services/api_services.dart';
import '../../models/cast_model.dart';
import '../../models/movie_details_model.dart';
import '../../models/movie_model.dart';
import '../../models/video_model.dart';
import 'remote_data_source.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  // final DioClient _dioClient;
  final ApiServices apiServices;

  RemoteDataSourceImpl(this.apiServices);

  @override
  Future<List<MovieModel>> getPopular({required int page}) async {
    try {
      final response = await apiServices.get(
        endPoint: 'movie/popular',
        queryParameters: {
          'page': page,
        },
      );

      final movies = response['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();

      return movies;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>> getTrending({required int page}) async {
    try {
      final response = await apiServices.get(
        endPoint: 'trending/movie/day',
        queryParameters: {
          'page': page,
        },
      );
      final movies = response['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
      return movies;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>> getUpcoming({required int page}) async {
    try {
      final response = await apiServices.get(
        endPoint: 'movie/upcoming',
        queryParameters: {
          'page': page,
        },
      );
      final movies = response['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
      return movies;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>> getSearchedMovie({required String query}) async {
    try {
      final response = await apiServices.get(
        endPoint: 'search/movie',
        queryParameters: {
          'query': query,
        },
      );
      final movies = response['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
      return movies;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails({required int id}) async {
    try {
      final response = await apiServices.get(
        endPoint: 'movie/$id',
      );
      final movies = MovieDetailsModel.fromMap(response);

      return movies;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> getImages({required int id}) async {
    try {
      final response = await apiServices.get(
        endPoint: 'movie/$id/images',
      );
      final images = response['backdrops'];

      return images;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<CastCrewModel>> getCastCrew({required int id}) async {
    try {
      final response = await apiServices.get(
        endPoint: 'movie/$id/credits',
      );
      final cast = response['cast']
          .map<CastCrewModel>((json) => CastCrewModel.fromJson(json))
          .toList();

      return cast;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<VideoModel>> getVideo({required int id}) async {
    try {
      final response = await apiServices.get(
        endPoint: 'movie/$id/videos',
      );
      final cast = response['results']
          .map<VideoModel>((json) => VideoModel.fromJson(json))
          .toList();

      return cast;
    } catch (_) {
      rethrow;
    }
  }
}
