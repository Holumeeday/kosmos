/// Common string operations
///
/// @author: Godwin Mathias
extension StringExtension on String {
  /// To capitalize the first letter of the word/sentence
  String get capitalizeFirst =>
      this[0].toUpperCase() + substring(1).toLowerCase();

  /// To capitalize the first letter of each word in a sentence
  String get capitalizeFirstLetter =>
      split(' ').map((e) => e.capitalizeFirst).join(' ');
}
