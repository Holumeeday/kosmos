import 'package:flutter/material.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/cubit/profile_creation_flow_cubit.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/gradient_slider_tracker.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/next_button.dart';
import 'package:playkosmos_v3/utils/theme/app_colors.dart';

/// Select search radius page
///
/// @author: Chidera Chijama
class UploadSearchRadiusPage extends StatelessWidget {
  const UploadSearchRadiusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCreationFlowCubit, ProfileCreationFlowState>(
      builder: (context, state) {
        final fRadius = context.select((ProfileCreationFlowCubit cubit) =>
                cubit.state.fFlowModel.radius) ??
            0;
        final fRadiusUnit = context.select((ProfileCreationFlowCubit cubit) =>
            cubit.state.fFlowModel.radiusUnits);
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Your location text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                context.loc.searchRadius.capitalizeFirstLetter,
                style: context.appTextTheme.header1,
              ),
            ),
            const VSpace(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                context.loc.howFarAreYouWillingToExplore,
                style: context.appTextTheme.caption,
              ),
            ),
            const VSpace(20),
            const Divider(),

            TextWithBackground(
              fText: context.loc.searchRadius,

              fTextColor: Colors.grey,
              fTextSize: 14,
              fFontWeight: FontWeight.w500,
            ),

            const VSpace(16),
            Column(
              children: UnitOfLocationMeasurementEnum.values.map((measure) {
                return BlocSelector<ProfileCreationFlowCubit,
                    ProfileCreationFlowState, String>(
                  selector: (state) {
                    return state.fFlowModel.radiusUnits ?? 'miles';
                  },
                  builder: (context, selectedOption) {
                    return RadioListTile<String>(
                      title: Text(context.loc.setUnitOfMeasure(measure.name)),
                      value: measure.name,
                      groupValue: selectedOption,
                      onChanged: (value) {
                        if (value != null) {
                          // Debugging print
                          context
                              .read<ProfileCreationFlowCubit>()
                              .setLocationMeasure(value);
                        }
                      },
                    );
                  },
                );
              }).toList(),
            ),
            const Divider(),
            const VSpace(20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${context.loc.distance} ($fRadiusUnit)",
                    style: context.textTheme.bodySmall!.copyWith(fontSize: 14),
                  ),
                  Text(
                    "${(fRadius).toInt()}",
                    style:
                        context.textTheme.displayLarge!.copyWith(fontSize: 20),
                  ),
                ],
              ),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackShape: const GradientRectSliderTrackShape(
                  dDarkenInactive: true,
                ),
              ),
              child: Slider(
                value: fRadius,
                inactiveColor: AppColor.fDarkGrey,
                min: 0,
                max: 200,
                divisions: 200,
                label: null,
                onChanged: (value) {
                  context
                      .read<ProfileCreationFlowCubit>()
                      .setSearchRadius(value);
                },
              ),
            ),
            // Location icon
            const Spacer(),
            // Allow button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: NextButton(
                fOnPressed: () async {
                  if (context.mounted) {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return Dialog(
                            child: AuthSuccessInfoDialog(
                                fTitle: '',
                                fMessage:
                                    context.loc.profileCreationDialogMessage,
                                fWidget: Image.asset(Assets
                                    .pngs.onboarding.welcomeOnboarding.path),
                                fOnLetGo: () {
                                  context.pop();
                                }),
                          );
                        });

                    context.read<ProfileCreationFlowCubit>().nextPage();
                  }
                },
                fText: context.loc.done,
              ),
            ),
          ],
        );
      },
    );
  }
}
