import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/movie_model.dart';
import '../../data/repositories/movie_repo.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMoviesBloc extends Bloc<SearchMovieEvent, SearchMoviesState> {
  final MoviesRepo _repo;

  List<MovieModel> movies = [];

  final TextEditingController searchController = TextEditingController();

  SearchMoviesBloc(this._repo) : super(SearchInitial()) {
    on<SearchForMovieEvent>((event, emit) async {
      try {
        emit(SearchLoadingState());
        movies = await _repo.getSearchedMovie(query: event.query);
        emit(SearchSuccessState());
      } catch (e) {
        emit(SearchErrorState(message: e.toString()));
      }
    });

    on<RemoveSearchedEvent>((event, emit) {
      emit(SearchInitial());
    });
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
