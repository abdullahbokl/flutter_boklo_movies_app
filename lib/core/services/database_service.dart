// import 'package:supabase_flutter/supabase_flutter.dart';
//
// import '../../src/data/models/favorite_movie_model.dart';
//
// class DataBaseService {
//   SupabaseClient client = Supabase.instance.client;
//
//   Future<void> addMovie({required FavoriteMovieModel movie}) async {
//     try {
//       final map = movie.toMap();
//       await client.from('favorite_movies').insert(map);
//     } on PostgrestException catch (e) {
//       if (e.message.contains('unique constraint')) {
//         throw 'Movie is already saved!';
//       } else {
//         throw 'Something went wrong !';
//       }
//     }
//   }
//
//   Stream movieStream() {
//     String userId = client.auth.currentUser!.id;
//     try {
//       return client
//           .from('favorite_movies')
//           .stream(primaryKey: ['id'])
//           .eq('user_id', userId)
//           .map((json) =>
//               json.map((e) => FavoriteMovieModel.fromMap(e)).toList());
//     } on PostgrestException catch (e) {
//       throw e.message;
//     }
//   }
//
//   Future<void> deleteMovie(int movieID) async {
//     await client.from('favorite_movies').delete().match({'movie_id': movieID});
//   }
//
//   Future<void> deleteAllMovies() async {
//     await client.from('favorite_movies').delete().neq('user_id', 0);
//   }
// }
