class InterestSelectionModel {
  /// The category title
  final String category;

  /// If can skip
  final bool canSkip;

  /// If user can next
  final bool canNext;

  const InterestSelectionModel({
    required this.category,
    required this.canSkip,
    required this.canNext,
  });
}
