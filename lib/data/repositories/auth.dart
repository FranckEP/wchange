import 'package:firebase_auth/firebase_auth.dart';
import 'package:wchange/domain/models/userModel.dart';

abstract class AuthInterface {
  Future<bool> signUp(
      {required userModel});

  Future<UserModel?> signIn(
      {required String email, required String password});

  Future<bool> signOut();

  static Stream<User?> get authStream =>
      FirebaseAuth.instance.authStateChanges();
}