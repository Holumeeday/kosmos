part of 'reviews_cubit.dart';

class ReviewsState extends Equatable {
  const ReviewsState({
    required this.fBuddy,
   required this.fFilteredReviews,
   required this.fSelectedRating ,
  });

  final BuddiesModel fBuddy;
  final List<Review> fFilteredReviews;
  final String fSelectedRating;

  @override
  List<Object> get props => [fBuddy, fFilteredReviews, fSelectedRating];

  ReviewsState copyWith({
    BuddiesModel? fBuddy,
    List<Review>? fFilteredReviews,
    String? fSelectedRating,
  }) {
    return ReviewsState(
      fBuddy: fBuddy ?? this.fBuddy,
      fFilteredReviews: fFilteredReviews ?? this.fFilteredReviews,
      fSelectedRating: fSelectedRating ?? this.fSelectedRating,
    );
  }
}
