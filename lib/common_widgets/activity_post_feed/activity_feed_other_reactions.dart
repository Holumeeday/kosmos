import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/*
This displays other reactions such as comments, q's and a's, reviews and
participants
@author: Ugochukwu Umeh
*/
class ActivityFeedOtherReactions extends StatelessWidget {
  ///Number of comments
  final int fCommentCount;

  ///To view all the comments
  final VoidCallback fViewComments;

  ///Number of questions and answers
  final int fQuestionsAndAnswersCount;

  ///To view all the questions and answers
  final VoidCallback fViewQuestionsAndAnswers;

  ///Number of participants
  final int fParticipantCount;

  ///To view all the comments
  final VoidCallback fViewParticipants;

  ///Max number of participants
  final int? fMaxNumberOfParticipants;

  ///Reviews count
  final int fReviewsCount;

  ///To view all the comments
  final VoidCallback fViewReviews;

  ///This displays other reactions such as comments, q and a, reviews and
  ///participants
  const ActivityFeedOtherReactions({
    super.key,
    required this.fCommentCount,
    required this.fQuestionsAndAnswersCount,
    required this.fParticipantCount,
    required this.fMaxNumberOfParticipants,
    required this.fReviewsCount,
    required this.fViewComments,
    required this.fViewQuestionsAndAnswers,
    required this.fViewParticipants,
    required this.fViewReviews,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          runSpacing: 7,
          children: [
            //Comments
            _OtherReactionItem(
              fTitle: context.loc.comments,
              fSubtitle: fCommentCount.formatNumToCompact(),
              fSubtitleVisible: fCommentCount > 0,
              fOnItemTapped: fViewComments,
            ),

            //Q and A
            _OtherReactionItem(
              fTitle: context.loc.questionsAndAnswers,
              fSubtitle: fQuestionsAndAnswersCount.formatNumToCompact(),
              fSubtitleVisible: fQuestionsAndAnswersCount > 0,
              fOnItemTapped: fViewQuestionsAndAnswers,
            ),

            //Participants
            Builder(builder: (context) {
              final String participantCount =
                  fParticipantCount.formatNumToCompact();
              //If there is no max number of allowed participant then
              // _maxParticipant becomes empty else it is formatted
              final String maxParticipant = fMaxNumberOfParticipants == null
                  ? ''
                  : '/${fMaxNumberOfParticipants!.formatNumToCompact()}';
              return _OtherReactionItem(
                fTitle: context.loc.participant,
                fSubtitle: '$participantCount$maxParticipant',
                fSubtitleVisible: fParticipantCount > 0,
                fOnItemTapped: fViewParticipants,
              );
            }),

            //Reviews
            _OtherReactionItem(
              fTitle: context.loc.reviews,
              fSubtitle: fReviewsCount.formatNumToCompact(),
              fSubtitleVisible: fReviewsCount > 0,
              fOnItemTapped: fViewReviews,
            ),
          ],
        ),
      ),
    );
  }
}

/*
This displays the other reaction title and subtitle
@author: Ugochukwu Umeh
@date: 14 Mar, 2023
@modified: 23 Mar, 2023
*/
class _OtherReactionItem extends StatelessWidget {
  ///The header or title of the reaction
  final String fTitle;

  ///The number generated for the reaction
  final String fSubtitle;

  ///If [fSubtitle] is visible
  final bool fSubtitleVisible;

  ///When the item is tapped
  final VoidCallback fOnItemTapped;

  const _OtherReactionItem({
    required this.fTitle,
    required this.fSubtitle,
    required this.fSubtitleVisible,
    required this.fOnItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors fAppColors = context.appColors;
    return InkWell(
      onTap: fOnItemTapped,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Title
          Text(
            fTitle,
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          const VSpace(8),

          //Values
          Visibility(
            visible: fSubtitleVisible,
            child: Text(
              '($fSubtitle)',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: fAppColors.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
