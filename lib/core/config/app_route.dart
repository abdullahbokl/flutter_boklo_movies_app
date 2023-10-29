import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../src/data/models/video_model.dart';
import '../../src/presentation/screens/auth_screen/auth_screen.dart';
import '../../src/presentation/screens/auth_screen/login_screen.dart';
import '../../src/presentation/screens/details_screen/details_screen.dart';
import '../../src/presentation/screens/home_screen.dart';
import '../../src/presentation/screens/trailers_screen/trailer_screen.dart';
import '../../src/presentation/widgets/custom_text.dart';
import '../shared/widgets/screen_layout.dart';

class AppRoute {
  static const root = '/';
  static const authScreen = '/welcomeScreen';
  static const loginScreen = '/loginScreen';
  static const homeScreen = '/homeScreen';
  static const details = '/details';
  static const trailer = '/trailer';

  static final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: root,
        builder: (context, state) {
          if (Supabase.instance.client.auth.currentUser != null) {
            return const BaseScreen();
          } else {
            return const AuthScreen();
          }
        },
      ),
      GoRoute(
        path: authScreen,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: homeScreen,
        builder: (context, state) => const BaseScreen(),
      ),
      GoRoute(
        path: details,
        builder: (context, state) {
          final id = state.extra as int;
          return DetailsScreen(id: id);
        },
      ),
      GoRoute(
        path: trailer,
        builder: (context, state) {
          final data = state.extra as List<VideoModel>;
          return TrailerScreen(
            videos: data,
          );
        },
      ),
    ],
    initialLocation: root,
    errorBuilder: (context, state) => const ScreenLayout(
        child: Center(
      child: CustomText(title: "This page doesn't exist!"),
    )),
  );

  static GoRouter get router => _router;
}
