import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:playkosmos_v3/constants/buddies_list.dart';
import 'package:playkosmos_v3/models/buddy_model.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit()
      : super(ReviewsState(
            fBuddy: fullBuddiesList[3],
            fSelectedRating: 'All',
            fFilteredCreatorReviews:
                fullBuddiesList[3].reviews.creatorReviewList,
            fFilteredParticipantReviews:fullBuddiesList[3].reviews.participantReviewList));

  /// Filters the creators reviews based on the selected rating.
  ///
  /// If `rating` is null or 0, all reviews are shown.
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

  /// Filters the creators reviews based on the selected rating.
  ///
  /// If `rating` is null or 0, all reviews are shown.
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