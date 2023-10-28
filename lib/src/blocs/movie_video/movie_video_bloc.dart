import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/src/data/models/video_model.dart';
import 'package:movie_finder/src/data/repositories/movie_repo.dart';

part 'movie_video_event.dart';
part 'movie_video_state.dart';

class MovieVideoBloc extends Bloc<MovieVideoEvent, MovieVideoState> {
  final MoviesRepo _repo;

  MovieVideoBloc(this._repo) : super(MovieVideoInitial()) {
    on<LoadMovieVideo>((event, emit) async {
      try {
        emit(MovieVideoLoading());
        List<VideoModel> videos = await _repo.getVideo(id: event.id);
        emit(MovieVideoSuccess(videos: videos));
      } catch (e) {
        emit(MovieVideoError(e.toString()));
      }
    });
  }
}
