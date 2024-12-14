extension NullStringExtension on String? {
  /// To check for null and return an empty string instead
  String get checkNull => this ?? '';

  /// To return a dash when empty
  String get checkNullDash => this ?? '--';

  /// If string is null
  bool get checkIsNull => this == null;
}
