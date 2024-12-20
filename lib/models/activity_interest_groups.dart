/*
This class defines activity interest
@author: Ugochukwu Umeh
*/
import 'package:equatable/equatable.dart';

class ActivityInterestGroupsList extends Equatable {
  /// List of activity interest groups
  final List<ActivityInterestGroups> groups;

  const ActivityInterestGroupsList({required this.groups});

  /// Creates an empty list of activity interest groups
  factory ActivityInterestGroupsList.empty() {
    return const ActivityInterestGroupsList(groups: []);
  }

  /// Serializes the list of activity interest groups to JSON
  Map<String, dynamic> toJson() {
    return {
      for (final item in groups) item.categoryName: item.interests,
    };
  }

  /// Deserializes JSON to a list of activity interest groups
  factory ActivityInterestGroupsList.fromJson(Map<String, dynamic> json) {
    return ActivityInterestGroupsList(groups: [
      for (final item in json.entries)
        ActivityInterestGroups(
            categoryName: item.key, interests: List<String>.from(item.value))
    ]);
  }

  @override
  List<Object?> get props => [groups];

  ActivityInterestGroupsList copyWith({
    List<ActivityInterestGroups>? groups,
  }) {
    return ActivityInterestGroupsList(
      groups: groups ?? this.groups,
    );
  }
}

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
