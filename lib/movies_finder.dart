import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'core/config/app_route.dart';
import 'core/config/app_theme.dart';

class MovieFinder extends StatefulWidget {
  const MovieFinder({Key? key}) : super(key: key);

  @override
  State<MovieFinder> createState() => _MovieFinderState();
}

class _MovieFinderState extends State<MovieFinder> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          title: 'Movie Finder',
          debugShowCheckedModeBanner: false,
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          themeMode: ThemeMode.dark,
          routeInformationProvider: AppRoute.router.routeInformationProvider,
          routeInformationParser: AppRoute.router.routeInformationParser,
          routerDelegate: AppRoute.router.routerDelegate,
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown
            },
          ),
        );
      },
    );
  }
}
