import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
This class defines the positioning of an activity property except that of
image
@author: Ugochukwu Umeh
@date: 30 Dec, 2022
@modified: 24 Jan, 2023
*/
class PositionedModel {
  ///The distance from the top part of the flier to that of the property
  final double top;

  ///The distance from the left part of the flier to that of the property
  final double left;

  ///The distance from the right part of the flier to that of the property
  final double right;

  ///Text style of the property
  final TextStyle style;

  ///Number of lines
  final int? lines;

  ///Angle of rotation. 0 if rotation is false
  final double? angle;

  ///Property text alignment
  final TextAlign? textAlignment;

  ///Property row alignment
  final MainAxisAlignment rowAlignment;

  const PositionedModel({
    required this.top,
    required this.right,
    required this.left,
    required this.style,
    this.lines,
    this.angle,
    this.textAlignment,
    this.rowAlignment = MainAxisAlignment.start,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'top': top,
      'left': left,
      'right': right,
      'style': style.toMap(),
      'lines': lines,
      'angle': angle,
      'textAlignment': enumToMap(TextAlign.values, textAlignment!),
      'rowAlignment': enumToMap(MainAxisAlignment.values, rowAlignment),
    };
  }

  factory PositionedModel.fromMap(Map<String, dynamic> map) {
    return PositionedModel(
      top: map['top'] as double,
      left: map['left'] as double,
      right: map['right'] as double,
      style: const TextStyle().fromMap(map['style'] as Map<String, dynamic>),
      lines: map['lines'] != null ? map['lines'] as int : null,
      angle: map['angle'] != null ? map['angle'] as double : null,
      textAlignment: map['textAlignment'] != null
          ? mapToEnum(TextAlign.values, map['textAlignment'] as String)
          : null,
      rowAlignment: mapToEnum(
        MainAxisAlignment.values,
        map['rowAlignment'] as String,
      )!,
    );
  }

  String toJson() => json.encode(toMap());

  factory PositionedModel.fromJson(String source) =>
      PositionedModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

/*
This class defines the positioning of an activity image property
@author: Ugochukwu Umeh
@date: 31 Jan, 2023
@modified:
*/
class PositionedImage {
  ///The distance from the top part of the flier to that of the property
  final double top;

  ///The distance from the left part of the flier to that of the property
  final double left;

  ///The distance from the right part of the flier to that of the property
  final double right;

  ///Height
  final double height;

  ///Angle of rotation. 0 if rotation is false
  final double? angle;

  ///The shape of the image
  final BoxShape boxShape;

  ///The color of the icon
  final Color iconColor;

  ///Image to use as placeholder
  final String placeHolderImage;

  ///The alignment of the icon
  final AlignmentGeometry iconAlignment;

  const PositionedImage({
    required this.top,
    required this.right,
    required this.left,
    required this.height,
    required this.iconColor,
    required this.placeHolderImage,
    this.angle,
    this.boxShape = BoxShape.rectangle,
    this.iconAlignment = Alignment.center,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'top': top,
      'left': left,
      'right': right,
      'height': height,
      'angle': angle,
      'boxShape': enumToMap(BoxShape.values, boxShape),
      'iconColor': iconColor.value,
      'placeHolderImage': placeHolderImage,
      'iconAlignment': iconAlignment.toString(),
    };
  }

  factory PositionedImage.fromMap(Map<String, dynamic> map) {
    return PositionedImage(
      top: map['top'] as double,
      left: map['left'] as double,
      right: map['right'] as double,
      height: map['height'] as double,
      angle: map['angle'] != null ? map['angle'] as double : null,
      boxShape: mapToEnum(BoxShape.values, map['boxShape'] as String)!,
      iconColor: Color(map['iconColor'] as int),
      placeHolderImage: map['placeHolderImage'] as String,
      iconAlignment: AlignmentX.fromString(map['iconAlignment'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory PositionedImage.fromJson(String source) =>
      PositionedImage.fromMap(json.decode(source) as Map<String, dynamic>);
}
