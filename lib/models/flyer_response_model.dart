import 'package:flutter/cupertino.dart';

/*
This class defines the flyer response from the api
@author: Ugochukwu Umeh
*/
class FlyersResponse {
  FlyersResponse({
    required this.flyer,
    required this.message,
  });

  final List<FlyerData> flyer;
  final String message;

  factory FlyersResponse.fromJson(Map<String, dynamic> json) =>
      FlyersResponse(
        flyer: List<FlyerData>.from(json["fliers"].map((x) => FlyerData.fromJson(x))),
        message: json["message"],
      );
}

class FlyerData {
  FlyerData({
    required this.name,
    required this.interest,
    required this.positions,
    required this.flierUrl,
  });

  final String name;
  final String interest;
  final List<Position> positions;
  final String flierUrl;

  factory FlyerData.fromJson(Map<String, dynamic> json) =>
      FlyerData(
        name: json["name"],
        interest: json["interest"],
        positions: List<Position>.from(
            json["positions"].map((x) => Position.fromJson(x))),
        flierUrl: json["flierURL"],
      );
}

class Position {
  Position({
    required this.parameterType,
    required this.top,
    required this.right,
    required this.left,
    required this.lines,
    required this.rowAlign,
    this.textAlign,
    required this.fontFamily,
    required this.fontColour,
    required this.angle,
    required this.fontSize,
    required this.fontWeight,
    required this.fontStyle,
  });

  final String parameterType;
  final double top;
  final double right;
  final double left;
  final int lines;
  final MainAxisAlignment rowAlign;
  final TextAlign? textAlign;
  final String fontFamily;
  final Color fontColour;
  final int fontSize;
  final double angle;
  final FontWeight fontWeight;
  final FontStyle fontStyle;

  factory Position.fromJson(Map<String, dynamic> json) =>
      Position(
        parameterType: json["parameterType"],
        top: json["top"] ,
        right: json["right"],
        left: json["left"],
        lines: json["lines"],
        rowAlign: getMainAxisAlignment(json["rowAlign"] as String?),
        textAlign: getTextAlignment(json["textAlign"] as String?),
        fontFamily: json["fontFamily"] as String,
        fontColour: getColor(json["fontColour"]),
        fontSize: json["fontSize"],
        angle: json["angle"],
        fontWeight: getFontWeight(json["fontWeight"] as String?),
        fontStyle: getFontStyle(json["fontStyle"] as String?),
      );
}

///To convert the row alignment
MainAxisAlignment getMainAxisAlignment(String? alignment) {
  switch (alignment?.toLowerCase()) {
    case 'center':
      return MainAxisAlignment.center;
    case 'end':
      return MainAxisAlignment.end;
    default:
      return MainAxisAlignment.start;
  }
}

///To convert to text alignment
TextAlign getTextAlignment(String? alignment){
  switch (alignment?.toLowerCase()) {
    case 'center':
      return TextAlign.center;
    case 'end':
      return TextAlign.end;
    default:
      return TextAlign.start;
  }
}

///To convert to font weight
FontWeight getFontWeight(String? fontWeight){
  switch (fontWeight) {
    case 'w500':
      return FontWeight.w500;
    case 'w600':
      return FontWeight.w600;
    case 'w700':
      return FontWeight.w700;
    case 'w800':
      return FontWeight.w800;
    case 'w900':
      return FontWeight.w900;
    default:
      return FontWeight.w400;
  }
}

///To convert to font style
FontStyle getFontStyle(String? fontStyle){
  switch (fontStyle?.toLowerCase()) {
    case 'italic':
      return FontStyle.italic;
    default:
      return FontStyle.normal;
  }
}

///Get the color of the position text
Color getColor(String color) {
  return Color(int.tryParse(color) ?? 0xFFFFFFFF);
}