import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/shared/widgets/screen_layout.dart';
import 'search_screen_body.dart';
import 'widgets/search_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const CustomSearchBar(),
        SizedBox(height: 2.h),
        const SearchScreenBody(),
      ],
    ));
  }
}
