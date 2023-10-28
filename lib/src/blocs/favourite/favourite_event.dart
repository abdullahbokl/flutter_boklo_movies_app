part of 'favourite_bloc.dart';

@immutable
abstract class FavouriteEvent {}

class GetFavouriteMoviesEvent extends FavouriteEvent {}

class AddToFavouriteEvent extends FavouriteEvent {
  final FavoriteMovieModel movie;

  AddToFavouriteEvent({required this.movie});
}

class RemoveFromFavouriteEvent extends FavouriteEvent {
  final int movieID;

  RemoveFromFavouriteEvent({required this.movieID});
}

class DeleteAllFavouriteEvent extends FavouriteEvent {}

class CheckIfMovieIsFavouriteEvent extends FavouriteEvent {
  final int movieID;

  CheckIfMovieIsFavouriteEvent({required this.movieID});
}
