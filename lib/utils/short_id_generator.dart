import 'dart:math';

/// A non-universally unique ID generator.
///
/// This class provides functionality to generate short, random IDs
/// using Base62 (digits, uppercase, and lowercase letters) or Base36
/// (digits and uppercase letters).
///
/// **Note**: Since this implementation relies on the `dart:math`
/// [Random] class, the IDs are not cryptographically secure and
/// should not be used for sensitive purposes like secure tokens.
///
/// @author Godwin Mathias
class ShortId {
  /// The length of the generated ID. Defaults to 6 if not specified.
  final int length;

  /// Creates a [ShortId] instance with an optional length parameter.
  ///
  /// The [length] determines how many characters the generated ID will contain.
  const ShortId({this.length = 6});

  /// A list of Base62 characters: digits (0-9), uppercase letters (A-Z),
  /// and lowercase letters (a-z).
  static final List<String> _base62chars =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
          .split('');

  /// A single instance of [Random] used for generating random indices.
  static final Random _random = Random();

  /// Generates a random ID using Base62 characters.
  ///
  /// The ID consists of [length] characters chosen randomly from the Base62
  /// character set. The resulting string includes digits, uppercase, and
  /// lowercase letters.
  ///
  /// Returns:
  /// - A [String] containing the generated Base62 ID.
  String b62() {
    final StringBuffer sb = StringBuffer();
    for (int i = 0; i < length; i++) {
      // Append a random Base62 character to the StringBuffer
      sb.write(_base62chars[_random.nextInt(62)]);
    }
    return sb.toString();
  }

  /// Generates a random ID using Base36 characters.
  ///
  /// The ID consists of [length] characters chosen randomly from the Base36
  /// character set, which includes digits and uppercase letters.
  ///
  /// Returns:
  /// - A [String] containing the generated Base36 ID.
  String b36() {
    final StringBuffer sb = StringBuffer();
    for (int i = 0; i < length; i++) {
      // Append a random Base36 character to the StringBuffer
      sb.write(_base62chars[_random.nextInt(36)]);
    }
    return sb.toString();
  }

  /// A convenience getter to generate a Base62 ID.
  ///
  /// This is equivalent to calling [b62()] and provides a shorthand way
  /// to generate an ID.
  String get id => b62();
}
