import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/cubit/profile_creation_flow_cubit.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/models/profile_creation_flow_model.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/next_button.dart';

/// Upload gender page
///
/// @author: Godwin Mathias
class UploadGenderPage extends StatelessWidget {
  const UploadGenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fSelectedGender = context.select(
        (ProfileCreationFlowCubit cubit) => cubit.state.fFlowModel.gender);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "What is your gender ?",
            style: context.appTextTheme.header1,
          ),
          const VSpace(40),

          // Genders
          for (final gender in GenderEnum.values) ...[
            InkWell(
              borderRadius: BorderRadius.circular(56),
              onTap: () {
                context.read<ProfileCreationFlowCubit>().changeGender(gender);
              },
              child: _GenderContainer(
                fIsSelected: gender == fSelectedGender,
                fText: context.loc.setGenderAuth(gender.name),
              ),
            ),
            const VSpace(20),
          ],
          const VSpace(40),

          // Next button
          NextButton(fOnPressed: () {
            context.read<ProfileCreationFlowCubit>().nextPage();
          }),
        ],
      ),
    );
  }
}

class _GenderContainer extends StatelessWidget {
  const _GenderContainer({
    super.key,
    required this.fIsSelected,
    required this.fText,
  });

  /// If this is selected
  final bool fIsSelected;

  /// The gender text
  final String fText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(56),
          border: Border.all(
            width: 2,
            color: fIsSelected
                ? context.colors.primary
                : context.appColors.darkGreyColor!.withOpacity(.3),
          )),
      child: Text(
        fText,
        style: context.appTextTheme.buttonLarge
            ?.copyWith(color: fIsSelected ? context.colors.primary : null),
      ),
    );
  }
}
