import 'dart:convert';

import 'package:playkosmos_v3/models/positioned_model.dart';

/*
This class defines the positioning of activity properties
@author: Ugochukwu Umeh
@date: 30 Dec, 2022
@modified: 31 Jan, 2023
*/
class TextPositionModel {
  ///The title of the activity
  final PositionedModel activityTitle;

  ///The details of the activity
  final PositionedModel activityDetails;

  ///The activity type
  final PositionedModel activityType;

  ///The activity interest
  final PositionedModel activityInterest;

  ///The duration of the activity
  final PositionedModel activityDuration;

  ///The activity start date
  final PositionedModel activityDate;

  ///The activity start time
  final PositionedModel activityTime;

  ///The city the activity will be held in
  final PositionedModel activityCity;

  ///The country the activity will be held in
  final PositionedModel activityCountry;

  ///The venue the activity will be held in
  final PositionedModel activityVenue;

  /// The activity fee
  final PositionedModel activityFee;

  ///The activity image
  final PositionedImage? activityImage;

  ///This class defines the positioning of activity properties
  const TextPositionModel({
    required this.activityTitle,
    required this.activityDetails,
    required this.activityType,
    required this.activityInterest,
    required this.activityDuration,
    required this.activityDate,
    required this.activityTime,
    required this.activityCity,
    required this.activityCountry,
    required this.activityVenue,
    required this.activityFee,
    this.activityImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'activityTitle': activityTitle.toMap(),
      'activityDetails': activityDetails.toMap(),
      'activityType': activityType.toMap(),
      'activityInterest': activityInterest.toMap(),
      'activityDuration': activityDuration.toMap(),
      'activityDate': activityDate.toMap(),
      'activityTime': activityTime.toMap(),
      'activityCity': activityCity.toMap(),
      'activityCountry': activityCountry.toMap(),
      'activityVenue': activityVenue.toMap(),
      // 'activityPrice': activityPrice,
      'activityFee': activityFee.toMap(),
      'activityImage': activityImage?.toMap(),
    };
  }

  factory TextPositionModel.fromMap(Map<String, dynamic> map) {
    return TextPositionModel(
      activityTitle:
          PositionedModel.fromMap(map['activityTitle'] as Map<String, dynamic>),
      activityDetails: PositionedModel.fromMap(
          map['activityDetails'] as Map<String, dynamic>),
      activityType:
          PositionedModel.fromMap(map['activityType'] as Map<String, dynamic>),
      activityInterest: PositionedModel.fromMap(
          map['activityInterest'] as Map<String, dynamic>),
      activityDuration: PositionedModel.fromMap(
          map['activityDuration'] as Map<String, dynamic>),
      activityDate:
          PositionedModel.fromMap(map['activityDate'] as Map<String, dynamic>),
      activityTime:
          PositionedModel.fromMap(map['activityTime'] as Map<String, dynamic>),
      activityCity:
          PositionedModel.fromMap(map['activityCity'] as Map<String, dynamic>),
      activityCountry: PositionedModel.fromMap(
          map['activityCountry'] as Map<String, dynamic>),
      activityVenue:
          PositionedModel.fromMap(map['activityVenue'] as Map<String, dynamic>),
      // activityPrice:
      //     PositionedModel.fromMap(map['activityPrice'] as Map<String, dynamic>),
      activityFee:
          PositionedModel.fromMap(map['activityFee'] as Map<String, dynamic>),
      activityImage: map['activityImage'] != null
          ? PositionedImage.fromMap(
              map['activityImage'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TextPositionModel.fromJson(String source) =>
      TextPositionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
