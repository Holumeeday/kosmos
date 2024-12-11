/*
This class defines activity interest
@author: Ugochukwu Umeh
*/
class ActivityInterestGroups {
  ///The name of the category
  final String categoryName;

  ///The interests
  final List<String> interests;

  const ActivityInterestGroups({
    required this.categoryName,
    required this.interests,
  });

  ///Creates an interest group with no interest
  ActivityInterestGroups emptyInterests() {
    return ActivityInterestGroups(
      categoryName: categoryName,
      interests: [],
    );
  }
}
