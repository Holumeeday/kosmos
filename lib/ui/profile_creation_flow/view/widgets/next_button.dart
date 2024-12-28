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
    final fSelectedInterests = context.select(
        (ProfileCreationFlowCubit cubit) => cubit.state.fSelectedInterestMap);
    final fCanShowNext =
        !canShowSkip(context, dSelectedPage, fSelectedInterests);
    return fCanShowNext
        ? Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: PrimaryGradientButton(
              fOnPressed: fOnPressed,
              fChild: Text(fText ?? context.loc.nextText),
            ),
          )
        : const SizedBox.shrink();
  }

  bool canShowSkip(
    BuildContext context,
    ProfileCreationFlowEnum currentPage,
    Map<String, List<String>> selectedInterests,
  ) {
    return switch (currentPage) {
      ProfileCreationFlowEnum.uploadSpiritualityInterest =>
        selectedInterests['spirituality']?.isEmpty ?? true,
      ProfileCreationFlowEnum.uploadName => false,
      ProfileCreationFlowEnum.uploadSportInterest =>
        selectedInterests['sports']?.isEmpty ?? true,
      ProfileCreationFlowEnum.uploadArtInterest =>
        selectedInterests['arts']?.isEmpty ?? true,
      ProfileCreationFlowEnum.uploadTechInterest =>
        selectedInterests['technology']?.isEmpty ?? true,
      ProfileCreationFlowEnum.uploadEducationInterest =>
        selectedInterests['education']?.isEmpty ?? true,
      ProfileCreationFlowEnum.uploadFoodInterest =>
        selectedInterests['food']?.isEmpty ?? true,
      ProfileCreationFlowEnum.uploadWellnessInterest =>
        selectedInterests['wellness']?.isEmpty ?? true,
      ProfileCreationFlowEnum.uploadAnimalInterest =>
        selectedInterests['animals']?.isEmpty ?? true,
      ProfileCreationFlowEnum.uploadSocialInterest =>
        selectedInterests['social']?.isEmpty ?? true,
      ProfileCreationFlowEnum.uploadProfilePics => context.select(
          (ProfileCreationFlowCubit cubit) =>
              cubit.state.fFlowModel.profilePicsList!.every((e) => e == null)),
      ProfileCreationFlowEnum.uploadBirthday => context.select(
          (ProfileCreationFlowCubit cubit) =>
              cubit.state.fFlowModel.dateOfBirth == null),
      ProfileCreationFlowEnum.uploadGender => context.select(
          (ProfileCreationFlowCubit cubit) =>
              cubit.state.fFlowModel.gender == null),
      ProfileCreationFlowEnum.uploadSearchRadius => context.select(
          (ProfileCreationFlowCubit cubit) =>
              cubit.state.fFlowModel.radius == null),
      ProfileCreationFlowEnum.uploadLocation =>
        context.select((ProfileCreationFlowCubit cubit) => false),
    };
  }
}
