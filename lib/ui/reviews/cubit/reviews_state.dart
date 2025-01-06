part of 'reviews_cubit.dart';

class ReviewsState extends Equatable {
  const ReviewsState({
    required this.fBuddy,
    required this.fFilteredCreatorReviews,
    required this.fFilteredParticipantReviews,
    required this.fSelectedRating,
  });

  final DummyBuddyModel fBuddy;
  final List<Review> fFilteredParticipantReviews;
  final List<Review> fFilteredCreatorReviews;

  final String fSelectedRating;

  @override
  List<Object> get props => [
        fBuddy,
        fFilteredCreatorReviews,
        fFilteredParticipantReviews,
        fSelectedRating
      ];

  ReviewsState copyWith({
    DummyBuddyModel? fBuddy,
    List<Review>? fFilteredParticipantReviews,
    List<Review>? fFilteredCreatorReviews,
    String? fSelectedRating,
  }) {
    return ReviewsState(
      fBuddy: fBuddy ?? this.fBuddy,
      fFilteredCreatorReviews:
          fFilteredCreatorReviews ?? this.fFilteredCreatorReviews,
      fFilteredParticipantReviews:
          fFilteredParticipantReviews ?? this.fFilteredParticipantReviews,
      fSelectedRating: fSelectedRating ?? this.fSelectedRating,
    );
  }
}
