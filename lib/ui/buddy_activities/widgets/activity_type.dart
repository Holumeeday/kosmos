import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/enums/activity_type_enum.dart';
import 'package:playkosmos_v3/utils/theme/app_colors.dart';

class ActivityType extends StatelessWidget {
  final String typeString; // Activity type as a string

  const ActivityType({super.key, required this.typeString});

  /// Converts the string to an `ActivityTypeEnum`, returns null if no match
  ActivityTypeEnum? _getTypeEnum(String type) {
    try {
      return ActivityTypeEnum.values.firstWhere(
        (e) => e.name.toLowerCase() == type.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeEnum = _getTypeEnum(typeString);

    // Handle invalid type
    if (typeEnum == null) {
      return Row(
        children: [
          const Icon(Icons.error, color: Colors.red),
          const HSpace(8),
          Text(
            "Invalid Activity Type",
            style: context.textTheme.labelLarge!
                .copyWith(color: context.colors.error),
          ),
        ],
      );
    }

    // Define properties for valid `ActivityTypeEnum`
    String iconPath = '';
    String label = '';
    Color? color = context.appColors.darkGreyColor;

    switch (typeEnum) {
      case ActivityTypeEnum.classes:
        iconPath = Assets.svgs.activityTypes.classes.path;
        label = context.loc.setActivityTypeText(typeEnum.name);
        color = AppColor.fClassesActivity;
        break;
      case ActivityTypeEnum.running:
        iconPath = Assets.svgs.activityTypes.running.path;
        label = context.loc.setActivityTypeText(typeEnum.name);
        color = AppColor.fRunningActivity;
        break;
      case ActivityTypeEnum.competition:
        iconPath = Assets.svgs.activityTypes.competition.path;
        label = context.loc.setActivityTypeText(typeEnum.name);
        color = AppColor.fCompetitionActivity;
        break;
      case ActivityTypeEnum.seminar:
        iconPath = Assets.svgs.activityTypes.seminar.path;
        label = context.loc.setActivityTypeText(typeEnum.name);
        color = AppColor.fSeminarActivity;
        break;
      case ActivityTypeEnum.events:
        iconPath = Assets.svgs.activityTypes.events.path;
        label = context.loc.setActivityTypeText(typeEnum.name);
        color = AppColor.fEventsActivity;
        break;
      case ActivityTypeEnum.training:
        iconPath = Assets.svgs.activityTypes.training.path;
        label = context.loc.setActivityTypeText(typeEnum.name);
        color = AppColor.fTrainingActivity;
        break;
      case ActivityTypeEnum.exercise:
        iconPath = Assets.svgs.activityTypes.exercise.path;
        label = context.loc.setActivityTypeText(typeEnum.name);
        color = AppColor.fExerciseActivity;
        break;
      case ActivityTypeEnum.walking:
        iconPath = Assets.svgs.activityTypes.walking.path;
        label = context.loc.setActivityTypeText(typeEnum.name);
        color = AppColor.fWalkingActivity;
        break;
      case ActivityTypeEnum.games:
        iconPath = Assets.svgs.activityTypes.games.path;
        label = context.loc.setActivityTypeText(typeEnum.name);
        color = AppColor.fGamesActivity;
        break;
      case ActivityTypeEnum.webinar:
        iconPath = Assets.svgs.activityTypes.webinar.path;
        label = context.loc.setActivityTypeText(typeEnum.name);
        color = AppColor.fWebinarActivity;
        break;
      case ActivityTypeEnum.outdoorTrip:
        iconPath = Assets.svgs.activityTypes.outdoorTrip.path;
        label = context.loc.setActivityTypeText(typeEnum.name);
        color = AppColor.fOutdoorTripActivity;
        break;
      case ActivityTypeEnum.workshop:
        iconPath = Assets.svgs.activityTypes.workshop.path;
        label = context.loc.setActivityTypeText(typeEnum.name);
        color = AppColor.fWorkshopActivity;
        break;
      case ActivityTypeEnum.programme:
        iconPath = Assets.svgs.activityTypes.programme.path;
        label = context.loc.setActivityTypeText(typeEnum.name);
        color = AppColor.fProgrammeActivity;
        break;
      case ActivityTypeEnum.others:
        iconPath = Assets.svgs.activityTypes.others.path;
        label = context.loc.setActivityTypeText(typeEnum.name);
        color = context.appColors.othersActivity;
        break;
    }

    // Render activity type
    return Row(
      children: [
        SvgPicture.asset(iconPath, height: 24, width: 24, colorFilter: ColorFilter.mode(color!, BlendMode.srcIn) ),
        const HSpace(8),
        Text(
          label,
          style: context.textTheme.labelLarge!.copyWith(color: color),
        ),
      ],
    );
  }
}
