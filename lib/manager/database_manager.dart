// ignore_for_file: cast_nullable_to_non_nullable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../models/post.dart';
import '../models/user.dart';

class DatabaseManager {
  ///
  Future<bool> searchUserInDb(auth.User firebaseUser) async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').where('userId', isEqualTo: firebaseUser.uid).get();

    if (snapshot.docs.isNotEmpty) {
      return true;
    }

    return false;
  }

  ///
  Future<void> insertUser(UserModel userModel) async {
    await FirebaseFirestore.instance.collection('users').doc(userModel.userId).set(userModel.toMap());
  }

  ///
  Future<UserModel> getUserInfoFromDbById(String userId) async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').where('userId', isEqualTo: userId).get();

    return UserModel.fromMap(snapshot.docs[0].data() as Map<String, dynamic>);
  }

  ///
  Future<String> uploadImageToStorage({required File imageFile, required String storageId}) async {
    final storageRef = FirebaseStorage.instance.ref().child(storageId);

    final uploadTask = storageRef.putFile(imageFile);

    return uploadTask.then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());
  }

  ///
  Future<void> insertPost(PostModel postModel) async {
    await FirebaseFirestore.instance.collection('insta').doc(postModel.postId).set(postModel.toMap());
  }

  ///
  Future<List<PostModel>> getPostMineAndFollowings({required String userId}) async {
    //============== 投稿があるのかチェック
    final query = await FirebaseFirestore.instance.collection('insta').get();

    if (query.docs.length == 0) {
      return [];
    }
    //============== 投稿があるのかチェック

    //============== 取得する投稿の記述者を特定
    var userIds = await getFollowingUserIds(userId: userId);
    userIds.add(userId);
    //============== 取得する投稿の記述者を特定

    var results = <PostModel>[];

    await FirebaseFirestore.instance
        .collection('insta')
        .where('userId', whereIn: userIds)
        .orderBy('postDateTime', descending: true)
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) => results.add(PostModel.fromMap(element.data())),
        );
      },
    );

    debugPrint('posts: ${results}');

    return results;
  }

  ///
  Future<List<PostModel>> getPostByUser({required String userId}) {
    return Future.value([]);
  }

  ///
  Future<List<String>> getFollowingUserIds({required String userId}) async {
    final query = await FirebaseFirestore.instance.collection('users').doc(userId).collection('followings').get();

    if (query.docs.length == 0) {
      return [];
    }

    var userIds = <String>[];
    query.docs.forEach((element) {
      userIds.add(element.data()['userId']);
    });

    return userIds;
  }
}
