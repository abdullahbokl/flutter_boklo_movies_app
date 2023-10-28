part of 'search_movie_bloc.dart';

abstract class SearchMoviesState extends Equatable {
  const SearchMoviesState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchMoviesState {}

class SearchLoadingState extends SearchMoviesState {}

class SearchSuccessState extends SearchMoviesState {}

class SearchErrorState extends SearchMoviesState {
  final String message;

  const SearchErrorState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
