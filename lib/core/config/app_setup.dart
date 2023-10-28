import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/service_locator.dart';
import 'bloc_observer.dart';

class AppSetup {
  AppSetup._();

  static initApp() async {
    // load env
    await dotenv.load(fileName: '.env');

    await _initSupabase();

    // Initialize GetIt
    await setupServiceLocator();

    // This will help you observe your Bloc
    Bloc.observer = MyBlocObserver();
  }

  static _initSupabase() async {
    String supabaseBaseUrl = dotenv.env['SUPABASE_BASE_URL'] ?? '';
    String supabaseBaseKey = dotenv.env['SUPABASE_BASE_KEY'] ?? '';

    await Supabase.initialize(
      url: supabaseBaseUrl,
      anonKey: supabaseBaseKey,
      authCallbackUrlHostname:
          'io.supabase.flutterquickstart://login-callback/',
    );
  }
}
