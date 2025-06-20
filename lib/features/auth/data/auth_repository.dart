import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository(this._auth);

  Future<User?> signIn(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return result.user;
  }

  Future<User?> register(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return result.user;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
