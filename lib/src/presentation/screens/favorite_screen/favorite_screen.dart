import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/favourite/favourite_bloc.dart';
import '../../widgets/custom_error_widget.dart';
import '../../widgets/custom_indicator.dart';
import 'favourite_screen_body.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
        builder: (context, state) {
      if (state is FavouriteLoading) {
        return const CustomIndicator();
      } else if (state is FavouriteError) {
        return CustomErrorWidget(
          error: state.message,
          func: () {},
        );
      } else {
        return const FavouriteScreenBody();
      }
    });
  }
}
