import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/common_widgets/profile_image_with_story_indicator.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/models/buddies_model.dart';
import 'package:playkosmos_v3/ui/reviews/cubit/reviews_cubit.dart';
import 'package:playkosmos_v3/ui/reviews/view/widgets/read_more.dart';
import 'package:playkosmos_v3/ui/reviews/view/widgets/star_rating.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  Widget build(BuildContext context) {
    // Set an initial valid value that matches one of the DropdownMenuItem values.
    final List<String> dropdownOptions = [
      context.loc.all,
      '1',
      '2',
      '3',
      '4',
      '5'
    ];
    String starCountOption = dropdownOptions.first; // Initialize with `all`.

    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        final reviews = state.fBuddy.reviews;

        return Scaffold(
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
            child: Column(
              children: [
                Divider(
                  color: context.appColors.fDividerColor,
                  height: 1,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 14),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const HSpace(4),
                          Text(
                            reviews.totalRating.toString(),
                            style: context.textTheme.displayLarge!
                                .copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                      title: Text(
                        '${reviews.count} ${context.loc.reviews}',
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.headlineSmall!
                            .copyWith(color: context.colors.tertiary),
                      ),
                      trailing: IntrinsicWidth(
                        child: DropdownSearch<String>(
                          onChanged: (value) {
                            if (value != null) {
                              context.read<ReviewsCubit>().filterReviews(value);
                            }
                          },
                          popupProps: PopupProps.menu(
                              fit: FlexFit.tight,
                              itemBuilder: (context, item, isDisabled,
                                      isSelected) =>
                                  Column(
                                    children: [
                                      num.tryParse(item) != null
                                          ? Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: StarRating(
                                                starCount: 5,
                                                rating: double.parse(item),
                                              ))
                                          : Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(20),
                                              color: const Color(0xfff5f5f5),
                                              child: Text(
                                                context.loc.all,
                                                textAlign: TextAlign.center,
                                                style: context
                                                    .textTheme.bodyLarge!
                                                    .copyWith(
                                                        color: context
                                                            .colors.tertiary),
                                              ),
                                            ),
                                      const Divider(
                                        height: 1,
                                      )
                                    ],
                                  )),
                          decoratorProps: const DropDownDecoratorProps(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                border: InputBorder.none,
                                filled: false),
                          ),
                          clickProps: const ClickProps(
                            containedInkWell: true,
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
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white10, // Light grey background
                                borderRadius:
                                    BorderRadius.circular(4), // Rounded corners
                              ),
                              child: num.tryParse(s!) != null
                                  ? StarRating(
                                      starCount: 5,
                                      rating: double.parse(s),
                                    )
                                  : Text(
                                      "                ${context.loc.all}    ",
                                      style: context.textTheme.displayLarge!
                                          .copyWith(fontSize: 18),
                                    ),
                            );
                          },
                        ),
                      ),
                    )),
                Divider(
                  color: context.appColors.fDividerColor,
                  height: 1,
                ),
                Expanded(
                  child: state.fFilteredReviews.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: Text(
                              context.loc.noReview,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center,
                              style: context.textTheme.displayLarge!.copyWith(
                                color: context.colors.primary,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            final review = state.fFilteredReviews[index];
                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                  Row(
                                    children: [
                                      StarRating(
                                        rating: review.rating.toDouble(),
                                        starCount: 5,
                                      ),
                                      const HSpace(12),
                                      Text(
                                        review.timeOfReview
                                            .convertToDateMonthYear,
                                        style: context.textTheme.titleSmall!
                                            .copyWith(
                                                color: context.colors.tertiary),
                                      ),
                                    ],
                                  ),
                                  const VSpace(17),
                                  ReadMoreText(text: review.review)
                                  // Text(
                                  //   review.review,
                                  //   style: context.appTextTheme.body,
                                  // )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: context.appColors.fDividerColor,
                              height: 1,
                            );
                          },
                          itemCount: state.fFilteredReviews.length,
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
