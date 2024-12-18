import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/mixins/feed_activity_helper_mixin.dart';
import 'package:playkosmos_v3/models/feed_activities_model.dart';
import 'package:playkosmos_v3/models/feed_post_owner_model.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/*
An activity item uploaded
@author: Godwin Mathias
 */
class ActivityFeedItem<T extends FeedActivityHelperMixin>
    extends StatefulWidget {
  final FeedActivityModel fActivity;

  const ActivityFeedItem({
    super.key,
    required this.fActivity,
  });

  @override
  State<ActivityFeedItem<T>> createState() => _ActivityFeedItemState<T>();
}

class _ActivityFeedItemState<T extends FeedActivityHelperMixin>
    extends State<ActivityFeedItem<T>> {
  /// The repaint key
  final GlobalKey fRepaintKey = GlobalKey();

  /// The activity
  FeedActivityModel get fActivity => widget.fActivity;

  @override
  Widget build(BuildContext context) {
    final bool fIsSharedPost = fActivity.sharingPostId?.isNotEmpty ?? false;
    return Semantics(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // If the activity is shared
          Visibility(
            visible: fIsSharedPost,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PostOwner<T>(
                  fActivityOwner: fActivity.sharingPostUser,
                  fIsSharedPost: true,
                  fActivityId: fActivity.id,
                  fIsBookmarked: fActivity.isBookmarked,
                  fShowIcons: true,
                  fDistance: fActivity.postDistance,
                  fRepaintKey: fRepaintKey,
                ),
                const Divider(
                  thickness: 0.4,
                  height: 20,
                ),
              ],
            ),
          ),

          // Original activity
          GestureDetector(
            onTap: () => context
                .read<T>()
                .toActivityPostScreen(fActivity.originalPostId ?? ''),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PostOwner<T>(
                  fActivityOwner: fActivity.originalPostUser,
                  fIsSharedPost: false,
                  fActivityId: fActivity.id,
                  fIsBookmarked: fActivity.isBookmarked,
                  fShowIcons: !fIsSharedPost,
                  fDistance: fActivity.postDistance,
                  fRepaintKey: fRepaintKey,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // The flyer
                      GestureDetector(
                        onTap: () => context.read<T>().toActivityDetails(
                            id: fActivity.id ?? '',
                            toDetailsEnum: ToActivityDetailsEnum.details),
                        child: RepaintBoundary(
                          key: fRepaintKey,
                          child: ActivityFlyerWidget(
                            fFlyer: fActivity.flyer,
                            fFlyerDetails: fActivity.flyerDetails,
                          ),
                        ),
                      ),

                      // The added media
                      ActivityAddedMedia(
                        fAddedMedia: fActivity.postMedia,
                        fToMediaScreen: () =>
                            context.read<T>().toAddedMedia(fActivity.postMedia),
                      ),

                      /// The reactions and comments etc.
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        margin: const EdgeInsets.symmetric(vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: context.colors.tertiary.withOpacity(0.1),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // The reactions part
                            Flexible(
                              child: ActivityFeedReaction(
                                fPostReaction: fActivity.postReactions,
                                fSharesNumber: fActivity.postShares,
                                fUserReaction: fActivity.reaction,
                                fPlaymatesAttending:
                                    fActivity.playmatesAttending,
                                fOnPlaymatesAttendingTapped: () => context
                                    .read<T>()
                                    .playmatesAttending(
                                        context, fActivity.id ?? ''),
                                fOnReactionsTapped: () => context
                                    .read<T>()
                                    .toPostReactions(fActivity.id ?? ''),
                                fToReact: (react) => context
                                    .read<T>()
                                    .reactToActivity(fActivity.id ?? '', react),
                              ),
                            ),
                            const Divider(height: 20),

                            // The comment, q and a, participant and reviews
                            Flexible(
                              child: ActivityFeedOtherReactions(
                                fCommentCount: fActivity.postComments,
                                fQuestionsAndAnswersCount: fActivity.postQnA,
                                fParticipantCount: fActivity.postParticipants,
                                fMaxNumberOfParticipants:
                                    fActivity.maxParticipants,
                                fReviewsCount: fActivity.postReviews,
                                fViewComments: () => context
                                    .read<T>()
                                    .toActivityDetails(
                                        id: fActivity.id ?? '',
                                        toDetailsEnum:
                                            ToActivityDetailsEnum.comments),
                                fViewParticipants: () => context
                                    .read<T>()
                                    .toActivityDetails(
                                        id: fActivity.id ?? '',
                                        toDetailsEnum:
                                            ToActivityDetailsEnum.participant),
                                fViewQuestionsAndAnswers: () => context
                                    .read<T>()
                                    .toActivityDetails(
                                        id: fActivity.id ?? '',
                                        toDetailsEnum:
                                            ToActivityDetailsEnum.qAndA),
                                fViewReviews: () => context
                                    .read<T>()
                                    .toActivityDetails(
                                        id: fActivity.id ?? '',
                                        toDetailsEnum: ToActivityDetailsEnum
                                            .creatorsReview),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*
The owner of the post details
@author: Ugochukwu Umeh
 */
class _PostOwner<T extends FeedActivityHelperMixin> extends StatelessWidget {
  final FeedPostOwnerModel fActivityOwner;
  final bool fIsSharedPost;
  final String? fActivityId;
  final bool fIsBookmarked;
  final bool fShowIcons;
  final double fDistance;
  final GlobalKey fRepaintKey;

  const _PostOwner({
    required this.fActivityOwner,
    required this.fIsSharedPost,
    required this.fActivityId,
    required this.fIsBookmarked,
    required this.fShowIcons,
    required this.fDistance,
    required this.fRepaintKey,
  });

  @override
  Widget build(BuildContext context) {
    final String id = fActivityId ?? '';
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 12, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfilePicture(
                fRadius: 20,
                fUserName: fActivityOwner.username.checkNullDash,
                fProfilePicture: fActivityOwner.displayImage,
                fId: fActivityOwner.id,
                fParticipantType: fActivityOwner.participantType,
              ),
              const HSpace(12),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserNameAndPlan(
                      fUserName: fActivityOwner.username.checkNullDash,
                      fTextSize: 14,
                      fFontWeight: FontWeight.w600,
                      fSubscriptionPlan: fActivityOwner.subscriptionPlan,
                      fMaxLines: 2,
                      fOnTap: () {},
                    ),
                    TaggedAndPostTime(
                      fTaggedList: fActivityOwner.taggedUsers,
                      fOnTaggedTap: () =>
                          context.read<T>().toTaggedUsersView(id),
                      fPostTime: fActivityOwner.postedAt,
                      fIsShared: fIsSharedPost,
                    ),
                  ],
                ),
              ),
              const HSpace(4),
              if (fShowIcons)
                Flexible(
                  flex: 2,
                  child: ActivityPostIcons(
                    fOnShareTap: () {
                      context.read<T>().share(
                            context: context,
                            link: 'https://',
                            id: id,
                            repaintKey: fRepaintKey,
                          );
                    },
                    fOnBookmarkTap: () =>
                        context.read<T>().bookmarkActivity(id, fIsBookmarked),
                    fIsBookmarked: fIsBookmarked,
                    fOnMoreTap: () {
                      showDefaultModal(
                        context,
                        maxHeight: 70,
                        child: ([false, true]..shuffle()).first
                            ? ActivityMoreOptionsUserModal(
                                fCopyLink: 'https://',
                                fCancelActivity: () =>
                                    context.read<T>().cancelActivity(id),
                                fManageActivity: () =>
                                    context.read<T>().manageActivity(id),
                                fEditActivity: () =>
                                    context.read<T>().editActivity(id),
                                fDeletePost: () =>
                                    context.read<T>().deleteActivity(id),
                                fIsSharedPost: fIsSharedPost,
                              )
                            : MoreOptionsNotUserModal(
                                fHideProceedAction: () =>
                                    context.read<T>().hideActivityPost(id),
                                fBlockProceedAction: () => context
                                    .read<T>()
                                    .blockPlaymatePost(fActivityOwner.id ?? ''),
                                fReportProceedAction: () =>
                                    context.read<T>().reportActivityPost(id),
                                fRemoveProceedAction: () => context
                                    .read<T>()
                                    .removePostOwner(fActivityOwner.id ?? ''),
                              ),
                      );
                    },
                    fDistance: fDistance,
                  ),
                ),
            ],
          ),
        ),

        // Post Text
        if (fActivityOwner.postText?.isNotEmpty ?? false)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: ExpandableText(
              fText: fActivityOwner.postText!,
              fTrimLines: 2,
            ),
          ),
      ],
    );
  }
}
