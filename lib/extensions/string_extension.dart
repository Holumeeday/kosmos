import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// Common string operations
///
/// @author: Godwin Mathias
extension StringExtension on String {
  /// Checks if its an image or video
  bool get isVideo => lookupMimeType(this)?.contains('video') ?? false;

  /// Checks if its an image or video
  bool get isImage => lookupMimeType(this)?.contains('image') ?? false;

  /// To capitalize the first letter of the word/sentence
  String get capitalizeFirst =>
      this[0].toUpperCase() + substring(1).toLowerCase();

  /// To capitalize the first letter of each word in a sentence
  String get capitalizeFirstLetter =>
      split(' ').map((e) => e.capitalizeFirst).join(' ');

  /// To get the interest group color
  Color getInterestGroupColor(AppColors appColors) {
    switch (this) {
      case 'combat':
        return appColors.combatSports!;
      case 'net':
        return appColors.netSports!;
      case 'footHand':
        return appColors.footAndHandSports!;
      case 'sticksBat':
        return appColors.sticksAndBatSports!;
      case 'racket':
        return appColors.racketSports!;
      case 'winterWater':
        return appColors.winterAndWaterSports!;
      case 'racingAthletics':
        return appColors.racingAndAthleticsSports!;
      case 'games':
        return appColors.games!;
      case 'mentalSpiritual':
        return appColors.mentalAndSpiritual!;
      case 'fitness':
        return appColors.fitness!;
      default:
        return appColors.darkGreyColor!;
    }
  }

  /// The activity type color
  Color getActivityTypeColor(AppColors appColors) {
    switch (this) {
      case 'Classes':
        return appColors.classesActivity!;
      case 'Competition':
        return appColors.competitionActivity!;
      case 'Events':
        return appColors.eventsActivity!;
      case 'Exercise':
        return appColors.exerciseActivity!;
      case 'Games':
        return appColors.gamesActivity!;
      case 'OutdoorTrip':
        return appColors.outdoorTripActivity!;
      case 'Programme':
        return appColors.programmeActivity!;
      case 'Running':
        return appColors.runningActivity!;
      case 'Seminar':
        return appColors.seminarActivity!;
      case 'Training':
        return appColors.trainingActivity!;
      case 'Walking':
        return appColors.walkingActivity!;
      case 'Webinar':
        return appColors.webinarActivity!;
      case 'Workshop':
        return appColors.workshopActivity!;
      default:
        return appColors.othersActivity!;
    }
  }

  /// Gets the subscription plan color
  Color getSubscriptionPlanColor(AppColors appColors) {
    switch (this) {
      case 'diamond':
        return appColors.diamondPlan!;
      case 'silver':
        return appColors.silverPlan!;
      case 'gold':
        return appColors.goldPlan!;
      default:
        return appColors.bronzePlan!;
    }
  }
}
