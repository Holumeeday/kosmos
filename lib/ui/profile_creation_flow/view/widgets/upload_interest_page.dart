import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/data_transfer_objects/activity_interest_groups.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/cubit/profile_creation_flow_cubit.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/next_button.dart';


/// Define the selection of interests page
///
/// @author: Godwin Mathias
class UploadInterestPage extends StatelessWidget {
  const UploadInterestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fInterestGroupList = context.select(
        (ProfileCreationFlowCubit cubit) => cubit.state.fFlowModel.interests);
    final fSelectedInterestsList = context.select(
        (ProfileCreationFlowCubit cubit) => cubit.state.fSelectedInterestMap);

    return CustomScrollView(
      slivers: <Widget>[
        // Tell us your interest
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              context.loc.tellUsYourInterest,
              style: context.appTextTheme.header1,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: VSpace(40)),

        SliverList.separated(
          separatorBuilder: (_, __) => const VSpace(20),
          itemCount: fInterestGroupList!.length,
          itemBuilder: (context, index) {
            return _InterestGroupList(
              fInterestGroup: fInterestGroupList[index],
              fSelectedInterestsList: fSelectedInterestsList[
                      fInterestGroupList[index].categoryName] ??
                  [],
            );
          },
        ),

        const SliverToBoxAdapter(child: VSpace(30)),
        // Allow button
        SliverToBoxAdapter(
          child: Padding(
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
        ),
      ],
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
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Soccer icon
          Flexible(
            child: Row(
              children: [
                const Icon(
                  Icons.sports_soccer_rounded,
                ),
                const HSpace(10),

                // Title text
                Flexible(
                  child: Text(
                    fTitle,
                    style: context.appTextTheme.body,
                  ),
                ),
              ],
            ),
          ),

          // Switch button
          Switch(
              value: fIsSelectAll,
              onChanged: (v) {
                fOnSelectAll.call(v);
              }),
          const HSpace(12),
          Text(
            context.loc.selectAll,
            style: context.appTextTheme.buttonMedium,
          )
        ],
      ),
    );
  }
}

class _InterestGroupList extends StatelessWidget {
  /// Selected interests
  final List<String> fSelectedInterestsList;

  /// Interest group
  final ActivityInterestGroups fInterestGroup;

  const _InterestGroupList({
    required this.fInterestGroup,
    required this.fSelectedInterestsList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // The interest header
        _InterestHeader(
          fTitle: context.loc.setInterestCategory(fInterestGroup.categoryName),
          fIsSelectAll: fInterestGroup.selectAll,
          fOnSelectAll: (v) {
            context
                .read<ProfileCreationFlowCubit>()
                .setSelectAllInterestGroup(fInterestGroup);
          },
        ),

        const VSpace(20),

        // Select interest chips
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            child: Wrap(
              runSpacing: 16,
              spacing: 10,
              children: [
                for (final interest in (fInterestGroup.showAll
                    ? fInterestGroup.interests
                    : fInterestGroup.interests.take(4)))
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
                      fText: context.loc.setInterestName(interest),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const VSpace(25),

        // Show all button
        if (fInterestGroup.interests.length >= 4)
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                context
                    .read<ProfileCreationFlowCubit>()
                    .setShowAll(fInterestGroup);
              },
              child: ShowAllButton(fShowAll: fInterestGroup.showAll,fText1: context.loc.showAll2,fText2: context.loc.showLess,),
            ),
          ),
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
