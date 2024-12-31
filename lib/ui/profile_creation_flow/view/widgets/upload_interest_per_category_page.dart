import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/cubit/profile_creation_flow_cubit.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/next_button.dart';

/// This page is used to select the interest and category
///
/// @author: Godwin Mathias
class UploadInterestPerCategoryPage extends StatelessWidget {
  const UploadInterestPerCategoryPage({
    super.key,
    required this.fCategoryTitle,
  });

  /// The interest category
  final String fCategoryTitle;

  @override
  Widget build(BuildContext context) {
    final fInterestGroupList = context.select(
        (ProfileCreationFlowCubit cubit) => cubit.state.fFlowModel.interests)!;
    final fInterestGroup =
        fInterestGroupList.firstWhere((e) => e.categoryName == fCategoryTitle);
    final fSelectedInterestsMap = context.select(
        (ProfileCreationFlowCubit cubit) => cubit.state.fSelectedInterestMap);

    /// Selected interests
    final List<String> fSelectedInterestsList =
        fSelectedInterestsMap[fCategoryTitle] ?? <String>[];

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          //  Interest
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              context.loc.setInterestCategoryPageTitle(fCategoryTitle),
              style: context.appTextTheme.header1,
            ),
          ),
          const VSpace(20),

          // The category title
          _InterestHeader(
            fTitle:
                context.loc.setInterestCategories(fInterestGroup.categoryName),
            fIsSelectAll: fInterestGroup.selectAll,
            fOnSelectAll: (v) {
              context
                  .read<ProfileCreationFlowCubit>()
                  .setSelectAllInterestGroup(fInterestGroup);
            },
          ),
          const VSpace(12),

          // Select interest chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: Wrap(
                runSpacing: 16,
                spacing: 10,
                children: [
                  for (final interest in fInterestGroup.interests)
                    InkWell(
                      borderRadius: BorderRadius.circular(40),
                      onTap: () {
                        context.read<ProfileCreationFlowCubit>().selectInterest(
                              fInterestGroup,
                              interest,
                            );
                      },
                      child: _InterestChip(
                        fIsSelected: fInterestGroup.selectAll ||
                            fSelectedInterestsList.contains(interest),
                        fText: context.loc.setInterests(interest),
                      ),
                    ),
                ],
              ),
            ),
          ),

          const VSpace(30),

          // Next button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: NextButton(
              fOnPressed: () async {
                if (context.mounted) {
                  // Navigate to the next stage
                  context.read<ProfileCreationFlowCubit>().nextPage();
                }
              },
              fText: context.loc.nextText,
            ),
          ),
        ],
      ),
    );
  }
}

class _InterestHeader extends StatelessWidget {
  const _InterestHeader({
    required this.fIsSelectAll,
    required this.fOnSelectAll,
    required this.fTitle,
  });

  /// If select all
  final bool fIsSelectAll;

  /// On select all
  final ValueChanged<bool> fOnSelectAll;

  /// The header title
  final String fTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category text
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
              color: context.appColors.darkGreyColor?.withOpacity(.07),
              border: Border.symmetric(
                horizontal: BorderSide(
                  width: 1,
                  color: context.appColors.darkGreyColor!.withOpacity(.4),
                ),
              )),
          child: Text(
            fTitle,
            style: context.appTextTheme.body,
          ),
        ),
        const VSpace(12),

        // Switch button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                context.loc.selectAll,
                style: context.appTextTheme.buttonMedium,
              ),
              const HSpace(12),
              Switch(
                  value: fIsSelectAll,
                  onChanged: (v) {
                    fOnSelectAll.call(v);
                  }),
            ],
          ),
        )
      ],
    );
  }
}

class _InterestChip extends StatelessWidget {
  const _InterestChip({
    required this.fIsSelected,
    required this.fText,
  });

  /// Is selected
  final bool fIsSelected;

  /// Chip text value
  final String fText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: fIsSelected
              ? context.colors.primary
              : context.appColors.darkGreyColor!.withOpacity(.5),
        ),
      ),
      child: Text(
        fText,
        style: context.appTextTheme.body?.copyWith(
          color: fIsSelected
              ? context.colors.primary
              : context.appColors.darkGreyColor?.withOpacity(.9),
        ),
      ),
    );
  }
}
