// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';

import '../manager/database_manager.dart';
import '../models/user.dart';

class UserRepository {
  UserRepository({required this.databaseManager});

  final DatabaseManager databaseManager;

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  static UserModel? currentUser;

  ///
  Future<bool> isSignIn() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      currentUser = await databaseManager.getUserInfoFromDbById(firebaseUser.uid);

      return true;
    }
    return false;
  }

  ///
  Future<bool> signIn() async {
    try {
      final googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        return false;
      }

      final googleSignInAuthentication = await googleSignInAccount.authentication;

      final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      final firebaseUser = (await _auth.signInWithCredential(credential)).user;

      if (firebaseUser == null) {
        return false;
      }

      final isUserExistedInDb = await databaseManager.searchUserInDb(firebaseUser);

      if (!isUserExistedInDb) {
        await databaseManager.insertUser(
          _convertToUser(
            firebaseUser,
          ),
        );
      }

      currentUser = await databaseManager.getUserInfoFromDbById(firebaseUser.uid);

      return true;
    } catch (e) {
      return false;
    }
  }

  ///
  UserModel _convertToUser(auth.User firebaseUser) {
    return UserModel(
      userId: firebaseUser.uid,
      displayName: firebaseUser.displayName ?? '',
      inAppUserName: firebaseUser.displayName ?? '',
      photoUrl: firebaseUser.photoURL ?? '',
      email: firebaseUser.email ?? '',
      bio: '',
    );
  }

  ///
  Future<UserModel> getUserById({required String userId}) async {
    return databaseManager.getUserInfoFromDbById(userId);
  }

  ///
  Future<void> signOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();

    currentUser = null;
  }

  ///
  Future<int> getNumberOfFollowers({required UserModel user}) async {
    return (await databaseManager.getFollowerUserIds(userId: user.userId)).length;
  }

  ///
  Future<int> getNumberOfFollowings({required UserModel user}) async {
    return (await databaseManager.getFollowingUserIds(userId: user.userId)).length;
  }

  ///
  Future<void> updateProfile({
    required UserModel profileUser,
    required String name,
    required String bio,
    required String photoUrl,
    required bool isImageFromFile,
  }) async {
    dynamic updatePhotoUrl;

    if (isImageFromFile) {
      final imageFile = File(photoUrl);
      final storageId = const Uuid().v1();
      updatePhotoUrl = await databaseManager.uploadImageToStorage(imageFile: imageFile, storageId: storageId);
    }

    final userBeforeUpdate = await databaseManager.getUserInfoFromDbById(profileUser.userId);

    final updateUser = userBeforeUpdate.copyWith(
      inAppUserName: name,
      photoUrl: isImageFromFile ? updatePhotoUrl : userBeforeUpdate.photoUrl,
      bio: bio,
    );

    await databaseManager.updateProfile(updateUser: updateUser);
  }

  ///
  Future<void> getCurrentUserById(String userId) async {
    currentUser = await databaseManager.getUserInfoFromDbById(userId);
  }

  ///
  Future<List<UserModel>> searchUsers({required String query}) async {
    return databaseManager.searchUsers(queryString: query);
  }

  ///
  Future<void> follow({required UserModel profileUser}) async {
    if (currentUser != null) {
      await databaseManager.follow(profileUser: profileUser, currentUser: currentUser!);
    }
  }

  ///
  Future<bool> checkIsFollowing({required UserModel profileUser}) async {
    if (currentUser != null) {
      return databaseManager.checkIsFollowing(profileUser: profileUser, currentUser: currentUser!);
    } else {
      return false;
    }
  }
}
