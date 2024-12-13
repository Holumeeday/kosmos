import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/custom_radio_list_tile.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/cubit/profile_creation_flow_cubit.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/gradient_slider_tracker.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/next_button.dart';
import 'package:playkosmos_v3/utils/theme/app_colors.dart';

/// Select search radius page
///
/// @author: Chidera Chijama
class SearchRadiusPage extends StatelessWidget {
  const SearchRadiusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<ProfileCreationFlowCubit, ProfileCreationFlowState>(
        builder: (context, state) {
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
                fContainerColor:
                    context.appColors.darkGreyColor?.withOpacity(.07),
                fBackgroundColor: Colors.grey,
                fTextSize: 14,
                fFontWeight: FontWeight.w500,
              ),

              const VSpace(16),
              Column(
                children: UnitOfLocationMeasurementEnum.values.map((measure) {
                  return BlocSelector<ProfileCreationFlowCubit,
                      ProfileCreationFlowState, String>(
                    selector: (state) => state.fLocationMeasure,
                    builder: (context, selectedOption) {
                      return RadioListTile<String>(
                        title: Text(context.loc.setUnitOfMeasure(measure.name)),
                        value: measure.name,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          if (value != null) {
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
                      "${context.loc.distance} (${state.fLocationMeasure})",
                      style:
                          context.textTheme.bodySmall!.copyWith(fontSize: 14),
                    ),
                    Text(
                      "${state.fSearchRadius.toInt()}",
                      style: context.textTheme.displayLarge!
                          .copyWith(fontSize: 20),
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
                  value: state.fSearchRadius,
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

              // Allow button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: NextButton(
                  fOnPressed: () async {
                    final fIsPermitted = await context
                        .read<PermissionsRepository>()
                        .requestLocationPermission();
                    if (fIsPermitted && context.mounted) {
                      // Navigate to the next stage
                      context.read<ProfileCreationFlowCubit>().nextPage();
                    }
                  },
                  fText: context.loc.done,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/*
This class shows the search radius and unit of measure part of the location screen
@author: Ugochukwu Umeh
*/
class SearchRadiusPart extends StatelessWidget {
  ///If its a screen with width wider than 600px
  final bool fIsTablet;

  ///When the radio is changed
  final void Function(UnitOfLocationMeasurementEnum) fRadioChanged;

  ///The group value of the radio
  final UnitOfLocationMeasurementEnum fRadioGroupValue;

  ///The slider value
  final double fSliderValue;

  ///When the slider is dragged
  final void Function(double) fSliderChanged;

  const SearchRadiusPart({
    super.key,
    required this.fIsTablet,
    required this.fRadioChanged,
    required this.fRadioGroupValue,
    required this.fSliderValue,
    required this.fSliderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 5,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Search radius text
            ExcludeSemantics(
              child: TextWithBackground(
                fText: context.loc.searchRadius,
                fBackgroundColor: context.colors.secondary,
                fTextSize: 14,
                fFontWeight: FontWeight.w500,
              ),
            ),

            //Unit of measure
            Semantics(
              label: context.loc.selectUnitOfMeasure,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: (fIsTablet ? 10 : 20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //Unit of measure text
                    ExcludeSemantics(
                      child: Text(
                        context.loc.unitOfMeasure,
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                    const VSpace(14),

                    //Unit of measure
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: UnitOfLocationMeasurementEnum.values
                          .map<Widget>((measure) {
                        return Flexible(
                          child: CustomRadioListTile(
                            fRadioFirst: false,
                            fOnChanged: () {
                              fRadioChanged(measure);
                            },
                            fTextSize: 17,
                            fTitle: context.loc.setUnitOfMeasure(measure.name),
                            fValue: measure,
                            fGroupValue: fRadioGroupValue,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),

            //Search radius
            Semantics(
              label: context.loc.selectSearchRadius(
                context.loc.setUnitOfMeasure(fRadioGroupValue.name),
              ),
              explicitChildNodes: true,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: (fIsTablet ? 10 : 20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //Search radius text
                    ExcludeSemantics(
                      child: Text(
                        '${context.loc.searchRadius}(${context.loc.setUnitOfMeasure(fRadioGroupValue.name)})',
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                    const VSpace(14),

                    //Slider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Semantics(
                            liveRegion: true,
                            label: context.loc.searchRadiusDistance(
                              fSliderValue.ceil(),
                              context.loc
                                  .setUnitOfMeasure(fRadioGroupValue.name),
                            ),
                            excludeSemantics: true,
                            child: Slider(
                              value: fSliderValue,
                              min: 0,
                              max: 120,
                              divisions: 20,
                              label: fSliderValue.ceil().toString(),
                              onChanged: fSliderChanged,
                            ),
                          ),
                        ),
                        ExcludeSemantics(
                          child: ContainerTextField(
                            fText: fSliderValue.ceil().toString(),
                            fTextSize: 14,
                            fContainerColor:
                                context.colors.tertiary.withOpacity(0.2),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

/*
This class places a text widget in a bordered container widget
@author: Ugochukwu Umeh
*/
class ContainerTextField extends StatelessWidget {
  ///The color of the container
  final Color? fContainerColor;

  ///The text
  final String fText;

  ///The text size
  final double fTextSize;

  ///The weight of the text
  final FontWeight? fFontWeight;

  /// The padding of the container
  final EdgeInsetsGeometry? fPadding;

  /// The margin of the container
  final EdgeInsetsGeometry? fMargin;

  /// The max lines of the text
  final int? fMaxLines;

  /// The overflow of the text
  final TextOverflow? fTextOverflow;

  /// The color
  final Color? fTextColor;

  const ContainerTextField({
    super.key,
    required this.fText,
    this.fFontWeight,
    required this.fTextSize,
    this.fContainerColor,
    this.fPadding,
    this.fMargin,
    this.fMaxLines,
    this.fTextOverflow,
    this.fTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: fMargin,
      padding: fPadding ??
          const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: fContainerColor,
        border: Border.all(
          color: context.colors.tertiary.withOpacity(0.5),
        ),
      ),
      child: Text(
        fText,
        maxLines: fMaxLines,
        overflow: fTextOverflow,
        style: TextStyle(
          fontSize: fTextSize,
          fontWeight: fFontWeight,
          color: fTextColor ?? context.appColors.textColor,
        ),
      ),
    );
  }
}
