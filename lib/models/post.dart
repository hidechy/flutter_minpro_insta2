class PostModel {
//<editor-fold desc="Data Methods">
  PostModel({
    required this.postId,
    required this.userId,
    required this.imageUrl,
    required this.imageStoragePath,
    required this.caption,
    required this.locationString,
    required this.latitude,
    required this.longitude,
    required this.postDateTime,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      postId: map['postId'] as String,
      userId: map['userId'] as String,
      imageUrl: map['imageUrl'] as String,
      imageStoragePath: map['imageStoragePath'] as String,
      caption: map['caption'] as String,
      locationString: map['locationString'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      postDateTime: (map['postDateTime'] == null)
          ? DateTime.now().toLocal()
          : DateTime.parse(map['postDateTime'] as String).toLocal(),
    );
  }

  String postId;
  String userId;
  String imageUrl;
  String imageStoragePath;
  String caption;
  String locationString;
  double latitude;
  double longitude;
  DateTime postDateTime;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostModel &&
          runtimeType == other.runtimeType &&
          postId == other.postId &&
          userId == other.userId &&
          imageUrl == other.imageUrl &&
          imageStoragePath == other.imageStoragePath &&
          caption == other.caption &&
          locationString == other.locationString &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          postDateTime == other.postDateTime);

  @override
  int get hashCode =>
      postId.hashCode ^
      userId.hashCode ^
      imageUrl.hashCode ^
      imageStoragePath.hashCode ^
      caption.hashCode ^
      locationString.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      postDateTime.hashCode;

  @override
  String toString() {
    return 'Post{ postId: $postId, userId: $userId, imageUrl: $imageUrl, imageStoragePath: $imageStoragePath, caption: $caption, locationString: $locationString, latitude: $latitude, longitude: $longitude, postDateTime: $postDateTime,}';
  }

  PostModel copyWith({
    String? postId,
    String? userId,
    String? imageUrl,
    String? imageStoragePath,
    String? caption,
    String? locationString,
    double? latitude,
    double? longitude,
    DateTime? postDateTime,
  }) {
    return PostModel(
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      imageStoragePath: imageStoragePath ?? this.imageStoragePath,
      caption: caption ?? this.caption,
      locationString: locationString ?? this.locationString,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      postDateTime: postDateTime ?? this.postDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'userId': userId,
      'imageUrl': imageUrl,
      'imageStoragePath': imageStoragePath,
      'caption': caption,
      'locationString': locationString,
      'latitude': latitude,
      'longitude': longitude,
      'postDateTime': postDateTime.toUtc().toIso8601String(),
    };
  }

//</editor-fold>
}
