import 'dart:convert';

import 'package:playkosmos_v3/models/text_position_model.dart';

/*
This class defines the flier, its height and width and position of
activity properties
@author: Ugochukwu Umeh
@date: 30 Dec, 2022
@modified: 10 Mar, 2023
Used by view/post activity, widgets/flier
*/
///This class defines the flier and position of activity properties
class FlyerPositioning {
  ///The flier location
  final String image;

  ///The flier name
  final String interestName;

  ///Flier height
  final double imageHeight;

  ///Flier width
  final double imageWidth;

  ///Position of activity properties
  final TextPositionModel positionText;

  FlyerPositioning({
    required this.image,
    required this.positionText,
    required this.interestName,
    this.imageHeight = 335,
    this.imageWidth = 335,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'interestName': interestName,
      'imageHeight': imageHeight,
      'imageWidth': imageWidth,
      'positionText': positionText.toMap(),
    };
  }

  factory FlyerPositioning.fromMap(Map<String, dynamic> map) {
    return FlyerPositioning(
      image: map['image'] as String,
      interestName: map['interestName'] as String,
      imageHeight: map['imageHeight'] as double,
      imageWidth: map['imageWidth'] as double,
      positionText: TextPositionModel.fromMap(
          map['positionText'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory FlyerPositioning.fromJson(String source) =>
      FlyerPositioning.fromMap(json.decode(source) as Map<String, dynamic>);
}

/*
This class defines the flyer, its height and width and position of
activity properties
@author: Ugochukwu Umeh
@date: 09 Mar, 2023
@modified: 10 Mar, 2023
*/
class FlyerPropertiesWithSmall {
  ///The flier location
  final String image;

  ///The small image
  final String smallImage;

  ///The flier name
  final String interestName;

  ///Flier height
  final double imageHeight;

  ///Flier width
  final double imageWidth;

  ///Position of activity properties
  final TextPositionModel positionText;

  FlyerPropertiesWithSmall({
    required this.image,
    required this.smallImage,
    required this.positionText,
    required this.interestName,
    this.imageHeight = 335,
    this.imageWidth = 335,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'smallImage': smallImage,
      'interestName': interestName,
      'imageHeight': imageHeight,
      'imageWidth': imageWidth,
      'positionText': positionText.toMap(),
    };
  }

  factory FlyerPropertiesWithSmall.fromMap(Map<String, dynamic> map) {
    return FlyerPropertiesWithSmall(
      image: map['image'] as String,
      smallImage: map['smallImage'] as String,
      interestName: map['interestName'] as String,
      imageHeight: map['imageHeight'] as double,
      imageWidth: map['imageWidth'] as double,
      positionText: TextPositionModel.fromMap(
          map['positionText'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory FlyerPropertiesWithSmall.fromJson(String source) =>
      FlyerPropertiesWithSmall.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
