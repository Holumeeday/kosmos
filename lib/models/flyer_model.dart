import 'package:flutter/widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

class FlyerModel {
  final String? name, interest, flyerUrl;
  final List<ParameterPosition> positions;
  final ParameterImagePosition? imagePosition;

  const FlyerModel({
    this.name,
    this.interest,
    this.positions = const [],
    this.flyerUrl,
    this.imagePosition,
  });

  factory FlyerModel.fromJson(Map<String, dynamic> json) => FlyerModel(
        name: json["name"] as String?,
        interest: json["interest"] as String?,
        positions: (json['positions'] as List?)
                ?.map<ParameterPosition>(
                  (x) => ParameterPosition.fromJson(x as Map<String, dynamic>),
                )
                .toList() ??
            [],
        imagePosition: json['imagePosition'] == null
            ? null
            : ParameterImagePosition.fromJson(json['imagePosition']),
        flyerUrl: json["flierUrl"] as String?,
      );
}

/// The positions for the flyer details i.e title, details, date etc
class ParameterPosition {
  final String? parameterType, fontFamily;
  final double top, right, left, angle, fontSize;
  final int lines;
  final MainAxisAlignment rowAlign;
  final TextAlign textAlign;
  final Color fontColour;
  final FontWeight fontWeight;
  final FontStyle fontStyle;

  const ParameterPosition({
    this.rowAlign = MainAxisAlignment.start,
    this.textAlign = TextAlign.start,
    this.fontColour = const Color(0xFFFFFFFF),
    this.fontWeight = FontWeight.w400,
    this.fontStyle = FontStyle.normal,
    this.parameterType,
    this.top = 0,
    this.right = 0,
    this.left = 0,
    this.lines = 1,
    this.fontFamily,
    this.angle = 0,
    this.fontSize = 12,
  });

  factory ParameterPosition.fromJson(Map<String, dynamic> json) =>
      ParameterPosition(
        parameterType: json["parameterType"] as String?,
        top: json["top"].toDouble() ?? 0,
        right: json["right"].toDouble() ?? 0,
        left: json["left"].toDouble() ?? 0,
        lines: json["lines"] as int? ?? 1,
        rowAlign: getMainAxisAlignment(json["rowAlign"] as String?),
        textAlign: getTextAlignment(json["textAlign"] as String?),
        fontFamily: json["fontFamily"] as String?,
        fontColour: getColor(json["fontColour"] as String?),
        fontSize: json["fontSize"].toDouble() ?? 12,
        angle: json["angle"].toDouble() ?? 0,
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

/// To convert to text alignment
TextAlign getTextAlignment(String? alignment) {
  switch (alignment?.toLowerCase()) {
    case 'center':
      return TextAlign.center;
    case 'end':
      return TextAlign.end;
    default:
      return TextAlign.start;
  }
}

/// To convert to font weight
FontWeight getFontWeight(String? fontWeight) {
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

/// To convert to font style
FontStyle getFontStyle(String? fontStyle) {
  switch (fontStyle?.toLowerCase()) {
    case 'italic':
      return FontStyle.italic;
    default:
      return FontStyle.normal;
  }
}

/// Get the color of the position text
Color getColor(String? color) {
  if (color == null) return const Color(0xFFFFFFFF);
  return Color(int.tryParse(color) ?? 0xFFFFFFFF);
}

/// The position for the flyer image if any
class ParameterImagePosition {
  final double top, left, right, height, angle;
  final BoxShape boxShape;
  final String? placeholderImage, image;

  const ParameterImagePosition({
    this.top = 0,
    this.right = 0,
    this.left = 0,
    this.height = 0,
    this.placeholderImage,
    this.angle = 0,
    this.boxShape = BoxShape.rectangle,
    this.image,
  });

  factory ParameterImagePosition.fromJson(Map<String, dynamic> json) {
    return ParameterImagePosition(
      top: json['top'].toDouble() ?? 0,
      left: json['left'].toDouble() ?? 0,
      right: json['right'].toDouble() ?? 0,
      height: json['height'].toDouble() ?? 0,
      angle: json['angle'].toDouble() ?? 0,
      boxShape:
          mapToEnum(BoxShape.values, json['boxShape']) ?? BoxShape.rectangle,
      placeholderImage: json['placeHolderImage'] as String?,
      image: json['image'] as String?,
    );
  }
}
