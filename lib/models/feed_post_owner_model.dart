import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/enums/enums.dart';

class FeedPostOwnerModel extends Equatable {
  final String? id, username, subscriptionPlan, displayImage, postText;
  final ParticipantTypeEnum? participantType;
  final List<String> taggedUsers;
  final DateTime? postedAt;

  const FeedPostOwnerModel({
    this.id,
    this.participantType,
    this.username,
    this.subscriptionPlan,
    this.displayImage,
    this.taggedUsers = const [],
    this.postedAt,
    this.postText,
  });

  factory FeedPostOwnerModel.fromJson(Map<String, dynamic> json) {
    return FeedPostOwnerModel(
      id: json['id'] as String?,
      participantType:
          ParticipantTypeEnum.fromString(json['participantType'] as String?),
      username: json['username'] as String?,
      subscriptionPlan: json['subscriptionPlan'] as String?,
      displayImage: json['displayImage'] as String?,
      taggedUsers: json['taggedUsers'] == null
          ? []
          : List<String>.from(json['taggedUsers'].map((e) => e)),
      postedAt: json['postedAt'] == null
          ? null
          : DateTime.tryParse(json['postedAt'])?.toLocal(),
      postText: json['postText'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        participantType,
        username,
        subscriptionPlan,
        displayImage,
        taggedUsers,
        postedAt,
        postText,
      ];
}
