import '../../models/cast_model.dart';
import '../../models/movie_details_model.dart';
import '../../models/movie_model.dart';
import '../../models/video_model.dart';

abstract class RemoteDataSource {
  Future<List<MovieModel>> getPopular({required int page});

  Future<List<MovieModel>> getTrending({required int page});

  Future<List<MovieModel>> getUpcoming({required int page});

  Future<List<MovieModel>> getSearchedMovie({required String query});

  Future<MovieDetailsModel> getMovieDetails({required int id});

  Future<List<dynamic>> getImages({required int id});

  Future<List<CastCrewModel>> getCastCrew({required int id});

  Future<List<VideoModel>> getVideo({required int id});
}
