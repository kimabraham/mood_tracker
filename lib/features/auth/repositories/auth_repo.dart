import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get user => _firebaseAuth.currentUser;
  bool get isLoggedIn => user != null;

  Stream<User?> authStateChange() => _firebaseAuth.authStateChanges();

  Future<UserCredential> join(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> login(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}

final authRepoProvider = Provider(
  (ref) => AuthRepo(),
);

final authStateProvider = StreamProvider(
  (ref) {
    final authRepo = ref.read(authRepoProvider);
    return authRepo.authStateChange();
  },
);
