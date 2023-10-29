part of 'search_movie_bloc.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

class SearchForMovieEvent extends SearchMovieEvent {
  const SearchForMovieEvent();

  @override
  List<Object> get props => [];
}

class RemoveSearchedEvent extends SearchMovieEvent {
  const RemoveSearchedEvent();
}
