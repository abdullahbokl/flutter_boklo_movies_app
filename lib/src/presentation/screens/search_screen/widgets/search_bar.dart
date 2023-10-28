import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../../blocs/search_movies/search_movie_bloc.dart';
import '../../../widgets/custom_text_field.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchBloc = getIt<SearchMoviesBloc>();
    return CustomTextField(
      hint: 'Search For A Movie ...',
      icon: FontAwesomeIcons.searchengin,
      textEditingController: searchBloc.searchController,
      isSufix: true,
      onchange: (query) {
        if (searchBloc.searchController.text.length > 2) {
          searchBloc.add(SearchForMovieEvent(query: query));
        } else if (searchBloc.searchController.text.isEmpty) {
          searchBloc.add(const RemoveSearchedEvent());
        }
      },
      onsubmit: (query) {
        if (searchBloc.searchController.text.isNotEmpty &&
            searchBloc.searchController.text.length <= 2) {
          searchBloc.add(SearchForMovieEvent(query: query));
        } else {
          searchBloc.add(const RemoveSearchedEvent());
        }
      },
    );
  }
}
