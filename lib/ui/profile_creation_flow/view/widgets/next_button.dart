import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/cubit/profile_creation_flow_cubit.dart';

/// The next button for the profile creation page
///
/// @author: Godwin Mathias
class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.fOnPressed,
    this.fText,
  });

  /// On click of the button
  final VoidCallback fOnPressed;

  /// The button label
  final String? fText;

  @override
  Widget build(BuildContext context) {
    final dSelectedPage = context.select(
        (ProfileCreationFlowCubit cubit) => cubit.state.fProfileCreationStage);
    final fCanShowNext = !canShowSkip(context, dSelectedPage);
    return fCanShowNext
        ? PrimaryGradientButton(
            fOnPressed: fOnPressed,
            fChild: Text(fText ?? context.loc.nextText),
          )
        : const SizedBox.shrink();
  }

  bool canShowSkip(BuildContext context, ProfileCreationFlowEnum currentPage) {
    return switch (currentPage) {
      ProfileCreationFlowEnum.uploadName => false,
      ProfileCreationFlowEnum.uploadProfilePics => context.select(
          (ProfileCreationFlowCubit cubit) =>
              cubit.state.fFlowModel.profilePicsList!.every((e) => e == null)),
      ProfileCreationFlowEnum.uploadBirthday => context.select(
          (ProfileCreationFlowCubit cubit) =>
              cubit.state.fFlowModel.dateOfBirth == null),
      ProfileCreationFlowEnum.uploadGender => context.select(
          (ProfileCreationFlowCubit cubit) =>
              cubit.state.fFlowModel.gender == null),
      ProfileCreationFlowEnum.uploadInterest =>
        context.select((ProfileCreationFlowCubit cubit) {
          final interests =
              cubit.state.fSelectedInterestMap.values.expand((e) => e);
          return interests
              .isEmpty; // If no interests are selected, show the button
        }),
      ProfileCreationFlowEnum.uploadSearchRadius => context.select(
          (ProfileCreationFlowCubit cubit) =>
              cubit.state.fFlowModel.radius == null),
      ProfileCreationFlowEnum.uploadLocation =>
        context.select((ProfileCreationFlowCubit cubit) => false),
    };
  }
}
