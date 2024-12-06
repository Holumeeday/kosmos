import 'package:flutter/material.dart';

/// App colors
class AppColors extends ThemeExtension<AppColors> {
  final Color? textColor;
  final Color? darkGreyColor;
  final Color? greyShade85Color;
  final Color? modalDividerColor;
  final Color? durationModalTextColor;
  final Color? starColor;
  final Color? textBoxColor;
  final Color? venueDurationGreyColor;
  final Color? redColor;
  final Color? greenColor;
  final Color? playmatesColor;
  final Color? teamsColor;
  final Color? storesColor;
  final Color? venuesColor;
  final Color? textBgOnImageCard;
  final Color? combatSports;
  final Color? footAndHandSports;
  final Color? netSports;
  final Color? racketSports;
  final Color? sticksAndBatSports;
  final Color? winterAndWaterSports;
  final Color? games;
  final Color? mentalAndSpiritual;
  final Color? racingAndAthleticsSports;
  final Color? fitness;
  final Color? sectionNotFilled;
  final Color? sectionAlmostFilled;
  final Color? sectionFilled;
  final Color? classesActivity;
  final Color? competitionActivity;
  final Color? eventsActivity;
  final Color? exerciseActivity;
  final Color? gamesActivity;
  final Color? outdoorTripActivity;
  final Color? programmeActivity;
  final Color? runningActivity;
  final Color? seminarActivity;
  final Color? trainingActivity;
  final Color? walkingActivity;
  final Color? webinarActivity;
  final Color? workshopActivity;
  final Color? othersActivity;
  final Color? bronzePlan;
  final Color? silverPlan;
  final Color? goldPlan;
  final Color? diamondPlan;
  final Color? sendMessageColor;
  final Color? ownChatBubbleColor;
  final Color? circleAvatarColor;
  final Color? fDisableField;
  final Color? fActivityJoined;

  final Color? fBadgeReceived;
  final Color? fAccepted;
  final Color? fDeclined;
  final Color? fPaid;
  final Color? fUnpaid;
  final Color? fWithdrawn;
  final Color? fAwaiting;
  final Color? fPresent;
  final Color? fMissed;
  final Color? fAcceptDialogColor;
  final Color? fPresentTextColor;
  final Color? fUpcomingActivityStatusColor;
  final Color? fRedActivityStatusColor;
  final Color? stopAssemblingTeamColor;

  final Color? fUnlockedBronze;
  final Color? fUnlockedSilver;
  final Color? fUnlockedDiamond;
  final Color? fUnlockedGold;

  final Color? fAllEarningCardColor;
  final Color? fPlaymateEarningCardColor;
  final Color? fVenueEarningCardColor;
  final Color? fStoreEarningCardColor;
  final Color? fTeamsEarningCardColor;
  final Color? fBronzeFreeColor;

  final Color? fDividerColor;
  final Color? shimmerColor;
  final Color? unselectedStepperColor;

  final Color? fHyperLinkColor;

