import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/constants/buddies_list.dart';
import 'package:playkosmos_v3/models/buddies_model.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit() : super(ReviewsState(fBuddy: fullBuddiesList[3],fSelectedRating: 'All',fFilteredReviews: []));


    /// Filters the reviews based on the selected rating.
  ///
  /// If `rating` is null or 0, all reviews are shown.
  void filterReviews(String rating) {
    final int? parsedRating = int.tryParse(rating);
    final List<Review> filteredReviews = parsedRating == null
        ? state.fBuddy.reviews.reviewList
        : state.fBuddy.reviews.reviewList
            .where((review) => review.rating == parsedRating)
            .toList();

    emit(
      state.copyWith(
        fFilteredReviews: filteredReviews,
        fSelectedRating: rating,
      ),
    );
  }

}
