import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/movie_details_model.dart';
import '../../data/repositories/movie_repo.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MoviesRepo _repo;

  MovieDetailsBloc(this._repo) : super(MovieDetailsInitial()) {
    on<LoadMovieDetails>((event, emit) async {
      try {
        emit(MovieDetailsLoading());
        MovieDetailsModel movie = await _repo.getMovieDetails(id: event.id);
        emit(MovieDetailsSuccess(movie: movie));
      } catch (e) {
        emit(MovieDetailsError(e.toString()));
      }
    });
  }
}
