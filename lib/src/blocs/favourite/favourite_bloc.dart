import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/favorite_movie_model.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final client = Supabase.instance.client;
  final List<FavoriteMovieModel> _movies = [];

  List<FavoriteMovieModel> get movies => _movies;

  FavouriteBloc() : super(FavouriteInitial()) {
    on<GetFavouriteMoviesEvent>(_getFavouriteMovies);
    on<AddToFavouriteEvent>(_addToFavourite);
    on<RemoveFromFavouriteEvent>(_removeFromFavourite);
    on<DeleteAllFavouriteEvent>(_deleteAllFavourite);
    on<CheckIfMovieIsFavouriteEvent>(_checkIfMovieIsFavourite);
  }

  FutureOr<void> _getFavouriteMovies(
      GetFavouriteMoviesEvent event, Emitter<FavouriteState> emit) async {
    emit(FavouriteLoading());
    try {
      print("movies.length11111: ${_movies.length} ");
      final String userId = client.auth.currentUser!.id;

      final data =
          await client.from('favorite_movies').select().eq('user_id', userId);

      _movies.clear();
      for (var i = 0; i < data.length; i++) {
        _movies.add(FavoriteMovieModel.fromMap(data[i]));
      }
      emit(FavouriteLoaded());
    } catch (e) {
      emit(FavouriteError(message: e.toString()));
    }
  }

  FutureOr<void> _addToFavourite(
      AddToFavouriteEvent event, Emitter<FavouriteState> emit) async {
    emit(FavouriteLoading());
    try {
      final map = event.movie.toMap();
      await client.from('favorite_movies').insert(map);
      _movies.add(event.movie);
      emit(FavouriteChanged());
    } on PostgrestException catch (e) {
      if (e.message.contains('unique constraint')) {
        emit(FavouriteError(message: 'Movie is already saved!'));
      } else {
        emit(FavouriteError(message: 'Something went wrong !'));
      }
    }
  }

  FutureOr<void> _removeFromFavourite(
      RemoveFromFavouriteEvent event, Emitter<FavouriteState> emit) async {
    emit(FavouriteLoading());
    try {
      await client
          .from('favorite_movies')
          .delete()
          .match({'movie_id': event.movieID});
      _movies.removeWhere((element) => element.movieID == event.movieID);
      emit(FavouriteChanged());
    } on PostgrestException catch (e) {
      emit(FavouriteError(message: e.message));
    }
  }

  FutureOr<void> _deleteAllFavourite(
      DeleteAllFavouriteEvent event, Emitter<FavouriteState> emit) async {
    emit(FavouriteLoading());
    try {
      await client.from('favorite_movies').delete().neq('user_id', 0);
      _movies.clear();
      emit(FavouriteChanged());
    } on PostgrestException catch (e) {
      emit(FavouriteError(message: e.message));
    }
  }

  FutureOr<void> _checkIfMovieIsFavourite(
      CheckIfMovieIsFavouriteEvent event, Emitter<FavouriteState> emit) async {
    emit(FavouriteLoading());
    try {
      final data = await client
          .from('favorite_movies')
          .select('id')
          .eq('user_id', client.auth.currentUser!.id)
          .eq('movie_id', event.movieID);

      if (data.data.isEmpty) {
        emit(IsFavourite(isFavourite: false));
      } else {
        emit(IsFavourite(isFavourite: true));
      }
    } on PostgrestException catch (e) {
      emit(FavouriteError(message: e.message));
    }
  }
}
