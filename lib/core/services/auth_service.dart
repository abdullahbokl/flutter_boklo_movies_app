import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final GoTrueClient _auth = Supabase.instance.client.auth;

  AuthService();

  Future<void> signUpWithEmail(
      {required String email, required String password}) async {
    try {
      await _auth.signUp(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> anonymousSignIn() async {
    try {
      await _auth.signInWithPassword(
        email: 'guest@gmail.com',
        password: '123456',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await _auth.signInWithOAuth(
        Provider.google,
        redirectTo: 'io.supabase.flutterquickstart://login-callback/',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print('signOut');
    } catch (e) {
      rethrow;
    }
  }
}
