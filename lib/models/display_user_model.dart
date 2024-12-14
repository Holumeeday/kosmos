class DisplayUser {
  final String? username, displayImage;

  const DisplayUser({
    this.username,
    this.displayImage,
  });

  factory DisplayUser.fromJson(Map<String, dynamic> json) {
    return DisplayUser(
      username: json['username'] as String?,
      displayImage: json['displayImage'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'displayImage': displayImage,
    };
  }
}
