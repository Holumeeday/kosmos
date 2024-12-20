import 'package:flutter/widgets.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/mixins/sharing_mixin.dart';
import 'package:playkosmos_v3/models/feed_activities_model.dart';
import 'package:playkosmos_v3/utils/utils.dart';

mixin FeedActivityHelperMixin on SharingLinkMixin {
  List<FeedActivityModel> fFeedActivities = [];
  List<FeedActivityModel> fOriginalActivities = [];

  /// To view the activity post
  void toActivityPostScreen(String id) {}

  /// To view the status post
  void toStatusPostScreen(String id) {}

  /// To move to the tagged to activity screen
  void toTaggedUsersView(String id) {}

  /// To go to the activity details page
  void toActivityDetails({
    required String id,
    required ToActivityDetailsEnum toDetailsEnum,
  }) {}

  /// To share the post link
  void share({
    required BuildContext context,
    required String link,
    required String id,
    GlobalKey? repaintKey,
  }) async {
    await showDefaultModal(
      context,
      maxHeight: 70,
      child: IconShareModal(
        fOtherShare: () => shareLink(
          context: context,
          linkLocation: link,
          repaintKey: repaintKey,
        ),
        fShareToTimeline: () => shareActivityToTimeline(id),
      ),
    );
  }

  /// To share activity to timeline
  void shareActivityToTimeline(String id) {}

  /// To manage an activity
  void manageActivity(String id) {
  }

  /// To edit an activity
  void editActivity(String id) {}

  /// To report an activity post
  void reportActivityPost(String id) {}

  /// To go to added media
  void toAddedMedia(List<String> media) {}

  /// To view the list of playmates attending
  void playmatesAttending(BuildContext context, String id) {}

  /// To view the reactions to a post
  void toPostReactions(String id) {}

  /// If the element is in [fFeedActivities] list
  int? _indexInActivitiesList(String id) {
    final index = fFeedActivities.indexWhere((element) => element.id == id);
    return index >= 0 ? index : null;
  }

  /// To set [dFeedActivityResponse]
  void _setActivities(List<FeedActivityModel> activities) {
    fFeedActivities = activities;
    // Update widgets
  }

  /// To set [dOriginalActivityResponse]
  void _setOriginalActivities(List<FeedActivityModel> activities) {
    fOriginalActivities = activities;
  }

  void setActivityResponse(List<FeedActivityModel> response,
      {required bool isPagination}) {
    if (isPagination) {
      fFeedActivities = [...fFeedActivities, ...response];

      fOriginalActivities = [...fOriginalActivities, ...response];
    } else {
      fFeedActivities = response;
      fOriginalActivities = response;
    }
    // Update widgets
  }

  /// To bookmark an activity
  void bookmarkActivity(String id, bool isBookmarked) async {
    try {
      _bookmarkActivity(id);

      _setOriginalActivities(fFeedActivities);
    } catch (e) {
      //
    }
  }

  /// The core function to bookmark or unbookmark an activity
  void _bookmarkActivity(String id) {
    final index = _indexInActivitiesList(id);
    if (index != null) {
      FeedActivityModel activity = fFeedActivities[index];
      activity =
          fFeedActivities[index].copyWith(isBookmarked: !activity.isBookmarked);
      final newList = fFeedActivities.playkosmosUpdate(index, activity);
      _setActivities(newList);
    }
  }

  /// To remove an activity from the list
  void _removeFromActivities(String id, bool isError) {
    if (isError) {
      _setActivities(fOriginalActivities);
    } else {
      final index = _indexInActivitiesList(id);
      if (index != null) {
        final newList = fFeedActivities.playkosmosRemoveAt(index);
        _setActivities(newList);
      }
    }
  }

  /// To cancel an activity
  void cancelActivity(String id) async {
    _removeFromActivities(id, false);
  }

  /// To delete an activity post
  void deleteActivity(String id) async {
    try {
      _removeFromActivities(id, false);
      _setOriginalActivities(fFeedActivities);
    } catch (e) {
      _removeFromActivities(id, true);
    }
  }

  /// To hide an activity post
  void hideActivityPost(String id) async {
    try {
      _removeFromActivities(id, false);

      _setOriginalActivities(fFeedActivities);
    } catch (e) {
      _removeFromActivities(id, true);
    }
  }

  /// To block a user posts
  void blockPlaymatePost(String ownerId) async {
    try {
      final newActivityList =
          fFeedActivities.playkosmosRemoveWhere((e) => e.ownerId == ownerId);
      _setActivities(newActivityList);
      _setOriginalActivities(fFeedActivities);
    } catch (e) {
      _setActivities(fOriginalActivities);
    }
  }

  /// To remove owner from playmate
  void removePostOwner(String ownerId) async {
    try {
      final newActivityList =
          fFeedActivities.playkosmosRemoveWhere((e) => e.ownerId == ownerId);
      _setActivities(newActivityList);
      _setOriginalActivities(fFeedActivities);
    } catch (e) {
      _setActivities(fOriginalActivities);
    }
  }

  /// To react to an activity
  void reactToActivity(String id, ReactionIconTypeEnum? reaction) async {
    try {
      _reactToActivity(id, reaction);

      _setOriginalActivities(fFeedActivities);
    } catch (e) {
      //
    }
  }

  /// The core function to react to an activity
  void _reactToActivity(String id, ReactionIconTypeEnum? reaction) {
    final index = _indexInActivitiesList(id);
    if (index != null) {
      FeedActivityModel activity = fFeedActivities[index];
      final oldReaction = activity.reaction;
      final List<ReactionIconTypeEnum> postReactions =
          List.from(activity.postReactions)..remove(oldReaction);
      if (reaction == null) {
        activity =
            fFeedActivities[index].updateReaction(postReactions: postReactions);
      } else {
        postReactions.add(reaction);
        activity = fFeedActivities[index]
            .updateReaction(reaction: reaction, postReactions: postReactions);
      }
      final newList = fFeedActivities.playkosmosUpdate(index, activity);
      _setActivities(newList);
    }
  }

  /// Retry last request
  void retryLastRequest() {}
}
