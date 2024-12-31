import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:playkosmos_v3/constants/buddies_list.dart';
import 'package:playkosmos_v3/models/buddy_model.dart';

part 'reviews_state.dart';

/* Cubit responsible for managing the state of reviews.
 Handles filtering of reviews based on selected ratings and manages
 the state of filtered reviews for both Creator and Participant tabs.
@author- Chidera Chijama
 */
class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit()
      : super(ReviewsState(
          fBuddy: fullBuddiesList[3],
          fSelectedRating: 'All',
          fFilteredCreatorReviews:
              fullBuddiesList[3].reviews.creatorReviewList,
          fFilteredParticipantReviews:
              fullBuddiesList[3].reviews.participantReviewList,
        ));

  /// Filters the creator reviews based on the selected rating.
  ///
  /// - If `rating` is null or not a number, all creator reviews are shown.
  /// - Otherwise, filters the creator reviews to only include reviews
  ///   with the specified rating.
  void filterCreatorReviews(String rating) {
    final int? parsedRating = int.tryParse(rating);
    final List<Review> filteredReviews = parsedRating == null
        ? state.fBuddy.reviews.creatorReviewList
        : state.fBuddy.reviews.creatorReviewList
            .where((review) => review.rating == parsedRating)
            .toList();

    emit(
      state.copyWith(
        fFilteredCreatorReviews: filteredReviews,
        fSelectedRating: rating,
      ),
    );
  }

  /// Filters the participant reviews based on the selected rating.
  ///
  /// - If `rating` is null or not a number, all participant reviews are shown.
  /// - Otherwise, filters the participant reviews to only include reviews
  ///   with the specified rating.
  ///
  /// Uses `addPostFrameCallback` to ensure the widget tree is not locked during state updates.
  void filterParticipantReviews(String rating) {
    final int? parsedRating = int.tryParse(rating);
    final List<Review> filteredReviews = parsedRating == null
        ? state.fBuddy.reviews.participantReviewList
        : state.fBuddy.reviews.participantReviewList
            .where((review) => review.rating == parsedRating)
            .toList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      emit(
        state.copyWith(
          fFilteredParticipantReviews: filteredReviews,
          fSelectedRating: rating,
        ),
      );
    });
  }
}
