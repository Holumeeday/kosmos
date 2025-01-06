import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/next_button.dart';
import 'package:playkosmos_v3/ui/reviews/view/widgets/star_rating.dart';

class EditReviewPage extends StatefulWidget {
  const EditReviewPage({super.key});

  @override
  State<EditReviewPage> createState() => _EditReviewPageState();
}

class _EditReviewPageState extends State<EditReviewPage> {
  int fRating = 0; // Current rating
  TextEditingController fReviewController =
      TextEditingController(); // Controller for the review text

  // Method to check whether the submit button should be disabled
  bool get isSubmitButtonDisabled =>
      fReviewController.text.trim().isEmpty || fRating == 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        fTitleText: context.loc.editReview,
        fIsLargeDisplayTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Divider to separate sections
            Divider(
              color: context.appColors.fDividerColor,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title text
                  Text(
                    context.loc.showSomeLove,
                    style: context.textTheme.headlineSmall!
                        .copyWith(color: context.colors.tertiary),
                  ),
                  const VSpace(16),
                  // Reviewer's profile section
                  const Row(
                    children: [
                      // Profile picture
                      ProfilePicture(
                          fRadius: 28,
                          fProfilePicture: '',
                          fUserName: "Ashley"),
                      HSpace(12),
                      // Reviewer's name
                      UserNameAndPlan(
                        fUserName: 'Ashlyn',
                        fTextSize: 16,
                      ),
                    ],
                  ),
                  const VSpace(16),
                  // Rating title
                  Text(
                    context.loc.ratings,
                    style: context.appTextTheme.buttonMedium,
                  ),
                  const VSpace(12),
                  // Star rating widget
                  StarRating(
                    starSize: 40,
                    rating: fRating.toDouble(),
                    onRatingChanged: (newRating) =>
                        setState(() => fRating = newRating.toInt()),
                  ),
                  const VSpace(16),
                  // Review title
                  Text(
                    context.loc.setReviews(1),
                    style: context.appTextTheme.buttonMedium,
                  ),
                  const VSpace(12),
                  // Review input field
                  TextField(
                    controller: fReviewController,
                    maxLines: 5,
                    style: context.textTheme.headlineMedium,
                    decoration: InputDecoration(
                      hintText: 'Share your thoughts here.',
                      hintStyle: context.appTextTheme.buttonMedium!
                          .copyWith(color: const Color(0xADACAC)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color:
                              context.appColors.onReviewColor!.withOpacity(0.1),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color:
                              context.appColors.onReviewColor!.withOpacity(0.1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    // Rebuild the widget tree when text changes to update the disabled state
                    onChanged: (_) => setState(() {}),
                  ),
                  const VSpace(16),
                  // Submit button
                  PrimaryGradientButton(
                    fDisabled:
                        isSubmitButtonDisabled, // Check disabled state dynamically
                    fOnPressed: () {
                      // Handle submit logic here
                      debugPrint(
                          "Review submitted: ${fReviewController.text}, Rating: $fRating");
                    },
                    fChild: Text(context.loc.send),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
