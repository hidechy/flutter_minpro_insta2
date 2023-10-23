class CommentModel {
//<editor-fold desc="Data Methods">
  CommentModel({
    required this.commentId,
    required this.postId,
    required this.commentUserId,
    required this.comment,
    required this.commentDateTime,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      commentId: map['commentId'] as String,
      postId: map['postId'] as String,
      commentUserId: map['commentUserId'] as String,
      comment: map['comment'] as String,
      commentDateTime: (map['commentDateTime'] == null)
          ? DateTime.now().toLocal()
          : DateTime.parse(map['commentDateTime'] as String).toLocal(),
    );
  }

  String commentId;
  String postId;
  String commentUserId;
  String comment;
  DateTime commentDateTime;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommentModel &&
          runtimeType == other.runtimeType &&
          commentId == other.commentId &&
          postId == other.postId &&
          commentUserId == other.commentUserId &&
          comment == other.comment &&
          commentDateTime == other.commentDateTime);

  @override
  int get hashCode =>
      commentId.hashCode ^ postId.hashCode ^ commentUserId.hashCode ^ comment.hashCode ^ commentDateTime.hashCode;

  @override
  String toString() {
    return 'CommentModel{ commentId: $commentId, postId: $postId, commentUserId: $commentUserId, comment: $comment, commentDateTime: $commentDateTime,}';
  }

  CommentModel copyWith({
    String? commentId,
    String? postId,
    String? commentUserId,
    String? comment,
    DateTime? commentDateTime,
  }) {
    return CommentModel(
      commentId: commentId ?? this.commentId,
      postId: postId ?? this.postId,
      commentUserId: commentUserId ?? this.commentUserId,
      comment: comment ?? this.comment,
      commentDateTime: commentDateTime ?? this.commentDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'commentId': commentId,
      'postId': postId,
      'commentUserId': commentUserId,
      'comment': comment,
      'commentDateTime': commentDateTime.toUtc().toIso8601String(),
    };
  }

//</editor-fold>
}
