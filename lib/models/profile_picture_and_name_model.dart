class ProfilePictureAndNameModel {
  final String username;
  final String? displayImage;

  const ProfilePictureAndNameModel({
    required this.username,
    required this.displayImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'displayImage': displayImage,
    };
  }

  @override
  String toString() {
    return 'ProfilePictureAndNameModel{\n'
        '   username: $username,\n'
        '   displayImage: $displayImage\n'
        ' }';
  }

  factory ProfilePictureAndNameModel.fromMap(Map<String, dynamic> map) {
    return ProfilePictureAndNameModel(
      username: map['username'] as String,
      displayImage:
          map['displayImage'] != null ? map['displayImage'] as String : null,
    );
  }
}
