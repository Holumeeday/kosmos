/*
This class defines activity interest
@author: Ugochukwu Umeh
*/
import 'package:equatable/equatable.dart';

class ActivityInterestGroups extends Equatable {
  ///The name of the category
  final String categoryName;

  ///The interests
  final List<String> interests;

  /// Select all
  final bool selectAll;

  /// Show all
  final bool showAll;

  const ActivityInterestGroups({
    required this.categoryName,
    required this.interests,
    this.selectAll = false,
    this.showAll = false,
  });

  ///Creates an interest group with no interest
  ActivityInterestGroups emptyInterests() {
    return ActivityInterestGroups(
      categoryName: categoryName,
      interests: const [],
    );
  }

  ActivityInterestGroups copyWith({
    String? categoryName,
    List<String>? interests,
    bool? selectAll,
    bool? showAll,
  }) {
    return ActivityInterestGroups(
      categoryName: categoryName ?? this.categoryName,
      interests: interests ?? this.interests,
      selectAll: selectAll ?? this.selectAll,
      showAll: showAll ?? this.showAll,
    );
  }

  @override
  List<Object> get props => [
        categoryName,
        interests,
        selectAll,
        showAll,
      ];
}
