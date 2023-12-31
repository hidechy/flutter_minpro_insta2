// ignore_for_file: cast_nullable_to_non_nullable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';

import '../models/comment.dart';
import '../models/like.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../repository/user_repository.dart';

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

    if (query.docs.isEmpty) {
      return [];
    }
    //============== 投稿があるのかチェック

    //============== 取得する投稿の記述者を特定
    final userIds = await getFollowingUserIds(userId: userId);
    userIds.add(userId);
    //============== 取得する投稿の記述者を特定

    final results = <PostModel>[];

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

    return results;
  }

  ///
  Future<List<String>> getFollowingUserIds({required String userId}) async {
    final query = await FirebaseFirestore.instance.collection('users').doc(userId).collection('followings').get();

    if (query.docs.isEmpty) {
      return [];
    }

    final userIds = <String>[];
    query.docs.forEach((element) {
      userIds.add(element.data()['userId']);
    });

    return userIds;
  }

  ///
  Future<void> updatePost({required PostModel updatePost}) async {
    await FirebaseFirestore.instance.collection('insta').doc(updatePost.postId).update(updatePost.toMap());
  }

  ///
  Future<void> postComment({required CommentModel commentModel}) async {
    await FirebaseFirestore.instance.collection('insta_comments').doc(commentModel.commentId).set(commentModel.toMap());
  }

  ///
  Future<List<CommentModel>> getComments({required String postId}) async {
    //============== コメントがあるのかチェック
    final query = await FirebaseFirestore.instance.collection('insta_comments').get();

    if (query.docs.isEmpty) {
      return [];
    }
    //============== コメントがあるのかチェック

    final results = <CommentModel>[];

    await FirebaseFirestore.instance
        .collection('insta_comments')
        .where('postId', isEqualTo: postId)
        .orderBy('commentDateTime', descending: true)
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) => results.add(CommentModel.fromMap(element.data())),
        );
      },
    );

    return results;
  }

  ///
  Future<void> deleteComment({required String commentId}) async {
    await FirebaseFirestore.instance.collection('insta_comments').doc(commentId).delete();
  }

  ///
  Future<void> likeIt({required LikeModel likeModel}) async {
    await FirebaseFirestore.instance.collection('insta_likes').doc(likeModel.likeId).set(likeModel.toMap());
  }

  ///
  Future<List<LikeModel>> getLikes({required String postId}) async {
    //============== ライクがあるのかチェック
    final query = await FirebaseFirestore.instance.collection('insta_likes').get();

    if (query.docs.isEmpty) {
      return [];
    }
    //============== ライクがあるのかチェック

    final results = <LikeModel>[];

    await FirebaseFirestore.instance
        .collection('insta_likes')
        .where('postId', isEqualTo: postId)
        .orderBy('likeDateTime', descending: true)
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) => results.add(LikeModel.fromMap(element.data())),
        );
      },
    );

    return results;
  }

  ///
  Future<void> unlikeIt({required String userId, required PostModel post}) async {
    await FirebaseFirestore.instance
        .collection('insta_likes')
        .where('postId', isEqualTo: post.postId)
        .where('likeUserId', isEqualTo: userId)
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        await FirebaseFirestore.instance.collection('insta_likes').doc(element.id).delete();
      });
    });
  }

  ///
  Future<void> deletePost({required String postId, required String imageStoragePath}) async {
    await FirebaseFirestore.instance.collection('insta').doc(postId).delete();

    await FirebaseFirestore.instance
        .collection('insta_comments')
        .where('postId', isEqualTo: postId)
        .get()
        .then((value) async {
      value.docs.forEach((element) async {
        await FirebaseFirestore.instance.collection('insta_comments').doc(element.id).delete();
      });
    });

    await FirebaseFirestore.instance
        .collection('insta_likes')
        .where('postId', isEqualTo: postId)
        .get()
        .then((value) async {
      value.docs.forEach((element) async {
        await FirebaseFirestore.instance.collection('insta_likes').doc(element.id).delete();
      });
    });

    await FirebaseStorage.instance.ref().child(imageStoragePath).delete();
  }

  ///
  Future<List<PostModel>> getPostByUser({required String userId}) async {
    //============== 投稿があるのかチェック
    final query = await FirebaseFirestore.instance.collection('insta').get();

    if (query.docs.isEmpty) {
      return [];
    }
    //============== 投稿があるのかチェック

    final results = <PostModel>[];

    await FirebaseFirestore.instance
        .collection('insta')
        .where('userId', isEqualTo: userId)
        .orderBy('postDateTime', descending: true)
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) => results.add(PostModel.fromMap(element.data())),
        );
      },
    );

    return results;
  }

  ///
  Future<List<String>> getFollowerUserIds({required String userId}) async {
    final query = await FirebaseFirestore.instance.collection('users').doc(userId).collection('followers').get();

    if (query.docs.isEmpty) {
      return [];
    }

    final userIds = <String>[];
    query.docs.forEach((element) {
      userIds.add(element.data()['userId']);
    });

    return userIds;
  }

  ///
  Future<void> updateProfile({required UserModel updateUser}) async {
    await FirebaseFirestore.instance.collection('users').doc(updateUser.userId).update(updateUser.toMap());
  }

  ///
  Future<List<UserModel>> searchUsers({required String queryString}) async {
    //============== ユーザーがあるのかチェック
    final query = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('inAppUserName')
        .endAt(['$queryString\uf8ff']).startAt([queryString]).get();

    if (query.docs.isEmpty) {
      return [];
    }
    //============== ユーザーがあるのかチェック

    final soughtUsers = <UserModel>[];

    query.docs.forEach((element) {
      final selectedUser = UserModel.fromMap(element.data());
      if (selectedUser.userId != UserRepository.currentUser?.userId) {
        soughtUsers.add(selectedUser);
      }
    });

    return soughtUsers;
  }

  ///
  Future<void> follow({required UserModel profileUser, required UserModel currentUser}) async {
    //CurrentUserにとってのfollowings
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.userId)
        .collection('followings')
        .doc(profileUser.userId)
        .set({'userId': profileUser.userId});

    //profileUserにとってのfollowers
    await FirebaseFirestore.instance
        .collection('users')
        .doc(profileUser.userId)
        .collection('followers')
        .doc(currentUser.userId)
        .set({'userId': currentUser.userId});
  }

  ///
  Future<bool> checkIsFollowing({required UserModel profileUser, required UserModel currentUser}) async {
    final query =
        await FirebaseFirestore.instance.collection('users').doc(currentUser.userId).collection('followings').get();

    if (query.docs.isEmpty) {
      return false;
    }

    final checkQuery = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.userId)
        .collection('followings')
        .where('userId', isEqualTo: profileUser.userId)
        .get();

    if (checkQuery.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  ///
  Future<void> unFollow({required UserModel profileUser, required UserModel currentUser}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.userId)
        .collection('followings')
        .doc(profileUser.userId)
        .delete();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(profileUser.userId)
        .collection('followers')
        .doc(currentUser.userId)
        .delete();
  }

  ///
  Future<List<UserModel>> getLikesUsers({required String postId}) async {
    //============== その投稿のライクがあるのかチェック
    final query = await FirebaseFirestore.instance.collection('insta_likes').where('postId', isEqualTo: postId).get();

    if (query.docs.isEmpty) {
      return [];
    }
    //============== その投稿のライクがあるのかチェック

    //============== その投稿にライクをくれたユーザーのID
    final userIds = <String>[];

    query.docs.forEach((element) => userIds.add(element.data()['likeUserId']));
    //============== その投稿にライクをくれたユーザーのID

    final results = <UserModel>[];

    await Future.forEach(userIds, (element) async => results.add(await getUserInfoFromDbById(element)));

    return results;
  }

  ///
  Future<List<UserModel>> getFollowToMeUsers({required String myUserId}) async {
    final followerUserIds = await getFollowerUserIds(userId: myUserId);

    final results = <UserModel>[];

    await Future.forEach(followerUserIds, (element) async => results.add(await getUserInfoFromDbById(element)));

    return results;
  }

  ///
  Future<List<UserModel>> getFollowFromMeUsers({required String myUserId}) async {
    final followingUserIds = await getFollowingUserIds(userId: myUserId);

    final results = <UserModel>[];

    await Future.forEach(followingUserIds, (element) async => results.add(await getUserInfoFromDbById(element)));

    return results;
  }
}
