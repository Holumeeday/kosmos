import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

/// An extension on some Flutter/Dart internals used in the app
/// author: Godwin Mathias
extension TextStyleX on TextStyle {
  TextStyle fromMap(Map<String, dynamic>? map) {
    if (map == null) return this;
    return TextStyle(
      fontSize: map['fontSize'],
      color: map['color'],
      fontWeight: map['fontWeight'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fontSize': fontSize,
      'color': color,
      'fontWeight': fontWeight,
    };
  }
}

/// Extension on enums
T? mapToEnum<T extends Enum>(List<T> values, String value) {
  return values.firstWhere((v) => v.name == value);
}

dynamic enumToMap<T>(List<T> values, T value) {
  return values.firstWhere((v) => v == value);
}

/// Extension on Alignment
extension AlignmentX on Alignment {
  /// This return the [Alignment] based on the string value from the backend
  static Alignment fromString(String value) {
    Alignment? alignment;
    final alignmentList = [
      'topLeft',
      'topCenter',
      'topRight',
      'center',
      'centerRight',
      'bottomRight',
      'bottomCenter',
    ];
    final alignmentGetterList = [
      Alignment.topLeft,
      Alignment.topCenter,
      Alignment.topRight,
      Alignment.center,
      Alignment.centerRight,
      Alignment.bottomRight,
      Alignment.bottomCenter,
    ];
    // A zip iterable returning pair of value par iteration
    for (final align in IterableZip([alignmentList, alignmentGetterList])) {
      // align[0] => alignments in string
      // align[1] => alignments as getters returning type [Alignment]
      if (align[0] == value) {
        alignment = align[1] as Alignment;
      }
    }
    return alignment!;
  }

  /// To string
  String toStr() {
    return toString().split('.')[1];
  }
}