  AppColors({
    required this.textColor,
    required this.darkGreyColor,
    required this.modalDividerColor,
    required this.durationModalTextColor,
    required this.starColor,
    required this.circleAvatarColor,
    required this.greyShade85Color,
    required this.textBoxColor,
    required this.venueDurationGreyColor,
    required this.redColor,
    required this.greenColor,
    required this.playmatesColor,
    required this.teamsColor,
    required this.storesColor,
    required this.venuesColor,
    required this.textBgOnImageCard,
    required this.combatSports,
    required this.footAndHandSports,
    required this.netSports,
    required this.racketSports,
    required this.sticksAndBatSports,
    required this.winterAndWaterSports,
    required this.games,
    required this.mentalAndSpiritual,
    required this.racingAndAthleticsSports,
    required this.fitness,
    required this.sectionNotFilled,
    required this.sectionFilled,
    required this.sectionAlmostFilled,
    required this.classesActivity,
    required this.competitionActivity,
    required this.eventsActivity,
    required this.exerciseActivity,
    required this.gamesActivity,
    required this.outdoorTripActivity,
    required this.programmeActivity,
    required this.runningActivity,
    required this.seminarActivity,
    required this.trainingActivity,
    required this.walkingActivity,
    required this.webinarActivity,
    required this.workshopActivity,
    required this.othersActivity,
    required this.bronzePlan,
    required this.silverPlan,
    required this.goldPlan,
    required this.diamondPlan,
    required this.sendMessageColor,
    required this.fDisableField,
    required this.fBadgeReceived,
    required this.fActivityJoined,
    required this.ownChatBubbleColor,
    required this.fAccepted,
    required this.fDeclined,
    required this.fPaid,
    required this.fUnpaid,
    required this.fWithdrawn,
    required this.fAwaiting,
    required this.fPresent,
    required this.fMissed,
    required this.fAcceptDialogColor,
    required this.fPresentTextColor,
    required this.fUpcomingActivityStatusColor,
    required this.fRedActivityStatusColor,
    required this.stopAssemblingTeamColor,
    required this.fUnlockedBronze,
    required this.fUnlockedDiamond,
    required this.fUnlockedGold,
    required this.fUnlockedSilver,
    required this.fAllEarningCardColor,
    required this.fPlaymateEarningCardColor,
    required this.fVenueEarningCardColor,
    required this.fStoreEarningCardColor,
    required this.fTeamsEarningCardColor,
    required this.fBronzeFreeColor,
    required this.fDividerColor,
    required this.shimmerColor,
    required this.unselectedStepperColor,
    required this.fHyperLinkColor,
  });

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    //returns the app Color
    return AppColors(
      textColor: Color.lerp(textColor, other.textColor, t),
      darkGreyColor: Color.lerp(darkGreyColor, other.darkGreyColor, t),
      greyShade85Color: Color.lerp(greyShade85Color, other.greyShade85Color, t),
      modalDividerColor:
          Color.lerp(modalDividerColor, other.modalDividerColor, t),
      durationModalTextColor:
          Color.lerp(durationModalTextColor, other.durationModalTextColor, t),
      starColor: Color.lerp(starColor, other.starColor, t),
      textBoxColor: Color.lerp(textBoxColor, other.textBoxColor, t),
      venueDurationGreyColor:
          Color.lerp(venueDurationGreyColor, other.venueDurationGreyColor, t),
      redColor: Color.lerp(redColor, other.redColor, t),
      greenColor: Color.lerp(greenColor, other.greenColor, t),
      playmatesColor: Color.lerp(playmatesColor, other.playmatesColor, t),
      teamsColor: Color.lerp(teamsColor, other.teamsColor, t),
      storesColor: Color.lerp(storesColor, other.storesColor, t),
      venuesColor: Color.lerp(venuesColor, other.venuesColor, t),
      textBgOnImageCard:
          Color.lerp(textBgOnImageCard, other.textBgOnImageCard, t),
      combatSports: Color.lerp(combatSports, other.combatSports, t),
      footAndHandSports:
          Color.lerp(footAndHandSports, other.footAndHandSports, t),
      netSports: Color.lerp(netSports, other.netSports, t),
      racketSports: Color.lerp(racketSports, other.racketSports, t),
      sticksAndBatSports:
          Color.lerp(sticksAndBatSports, other.sticksAndBatSports, t),
      winterAndWaterSports:
          Color.lerp(winterAndWaterSports, other.winterAndWaterSports, t),
      games: Color.lerp(games, other.games, t),
      mentalAndSpiritual:
          Color.lerp(mentalAndSpiritual, other.mentalAndSpiritual, t),
      racingAndAthleticsSports: Color.lerp(
          racingAndAthleticsSports, other.racingAndAthleticsSports, t),
      fitness: Color.lerp(fitness, other.fitness, t),
      sectionFilled: Color.lerp(sectionFilled, other.sectionFilled, t),
      sectionAlmostFilled:
          Color.lerp(sectionAlmostFilled, other.sectionAlmostFilled, t),
      sectionNotFilled: Color.lerp(sectionNotFilled, other.sectionNotFilled, t),
      classesActivity: Color.lerp(classesActivity, other.classesActivity, t),
      competitionActivity:
          Color.lerp(competitionActivity, other.competitionActivity, t),
      eventsActivity: Color.lerp(eventsActivity, other.eventsActivity, t),
      exerciseActivity: Color.lerp(exerciseActivity, other.exerciseActivity, t),
      gamesActivity: Color.lerp(gamesActivity, other.gamesActivity, t),
      outdoorTripActivity:
          Color.lerp(outdoorTripActivity, other.outdoorTripActivity, t),
      programmeActivity:
          Color.lerp(programmeActivity, other.programmeActivity, t),
      runningActivity: Color.lerp(runningActivity, other.runningActivity, t),
      seminarActivity: Color.lerp(seminarActivity, other.seminarActivity, t),
      trainingActivity: Color.lerp(trainingActivity, other.trainingActivity, t),
      walkingActivity: Color.lerp(walkingActivity, other.walkingActivity, t),
      webinarActivity: Color.lerp(webinarActivity, other.webinarActivity, t),
      workshopActivity: Color.lerp(workshopActivity, other.workshopActivity, t),
      othersActivity: Color.lerp(othersActivity, other.othersActivity, t),
      bronzePlan: Color.lerp(bronzePlan, other.bronzePlan, t),
      silverPlan: Color.lerp(silverPlan, other.silverPlan, t),
      goldPlan: Color.lerp(goldPlan, other.goldPlan, t),
      diamondPlan: Color.lerp(diamondPlan, other.diamondPlan, t),
      sendMessageColor: Color.lerp(sendMessageColor, other.sendMessageColor, t),
      ownChatBubbleColor:
          Color.lerp(ownChatBubbleColor, other.ownChatBubbleColor, t),
      fDisableField: Color.lerp(fDisableField, other.fDisableField, t),
      fBadgeReceived: Color.lerp(fBadgeReceived, other.fBadgeReceived, t),
      fActivityJoined: Color.lerp(fActivityJoined, other.fActivityJoined, t),
      circleAvatarColor:
          Color.lerp(circleAvatarColor, other.circleAvatarColor, t),
      fAccepted: Color.lerp(fAccepted, other.fAccepted, t),
      fDeclined: Color.lerp(fDeclined, other.fDeclined, t),
      fPaid: Color.lerp(fPaid, other.fPaid, t),
      fUnpaid: Color.lerp(fUnpaid, other.fUnpaid, t),
      fWithdrawn: Color.lerp(fWithdrawn, other.fWithdrawn, t),
      fAwaiting: Color.lerp(fAwaiting, other.fAwaiting, t),
      fPresent: Color.lerp(fPresent, other.fPresent, t),
      fMissed: Color.lerp(fMissed, other.fMissed, t),
      fAcceptDialogColor:
          Color.lerp(fAcceptDialogColor, other.fAcceptDialogColor, t),
      fPresentTextColor:
          Color.lerp(fPresentTextColor, other.fPresentTextColor, t),
      fUpcomingActivityStatusColor: Color.lerp(
          fUpcomingActivityStatusColor, other.fUpcomingActivityStatusColor, t),
      fRedActivityStatusColor:
          Color.lerp(fRedActivityStatusColor, other.fRedActivityStatusColor, t),
      stopAssemblingTeamColor:
          Color.lerp(stopAssemblingTeamColor, other.stopAssemblingTeamColor, t),
      fUnlockedBronze: Color.lerp(fUnlockedBronze, other.fUnlockedBronze, t),
      fUnlockedDiamond: Color.lerp(fUnlockedDiamond, other.fUnlockedDiamond, t),
      fUnlockedGold: Color.lerp(fUnlockedGold, other.fUnlockedGold, t),
      fUnlockedSilver: Color.lerp(fUnlockedSilver, other.fUnlockedSilver, t),
      fAllEarningCardColor:
          Color.lerp(fAllEarningCardColor, other.fAllEarningCardColor, t),
      fPlaymateEarningCardColor: Color.lerp(
          fPlaymateEarningCardColor, other.fPlaymateEarningCardColor, t),
      fStoreEarningCardColor:
          Color.lerp(fStoreEarningCardColor, other.fStoreEarningCardColor, t),
      fTeamsEarningCardColor:
          Color.lerp(fTeamsEarningCardColor, other.fTeamsEarningCardColor, t),
      fVenueEarningCardColor:
          Color.lerp(fVenueEarningCardColor, other.fVenueEarningCardColor, t),
      fBronzeFreeColor: Color.lerp(fBronzeFreeColor, other.fBronzeFreeColor, t),
      fDividerColor: Color.lerp(fDividerColor, other.fDividerColor, t),
      shimmerColor: Color.lerp(shimmerColor, other.shimmerColor, t),
      unselectedStepperColor:
          Color.lerp(unselectedStepperColor, other.unselectedStepperColor, t),
      fHyperLinkColor:
      Color.lerp(fHyperLinkColor, other.fHyperLinkColor, t),
    );

  }

  @override
  AppColors copyWith({
    Color? textColor,
    Color? darkGreyColor,
    Color? greyShade85Color,
    Color? modalDividerColor,
    Color? durationModalTextColor,
    Color? starColor,
    Color? textBoxColor,
    Color? venueDurationGreyColor,
    Color? redColor,
    Color? greenColor,
    Color? playmatesColor,
    Color? teamsColor,
    Color? storesColor,
    Color? venuesColor,
    Color? textBgOnImageCard,
    Color? combatSports,
    Color? footAndHandSports,
    Color? netSports,
    Color? racketSports,
    Color? sticksAndBatSports,
    Color? winterAndWaterSports,
    Color? games,
    Color? mentalAndSpiritual,
    Color? racingAndAthleticsSports,
    Color? fitness,
    Color? sectionFilled,
    Color? sectionNotFilled,
    Color? sectionAlmostFilled,
    Color? classesActivity,
    Color? competitionActivity,
    Color? eventsActivity,
    Color? exerciseActivity,
    Color? gamesActivity,
    Color? outdoorTripActivity,
    Color? programmeActivity,
    Color? runningActivity,
    Color? seminarActivity,
    Color? trainingActivity,
    Color? walkingActivity,
    Color? webinarActivity,
    Color? workshopActivity,
    Color? othersActivity,
    Color? bronzePlan,
    Color? silverPlan,
    Color? goldPlan,
    Color? diamondPlan,
    Color? sendMessageColor,
    Color? ownChatBubbleColor,
    Color? fDisableField,
    Color? fBadgeReceived,
    Color? fActivityJoined,
    Color? circleAvatarColor,
    Color? fAccepted,
    Color? fDeclined,
    Color? fPaid,
    Color? fUnpaid,
    Color? fWithdrawn,
    Color? fAwaiting,
    Color? fPresent,
    Color? fMissed,
    Color? fAcceptDialogColor,
    Color? fPresentTextColor,
    Color? fUpcomingActivityStatusColor,
    Color? fRedActivityStatusColor,
    Color? stopAssemblingTeamColor,
    Color? fUnlockedBronze,
    Color? fUnlockedDiamond,
    Color? fUnlockedSilver,
    Color? fUnlockedGold,
    Color? fAllEarningCardColor,
    Color? fPlaymateEarningCardColor,
    Color? fVenueEarningCardColor,
    Color? fStoreEarningCardColor,
    Color? fTeamsEarningCardColor,
    Color? fBronzeFreeColor,
    Color? fDividerColor,
    Color? shimmerColor,
    Color? unselectedStepperColor,
    Color? fHyperLinkColor,
  }) =>
      AppColors(
        textColor: textColor ?? this.textColor,
        darkGreyColor: darkGreyColor ?? this.darkGreyColor,
        greyShade85Color: greyShade85Color ?? this.greyShade85Color,
        modalDividerColor: modalDividerColor ?? this.modalDividerColor,
        durationModalTextColor:
            durationModalTextColor ?? this.durationModalTextColor,
        starColor: starColor ?? this.starColor,
        textBoxColor: textBoxColor ?? this.textBoxColor,
        venueDurationGreyColor:
            venueDurationGreyColor ?? this.venueDurationGreyColor,
        redColor: redColor ?? this.redColor,
        greenColor: greenColor ?? this.greenColor,
        playmatesColor: playmatesColor ?? this.playmatesColor,
        teamsColor: teamsColor ?? this.teamsColor,
        storesColor: storesColor ?? this.storesColor,
        venuesColor: venuesColor ?? this.venuesColor,
        textBgOnImageCard: textBgOnImageCard ?? this.textBgOnImageCard,
        combatSports: combatSports ?? this.combatSports,
        footAndHandSports: footAndHandSports ?? this.footAndHandSports,
        netSports: netSports ?? this.netSports,
        racketSports: racketSports ?? this.racketSports,
        sticksAndBatSports: sticksAndBatSports ?? this.sticksAndBatSports,
        winterAndWaterSports: winterAndWaterSports ?? this.winterAndWaterSports,
        games: games ?? this.games,
        mentalAndSpiritual: mentalAndSpiritual ?? this.mentalAndSpiritual,
        racingAndAthleticsSports:
            racingAndAthleticsSports ?? this.racingAndAthleticsSports,
        fitness: fitness ?? this.fitness,
        sectionFilled: sectionFilled ?? this.sectionFilled,
        sectionNotFilled: sectionNotFilled ?? this.sectionNotFilled,
        sectionAlmostFilled: sectionAlmostFilled ?? this.sectionAlmostFilled,
        classesActivity: classesActivity ?? this.classesActivity,
        competitionActivity: competitionActivity ?? this.competitionActivity,
        eventsActivity: eventsActivity ?? this.eventsActivity,
        exerciseActivity: exerciseActivity ?? this.exerciseActivity,
        gamesActivity: gamesActivity ?? this.gamesActivity,
        outdoorTripActivity: outdoorTripActivity ?? this.outdoorTripActivity,
        programmeActivity: programmeActivity ?? this.programmeActivity,
        runningActivity: runningActivity ?? this.runningActivity,
        seminarActivity: seminarActivity ?? this.seminarActivity,
        trainingActivity: trainingActivity ?? this.trainingActivity,
        walkingActivity: walkingActivity ?? this.walkingActivity,
        webinarActivity: webinarActivity ?? this.webinarActivity,
        workshopActivity: workshopActivity ?? this.workshopActivity,
        othersActivity: othersActivity ?? this.othersActivity,
        bronzePlan: bronzePlan ?? this.bronzePlan,
        silverPlan: silverPlan ?? this.silverPlan,
        goldPlan: goldPlan ?? this.goldPlan,
        diamondPlan: diamondPlan ?? this.diamondPlan,
        sendMessageColor: sendMessageColor ?? this.sendMessageColor,
        ownChatBubbleColor: ownChatBubbleColor ?? this.ownChatBubbleColor,
        fDisableField: fDisableField ?? this.fDisableField,
        fBadgeReceived: fBadgeReceived ?? this.fBadgeReceived,
        fActivityJoined: fActivityJoined ?? this.fActivityJoined,
        circleAvatarColor: circleAvatarColor ?? this.circleAvatarColor,
        fAccepted: fAccepted ?? this.fAccepted,
        fDeclined: fDeclined ?? this.fDeclined,
        fPaid: fPaid ?? this.fPaid,
        fUnpaid: fUnpaid ?? this.fUnpaid,
        fWithdrawn: fWithdrawn ?? this.fWithdrawn,
        fAwaiting: fAwaiting ?? this.fAwaiting,
        fPresent: fPresent ?? this.fPresent,
        fMissed: fMissed ?? this.fMissed,
        fAcceptDialogColor: fAcceptDialogColor ?? this.fAcceptDialogColor,
        fPresentTextColor: fPresentTextColor ?? this.fPresentTextColor,
        fUpcomingActivityStatusColor:
            fUpcomingActivityStatusColor ?? this.fUpcomingActivityStatusColor,
        fRedActivityStatusColor:
            fRedActivityStatusColor ?? this.fRedActivityStatusColor,
        stopAssemblingTeamColor:
            stopAssemblingTeamColor ?? this.stopAssemblingTeamColor,
        fUnlockedBronze: fUnlockedBronze ?? this.fUnlockedBronze,
        fUnlockedDiamond: fUnlockedDiamond ?? this.fUnlockedDiamond,
        fUnlockedGold: fUnlockedGold ?? this.fUnlockedGold,
        fUnlockedSilver: fUnlockedSilver ?? this.fUnlockedSilver,
        fAllEarningCardColor: fAllEarningCardColor ?? this.fAllEarningCardColor,
        fPlaymateEarningCardColor:
            fPlaymateEarningCardColor ?? this.fPlaymateEarningCardColor,
        fStoreEarningCardColor:
            fStoreEarningCardColor ?? this.fStoreEarningCardColor,
        fTeamsEarningCardColor:
            fTeamsEarningCardColor ?? this.fTeamsEarningCardColor,
        fVenueEarningCardColor:
            fVenueEarningCardColor ?? this.fVenueEarningCardColor,
        fBronzeFreeColor: fBronzeFreeColor ?? this.fBronzeFreeColor,
        fDividerColor: fDividerColor ?? this.fDividerColor,
        shimmerColor: shimmerColor ?? this.shimmerColor,
        unselectedStepperColor:
            unselectedStepperColor ?? this.unselectedStepperColor,
        fHyperLinkColor: fHyperLinkColor ?? this.fHyperLinkColor,
      );
}

