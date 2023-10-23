class LikeResult {
  LikeResult({required this.likes, required this.isLikeToThisPost});

  final List<LikeModel> likes;
  final bool isLikeToThisPost;
}

class LikeModel {
//<editor-fold desc="Data Methods">
  LikeModel({
    required this.likeId,
    required this.postId,
    required this.likeUserId,
    required this.likeDateTime,
  });

  factory LikeModel.fromMap(Map<String, dynamic> map) {
    return LikeModel(
      likeId: map['likeId'] as String,
      postId: map['postId'] as String,
      likeUserId: map['likeUserId'] as String,
      likeDateTime: (map['likeDateTime'] == null)
          ? DateTime.now().toLocal()
          : DateTime.parse(map['likeDateTime'] as String).toLocal(),
    );
  }

  String likeId;
  String postId;
  String likeUserId;
  DateTime likeDateTime;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LikeModel &&
          runtimeType == other.runtimeType &&
          likeId == other.likeId &&
          postId == other.postId &&
          likeUserId == other.likeUserId &&
          likeDateTime == other.likeDateTime);

  @override
  int get hashCode => likeId.hashCode ^ postId.hashCode ^ likeUserId.hashCode ^ likeDateTime.hashCode;

  @override
  String toString() {
    return 'Like{ likeId: $likeId, postId: $postId, likeUserId: $likeUserId, likeDateTime: $likeDateTime,}';
  }

  LikeModel copyWith({
    String? likeId,
    String? postId,
    String? likeUserId,
    DateTime? likeDateTime,
  }) {
    return LikeModel(
      likeId: likeId ?? this.likeId,
      postId: postId ?? this.postId,
      likeUserId: likeUserId ?? this.likeUserId,
      likeDateTime: likeDateTime ?? this.likeDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'likeId': likeId,
      'postId': postId,
      'likeUserId': likeUserId,
      'likeDateTime': likeDateTime.toUtc().toIso8601String(),
    };
  }

//</editor-fold>
}
