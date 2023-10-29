import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/models/movie_model.dart';
import 'search_card.dart';

class SearchResultsList extends StatelessWidget {
  const SearchResultsList({Key? key, required this.movies}) : super(key: key);

  final List<MovieModel> movies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: ListView.builder(
        itemCount: movies.length,
        padding: const EdgeInsets.only(bottom: 30),
        itemBuilder: (context, index) {
          return SearchCard(
            id: movies[index].id,
            img: movies[index].posterPath,
            title: movies[index].title,
            overview: movies[index].overview,
            release: movies[index].releaseDate,
            vote: movies[index].voteAverage,
          );
        },
      ),
    );
  }
}
