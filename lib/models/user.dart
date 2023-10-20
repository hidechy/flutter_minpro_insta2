class UserModel {
//<editor-fold desc="Data Methods">
  const UserModel({
    required this.userId,
    required this.displayName,
    required this.inAppUserName,
    required this.photoUrl,
    required this.email,
    required this.bio,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      displayName: map['displayName'] as String,
      inAppUserName: map['inAppUserName'] as String,
      photoUrl: map['photoUrl'] as String,
      email: map['email'] as String,
      bio: map['bio'] as String,
    );
  }

  final String userId;
  final String displayName;
  final String inAppUserName;
  final String photoUrl;
  final String email;
  final String bio;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          displayName == other.displayName &&
          inAppUserName == other.inAppUserName &&
          photoUrl == other.photoUrl &&
          email == other.email &&
          bio == other.bio);

  @override
  int get hashCode =>
      userId.hashCode ^
      displayName.hashCode ^
      inAppUserName.hashCode ^
      photoUrl.hashCode ^
      email.hashCode ^
      bio.hashCode;

  @override
  String toString() {
    return 'User{ userId: $userId, displayName: $displayName, inAppUserName: $inAppUserName, photoUrl: $photoUrl, email: $email, bio: $bio,}';
  }

  UserModel copyWith({
    String? userId,
    String? displayName,
    String? inAppUserName,
    String? photoUrl,
    String? email,
    String? bio,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      inAppUserName: inAppUserName ?? this.inAppUserName,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'displayName': displayName,
      'inAppUserName': inAppUserName,
      'photoUrl': photoUrl,
      'email': email,
      'bio': bio,
    };
  }

//</editor-fold>
}
