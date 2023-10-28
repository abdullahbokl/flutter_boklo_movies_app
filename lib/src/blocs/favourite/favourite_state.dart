part of 'favourite_bloc.dart';

@immutable
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteLoaded extends FavouriteState {}

class FavouriteChanged extends FavouriteState {}

class FavouriteError extends FavouriteState {
  final String message;

  FavouriteError({required this.message});
}

class IsFavourite extends FavouriteState {
  final bool isFavourite;

  IsFavourite({required this.isFavourite});
}