/// This class defines various colors used in the app
class AppColor {
  static const fPrimaryGradient = [
    Color(0xFF8A2387),
    Color(0xFFE94057),
    AppColor.fPrimaryColor,
  ];
  static const Color fPrimaryColor = Color(0xFFF27121);
  static const Color fTextColor = Color(0xFF434343);
  static const Color fTextBoxColor = Color(0xFFD6D6D6);
  static const Color fDarkGrey = Color(0xFF919191);
  static const Color fGreyShade85Color = Color(0xFF858585);
  static const Color fDurationModalTextColor = Color(0xFF333333);
  static const Color fStarColor = Color(0xFFDFB300);
  static const Color fModalDividerColor = Color(0xFFE5E5E5);
  static const Color fVenueDurationGrey = Color(0xFF999999);
  static const Color fRedColor = Color(0xFFCB0606);
  static const Color fGreenColor = Color(0xFF008000);
  static const Color fPlaymatesColor = Color(0xFF3D2C8D);
  static const Color fTeamsColor = Color(0xFF0093AB);
  static const Color fStoresColor = Color(0xFFAD1C62);
  static const Color fVenuesColor = Color(0xFF1F7102);
  static const Color fCombatSportsColor = Color(0xFF990707);
  static const Color fFootAndHandSports = Color(0xFFDB6B00);
  static const Color fNetSports = Color(0xFF8E659E);
  static const Color fRacketSports = Color(0xFF92278F);
  static const Color fSticksAndBatSports = Color(0xFFA38466);
  static const Color fWinterAndWaterSports = Color(0xFF3CBBE8);
  static const Color fGames = Color(0xFF645CBB);
  static const Color fMentalAndSpiritual = Color(0xFFD3756B);
  static const Color fRacingAndAthletics = Color(0xFF77B255);
  static const Color fFitness = Color(0xFF5146C7);
  static const Color fSectionNotFilled = Color(0xFFB2B2B2);
  static const Color fSectionAlmostFilled = Color(0xFFF4BF03);
  static const Color fSectionFilled = Color(0xFF08D308);
  static const Color fClassesActivity = Color(0xFF151583);
  static const Color fCompetitionActivity = Color(0xFF097835);
  static const Color fEventsActivity = Color(0xFFA91079);
  static const Color fExerciseActivity = Color(0xFFFC5C9C);
  static const Color fGamesActivity = Color(0xFF8A39E1);
  static const Color fOutdoorTripActivity = Color(0xFF810955);
  static const Color fProgrammeActivity = Color(0xFF0093AB);
  static const Color fRunningActivity = Color(0xFFE89600);
  static const Color fSeminarActivity = Color(0xFFA91010);
  static const Color fTrainingActivity = Color(0xFF865439);
  static const Color fWalkingActivity = Color(0xFFED1B0D);
  static const Color fWebinarActivity = Color(0xFF962AAC);
  static const Color fWorkshopActivity = Color(0xFF00BE08);
  static const Color fBronzePlan = Color(0xFFA05409);
  static const Color fSilverPlan = Color(0xFF908585);
  static const Color fGoldPlan = Color(0xFFCFA300);
  static const Color fDiamondPlan = Color(0xFF8DB2B6);
  static const Color fSendMessageColor = Color(0xFF0163E0);
  static const Color fOwnChatBubbleColor = Color(0xFFD6ECFC);
  static const Color fCircleAvatarColor = Color(0xFF2A9AEB);
  static const Color fDisableField = Color(0xFFC0C0C0);
  static const Color fBadgeReceived = Color(0xFFA084CF);
  static const Color fActivityJoined = Color(0xFF54BAB9);
  static const Color fAccepted = Color(0xFF404AA1);
  static const Color fDeclined = Color(0xFFFF616D);
  static const Color fPaid = Color(0xFF00917C);
  static const Color fUnpaid = Color(0xFFD29D2B);
  static const Color fWithdrawn = Color(0xFFB22727);
  static const Color fAwaiting = Color(0xFFEC994B);
  static const Color fPresent = Color(0xFF5A0091);
  static const Color fMissed = Color(0xFFB22727);
  static const Color fAcceptDialogColor = Color(0xFF6BCB77);
  static const Color fPresentTextColor = Color(0xFF0EB10E);
  static const Color fUpcomingActivityStatusColor = Color(0xFFEAA425);
  static const Color fRedActivityStatusColor = Color(0xFFC62121);
  static const Color fStopAssemblingTeamColor = Color(0xFFD31212);
  static const Color fUnlockedBronze = Color(0xff8C4539);
  static const Color fUnlockedGold = Color(0xffFFBD52);
  static const Color fUnlockedDiamond = Color(0xff0F7AF1);
  static const Color fUnlockedSilver = Color(0xff909090);
  static const Color fAllEarningCardColor = Color(0xff2A9AEB);
  static const Color fPlaymateEarningCardColor = Color(0xff533CC2);
  static const Color fVenueEarningCardColor = Color(0xff3D9F1A);
  static const Color fStoreEarningCardColor = Color(0xffE92383);
  static const Color fTeamsEarningCardColor = Color(0xff14ADC6);
  static const Color fBronzeFreeColor = Color(0xFF03A303);
  static const Color fDividerColor = Color(0xFFD5D5D5);
  static const Color fShimmerColor = Color(0xFFC2C2C2);
  static const Color fUnselectedStepperColor = Color(0xFFE7E7E7);
  static const Color fHyperLinkColor = Color(0xFF5085F7);
}
