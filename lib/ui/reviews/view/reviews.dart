import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/common_widgets/profile_image_with_story_indicator.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/models/buddy_model.dart';
import 'package:playkosmos_v3/ui/reviews/cubit/reviews_cubit.dart';
import 'package:playkosmos_v3/ui/reviews/view/widgets/read_more.dart';
import 'package:playkosmos_v3/ui/reviews/view/widgets/star_rating.dart';
import 'package:sliver_tools/sliver_tools.dart';

/// Displays a detailed review page for a specific buddy.
///
/// This page includes an app bar, overall rating section, and two tabs
/// (Creator and Participant reviews) with filtered review lists.
/// Reviews can be filtered by rating using a dropdown.
/// @author- Chidera Chijama
class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        final reviews = state.fBuddy.reviews;

        return Scaffold(
          // App bar displaying buddy name and review count
          appBar: CustomAppBar(
            fElevation: 0,
            fShowBackButton: true,
            fTitle: Text(
              '${state.fBuddy.userName} ${context.loc.reviews}',
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.displayLarge!.copyWith(
                color: context.colors.onSurface,
                fontSize: 28,
              ),
            ),
          ),
          body: SafeArea(
            child: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                // Header containing the overall ratings and tabs
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          // Divider separating sections
                          Divider(
                            color: context.appColors.fDividerColor,
                            height: 1,
                          ),
                          // Section displaying overall ratings
                          InfoSummaryContainer(
                            fPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            fChild: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Label for overall ratings
                                Text(
                                  context.loc.overallRatings,
                                  style: context.textTheme.displayLarge!
                                      .copyWith(fontSize: 18),
                                ),
                                // Display of average rating and total reviews
                                Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.amber, size: 20),
                                        const HSpace(4),
                                        Text(
                                          reviews.averageRating.toString(),
                                          style: context.textTheme.displayLarge!
                                              .copyWith(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${reviews.count} ${context.loc.setReviews(reviews.count)}',
                                      overflow: TextOverflow.ellipsis,
                                      style: context.textTheme.headlineSmall!
                                          .copyWith(
                                              color: context.colors.tertiary),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

                          Divider(
                            color: context.appColors.fDividerColor,
                            height: 1,
                          ),
                        ],
                      ),
                    ),
                    // Tab navigation for Creator and Participant reviews
                    SliverAppBar(
                      pinned: true,
                      floating: true,
                      snap: true,
                      automaticallyImplyLeading: false,
                      toolbarHeight: 0,
                      bottom: CustomTabbar(
                        fTabs: [
                          Tab(
                              text:
                                  '${context.loc.creator} (${state.fBuddy.reviews.creatorReviewList.length})'),
                          Tab(
                              text:
                                  '${context.loc.participant}  (${state.fBuddy.reviews.participantReviewList.length})'),
                        ],
                      ),
                    ),
                  ];
                },
                // Tab bar views for Creator and Participant reviews
                body: TabBarView(
                  children: [
                    // Creator reviews tab
                    ReviewTabView(
                      rating: reviews.creatorOverallRating.toString(),
                      label: context.loc.creator,
                      reviews: state.fFilteredCreatorReviews,
                      onChanged: (value) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (value != null) {
                            context
                                .read<ReviewsCubit>()
                                .filterCreatorReviews(value);
                          }
                        });
                      },
                    ),
                    // Participant reviews tab
                    ReviewTabView(
                      rating: reviews.participantOverallRating.toString(),
                      label: context.loc.participant,
                      reviews: state.fFilteredParticipantReviews,
                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<ReviewsCubit>()
                              .filterParticipantReviews(value);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Displays a single review tab with filters and a list of reviews.
///
/// Provides a dropdown for rating-based filtering, and lists reviews with
/// reviewer details, rating, date, and review text.
class ReviewTabView extends StatelessWidget {
  const ReviewTabView({
    super.key,
    required this.reviews,
    this.onChanged,
    required this.label,
    required this.rating,
  });

  final List<Review> reviews;
  final void Function(String?)? onChanged;
  final String label;
  final String rating;

  @override
  Widget build(BuildContext context) {
    final List<String> dropdownOptions = [
      context.loc.all,
      '1',
      '2',
      '3',
      '4',
      '5',
    ];
    String starCountOption = dropdownOptions.first;

    return reviews.isEmpty
        ? Center(
            // Display when no reviews are available
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                context.loc.noReview,
                textAlign: TextAlign.center,
                style: context.textTheme.displayLarge!.copyWith(
                  color: context.colors.primary,
                  fontSize: 28,
                ),
              ),
            ),
          )
        : CustomScrollView(
            slivers: [
              // Dropdown filter for ratings

              SliverPinnedHeader(
                child: Container(
                  color: context.appColors.reviewColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: Wrap(
                      children: [
                        Text(
                          "${getScreenWidth(context) > 410 ? label : ''} ${context.loc.rating.capitalizeFirstLetter}",
                          style: context.appTextTheme.body!
                              .copyWith(color: context.colors.tertiary),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 20),
                            const HSpace(4),
                            Text(
                              rating.toString(),
                              style: context.textTheme.displayLarge!
                                  .copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IntrinsicWidth(
                      child: DropdownSearch<String>(
                        onChanged: onChanged,
                        popupProps: PopupProps.menu(
                          fit: FlexFit.tight,
                          itemBuilder:
                              (context, item, isDisabled, isSelected) => Column(
                            children: [
                              num.tryParse(item) != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: StarRating(
                                        starCount: 5,
                                        rating: double.parse(item),
                                      ),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.all(20),
                                      color: context.appColors.reviewColor,
                                      child: Text(
                                        context.loc.all,
                                        textAlign: TextAlign.center,
                                        style: context
                                            .appTextTheme.buttonMedium!
                                            .copyWith(
                                                color: context.colors.tertiary),
                                      ),
                                    ),
                              const Divider(
                                height: 1,
                              ),
                            ],
                          ),
                        ),
                        decoratorProps: const DropDownDecoratorProps(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                        suffixProps: const DropdownSuffixProps(
                          dropdownButtonProps: DropdownButtonProps(
                            iconClosed: Icon(Icons.keyboard_arrow_down),
                            iconOpened: Icon(Icons.keyboard_arrow_up),
                          ),
                        ),
                        selectedItem: starCountOption,
                        items: (f, cs) => dropdownOptions,
                        dropdownBuilder: (c, s) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: num.tryParse(s!) != null
                                ? StarRating(
                                    starCount: 5,
                                    rating: double.parse(s),
                                  )
                                : Text(
                                    "                  ${context.loc.all}   ",
                                    style: context.textTheme.displayLarge!
                                        .copyWith(fontSize: 18),
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              // List of reviews
              SliverClip(
                clipOverlap: true,
                child: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final review = reviews[index];

                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Reviewer details
                            ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              leading: ProfileImageWithStoryIndicator(
                                fImage: review.reviewer.profileImages[0],
                              ),
                              title: Text(
                                review.reviewer.userName,
                                style: context.textTheme.titleSmall,
                              ),
                            ),
                            // Review rating and date
                            Row(
                              children: [
                                StarRating(
                                  rating: review.rating.toDouble(),
                                  starCount: 5,
                                ),
                                const HSpace(12),
                                Text(
                                  review.timeOfReview.convertToDateMonthYear,
                                  style: context.textTheme.titleSmall!
                                      .copyWith(color: context.colors.tertiary),
                                ),
                              ],
                            ),
                            const VSpace(17),
                            // Review text with "Read More" option
                            ReadMoreText(text: review.review),
                          ],
                        ),
                      );
                    },
                    childCount: reviews.length,
                  ),
                ),
              ),
            ],
          );
  }
}
