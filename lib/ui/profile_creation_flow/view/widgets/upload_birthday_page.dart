import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/sizes.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/cubit/profile_creation_flow_cubit.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/date_picker_textfield.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/next_button.dart';

/// birthday page for the profile creation flow
///
/// @author: Godwin Mathias
class UploadBirthdayPage extends StatelessWidget {
  const UploadBirthdayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              context.loc.whatsYourBirthday,
              style: context.appTextTheme.header1,
            ),
            const VSpace(12),
            Text(
              context.loc.dontWorryItsBetweenUs,
              style: context.appTextTheme.caption,
            ),
            const VSpace(40),

            // Birthday text field
            Center(
                child: SegmentedDatePicker(
              fInitialDate: context.select((ProfileCreationFlowCubit cubit) =>
                  cubit.state.fFlowModel.dateOfBirth),
              fOnDateSelected: (d) {
                if (d == null) return;
                context.read<ProfileCreationFlowCubit>().changeBirthday(d);
              },
            )),
            const VSpace(22),

            // The next button
            NextButton(fOnPressed: () {
              context.read<ProfileCreationFlowCubit>().nextPage();
            }),
          ],
        ),
      ),
    );
  }
}
