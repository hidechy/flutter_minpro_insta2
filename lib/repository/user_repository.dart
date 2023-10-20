import 'package:firebase_auth/firebase_auth.dart';

import '../manager/database_manager.dart';

class UserRepository {
  UserRepository({required this.dbManager});

  final DatabaseManager dbManager;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///
  Future<bool> isSignIn() async {
    final firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      return true;
    }

    return false;
  }
}
