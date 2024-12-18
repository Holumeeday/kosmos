import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playkosmos_v3/assets_gen/fonts.gen.dart';
import 'package:playkosmos_v3/utils/theme/app_colors.dart';
import 'package:playkosmos_v3/utils/theme/app_text_styles.dart';

/// The text button theme
TextButtonThemeData _kTextButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    foregroundColor: AppColor.fPrimaryColor,
  ),
);

///To get the color based on material state
Color _kGetScrollbarColor(Set<WidgetState> states) {
  const Set<WidgetState> interactiveStates = <WidgetState>{
    WidgetState.pressed,
    WidgetState.hovered,
    WidgetState.focused,
    WidgetState.dragged,
  };
  if (states.any((state) => interactiveStates.contains(state))) {
    return const Color(0xff0F82D6);
  }
  return const Color(0xFF909090);
}

/// The text input decoration
InputDecorationTheme _kFormTextInputDecoration = const InputDecorationTheme(
  hintStyle: TextStyle(
    color: Color(0xFF919191),
  ),
  labelStyle: TextStyle(
    color: Color(0xFF919191),
  ),
  border: UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColor.fTextBoxColor,
    ),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColor.fTextBoxColor,
    ),
  ),
  disabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColor.fTextBoxColor,
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColor.fTextBoxColor,
    ),
  ),
  errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      width: 1,
      color: Colors.red,
    ),
  ),
  focusedErrorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      width: 1,
      color: Colors.red,
    ),
  ),
  errorMaxLines: 5,
);

/// The expansion theme
ExpansionTileThemeData _kExpansionTheme = const ExpansionTileThemeData(
  shape: RoundedRectangleBorder(),
  collapsedShape: RoundedRectangleBorder(),
);

/// The radio button theme
RadioThemeData _kRadioTheme = RadioThemeData(
  fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
    if (states.contains(WidgetState.selected)) {
      return AppColor.fPrimaryColor;
    }
    return Colors.grey;
  }),
);

/// The switch theme
SwitchThemeData _kSwitchTheme = SwitchThemeData(
  trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
  thumbColor: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return AppColor.fPrimaryColor;
    }
    return Colors.white;
  }),
  trackColor: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return AppColor.fPrimaryColor.withOpacity(0.3);
    }
    return const Color(0xFF909090).withOpacity(0.3);
  }),
);

/// The background color for pickers in dark mode
const Color _kDarkThemePickerBg = Color(0xFF111D27);

/// The background color for pickers in light mode
const Color _kLightThemePickerBg = Color(0xFFE4F0FA);

/// The day/year foreground color for dark theme date picker
WidgetStateProperty<Color> _kDarkThemeDateFgColor =
    WidgetStateColor.resolveWith(
  (states) => states.contains(WidgetState.disabled)
      ? const Color(0xFF616A72)
      : Colors.white,
);

/// The day/year foreground color for light theme date picker
WidgetStateProperty<Color> _kLightThemeDateFgColor =
    WidgetStateColor.resolveWith(
  (states) => states.contains(WidgetState.disabled)
      ? const Color(0xFF949FA8)
      : states.contains(WidgetState.selected)
          ? Colors.white
          : Colors.black,
);

/// The day/year background color for date picker
WidgetStateProperty<Color> _kDateBgColor = WidgetStateColor.resolveWith(
  (states) => states.contains(WidgetState.selected)
      ? AppColor.fPrimaryColor
      : Colors.transparent,
);

///App themes
class MyThemes {
  static final darkTheme = ThemeData(
    useMaterial3: true,
    tabBarTheme: const TabBarTheme(
      tabAlignment: TabAlignment.center,
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFF27121),
      onPrimary: Colors.white,
      secondary: AppColor.fPrimaryColor,
      secondaryContainer: Color(0xFF2E9CEB),
      onSecondary: Colors.white,
      onSecondaryContainer: Color(0xFFFEFEFE),
      error: Color(0xFFFF0000),
      onError: Colors.black,
      surface: Color(0xff121212),
      onSurface: Colors.white,
      tertiary: Color(0xFF909090),
      tertiaryContainer: Color(0xFFEBECEF),
      onTertiary: Colors.black,
    ),
    inputDecorationTheme: _kFormTextInputDecoration.copyWith(
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Color(0xFFFF0000),
        ),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Color(0xFFFF0000),
        ),
      ),
    ),
    expansionTileTheme: _kExpansionTheme,
    radioTheme: _kRadioTheme,
    extensions: <ThemeExtension<dynamic>>[
      AppColors(
        fHyperLinkColor: AppColor.fHyperLinkColor,
        stopAssemblingTeamColor: AppColor.fStopAssemblingTeamColor,
        textColor: Colors.white,
        darkGreyColor: AppColor.fDarkGrey,
        greyShade85Color: AppColor.fGreyShade85Color,
        modalDividerColor: AppColor.fModalDividerColor,
        durationModalTextColor: Colors.white.withOpacity(0.7),
        starColor: AppColor.fStarColor,
        textBoxColor: AppColor.fTextBoxColor,
        venueDurationGreyColor: AppColor.fVenueDurationGrey,
        redColor: AppColor.fRedColor,
        greenColor: AppColor.fGreenColor,
        playmatesColor: const Color(0xFF715ECD),
        teamsColor: AppColor.fTeamsColor,
        storesColor: const Color(0xFFE14590),
        venuesColor: const Color(0xFF3FE504),
        textBgOnImageCard: Colors.black.withOpacity(0.4),
        combatSports: const Color(0xFF990707),
        footAndHandSports: const Color(0xFFDB6B00),
        netSports: const Color(0xFF9779A3),
        racketSports: const Color(0xFF92278F),
        sticksAndBatSports: const Color(0xFFA38466),
        winterAndWaterSports: const Color(0xFF3CBBE8),
        games: const Color(0xFF645CBB),
        mentalAndSpiritual: const Color(0xFFD3756B),
        racingAndAthleticsSports: const Color(0xFF3AC56A),
        fitness: const Color(0xFF5146C7),
        sectionFilled: AppColor.fSectionFilled,
        sectionNotFilled: AppColor.fSectionNotFilled,
        sectionAlmostFilled: AppColor.fSectionAlmostFilled,
        classesActivity: const Color(0xFF3131E8),
        competitionActivity: const Color(0xFF097835),
        eventsActivity: const Color(0xFFA91079),
        exerciseActivity: const Color(0xFFFC5C9C),
        gamesActivity: const Color(0xFF7022C5),
        outdoorTripActivity: const Color(0xFFDA0F8F),
        programmeActivity: const Color(0xFF0093AB),
        runningActivity: const Color(0xFFE89600),
        seminarActivity: const Color(0xFFA91010),
        trainingActivity: const Color(0xFF865439),
        walkingActivity: const Color(0xFFED1B0D),
        webinarActivity: const Color(0xFF962AAC),
        workshopActivity: const Color(0xFF00BE08),
        othersActivity: const Color(0xff0F82D6),
        bronzePlan: AppColor.fBronzePlan,
        silverPlan: AppColor.fSilverPlan,
        goldPlan: AppColor.fGoldPlan,
        diamondPlan: AppColor.fDiamondPlan,
        sendMessageColor: AppColor.fSendMessageColor,
        ownChatBubbleColor: AppColor.fOwnChatBubbleColor,
        fDisableField: AppColor.fDisableField,
        fBadgeReceived: AppColor.fBadgeReceived,
        fActivityJoined: AppColor.fActivityJoined,
        circleAvatarColor: const Color(0xff2A9AEB),
        fAccepted: AppColor.fAccepted,
        fDeclined: AppColor.fDeclined,
        fPaid: AppColor.fPaid,
        fUnpaid: AppColor.fUnpaid,
        fWithdrawn: AppColor.fWithdrawn,
        fAwaiting: AppColor.fAwaiting,
        fPresent: AppColor.fPresent,
        fMissed: AppColor.fMissed,
        fAcceptDialogColor: AppColor.fAcceptDialogColor,
        fPresentTextColor: AppColor.fPresentTextColor,
        fUpcomingActivityStatusColor: AppColor.fUpcomingActivityStatusColor,
        fRedActivityStatusColor: AppColor.fRedActivityStatusColor,
        fUnlockedBronze: AppColor.fUnlockedBronze,
        fUnlockedSilver: AppColor.fUnlockedSilver,
        fUnlockedDiamond: AppColor.fUnlockedDiamond,
        fUnlockedGold: AppColor.fUnlockedGold,
        fAllEarningCardColor: AppColor.fAllEarningCardColor,
        fPlaymateEarningCardColor: AppColor.fPlaymateEarningCardColor,
        fVenueEarningCardColor: AppColor.fVenueEarningCardColor,
        fStoreEarningCardColor: AppColor.fStoreEarningCardColor,
        fTeamsEarningCardColor: AppColor.fTeamsEarningCardColor,
        fBronzeFreeColor: AppColor.fBronzeFreeColor,
        fDividerColor: AppColor.fDividerColor,
        shimmerColor: const Color(0xFF3A3A3A),
        unselectedStepperColor: AppColor.fUnselectedStepperColor,
      ),
      AppTextTheme.dark,
    ],
    scrollbarTheme: ScrollbarThemeData(
      interactive: true,
      radius: const Radius.circular(10),
      thumbColor: WidgetStateProperty.resolveWith(_kGetScrollbarColor),
      thickness: WidgetStateProperty.all(5),
      minThumbLength: 50,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColor.fPrimaryColor,
      selectionColor: AppColor.fPrimaryColor.withOpacity(0.3),
      selectionHandleColor: AppColor.fPrimaryColor,
    ),
    fontFamily: FontFamily.dMSans,
    appBarTheme: AppBarTheme(
      elevation: 2,
      scrolledUnderElevation: 2,
      shadowColor: Colors.white54.withOpacity(0.15),
      iconTheme: const IconThemeData(color: Colors.white),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    switchTheme: _kSwitchTheme,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      headlineLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      headlineSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      labelLarge: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      labelSmall: TextStyle(),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF909090),
      thickness: 0,
      space: 1,
    ),
    sliderTheme: const SliderThemeData(
      thumbColor: AppColor.fPrimaryColor,
      inactiveTrackColor: AppColor.fTextBoxColor,
      activeTrackColor: AppColor.fPrimaryColor,
      inactiveTickMarkColor: Colors.transparent,
      activeTickMarkColor: Colors.transparent,
      valueIndicatorColor: AppColor.fPrimaryColor,
      valueIndicatorTextStyle: TextStyle(
        color: Colors.white,
      ),
    ),
    textButtonTheme: _kTextButtonTheme,
    timePickerTheme: TimePickerThemeData(
      backgroundColor: _kDarkThemePickerBg,
      dayPeriodColor: WidgetStateColor.resolveWith(
        (states) => (states.contains(WidgetState.selected))
            ? AppColor.fPrimaryColor
            : Colors.transparent,
      ),
      dayPeriodTextColor: Colors.white,
      dayPeriodBorderSide: const BorderSide(
        color: AppColor.fPrimaryColor,
      ),
      dialHandColor: AppColor.fPrimaryColor,
      dialTextColor: Colors.white,
      hourMinuteColor: WidgetStateColor.resolveWith(
        (states) => states.contains(WidgetState.focused)
            ? Colors.black
            : states.contains(WidgetState.selected)
                ? AppColor.fPrimaryColor
                : Colors.black,
      ),
      hourMinuteTextColor: Colors.white,
      entryModeIconColor: AppColor.fPrimaryColor,
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: _kDarkThemePickerBg,
      todayForegroundColor: _kDarkThemeDateFgColor,
      dayForegroundColor: _kDarkThemeDateFgColor,
      todayBackgroundColor: _kDateBgColor,
      dayBackgroundColor: _kDateBgColor,
      yearForegroundColor: _kDarkThemeDateFgColor,
      yearBackgroundColor: _kDateBgColor,
    ),
  );

  static final lightTheme = ThemeData(
    useMaterial3: true,
    tabBarTheme: const TabBarTheme(
      tabAlignment: TabAlignment.center,
    ),
    colorScheme: const ColorScheme.light(
      //predefined colour scheme for light with my modification
      primary: Color(0xFFF27121),
      onPrimary: Colors.white,
      secondary: AppColor.fPrimaryColor,
      secondaryContainer: Color(0xFF2E9CEB),
      onSecondary: Colors.white,
      onSecondaryContainer: Color(0xFFFEFEFE),
      error: Color(0xffb00020),
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      tertiary: Color(0xFF909090),
      tertiaryContainer: Color(0xFFEBECEF),
      onTertiary: Colors.black,
    ),
    inputDecorationTheme: _kFormTextInputDecoration,
    expansionTileTheme: _kExpansionTheme,
    radioTheme: _kRadioTheme,
    extensions: <ThemeExtension<dynamic>>[
      AppColors(
        fHyperLinkColor: AppColor.fHyperLinkColor,
        stopAssemblingTeamColor: AppColor.fStopAssemblingTeamColor,
        textColor: AppColor.fTextColor,
        darkGreyColor: AppColor.fDarkGrey,
        greyShade85Color: AppColor.fGreyShade85Color,
        modalDividerColor: AppColor.fModalDividerColor,
        durationModalTextColor: AppColor.fDurationModalTextColor,
        starColor: AppColor.fStarColor,
        textBoxColor: AppColor.fTextBoxColor,
        venueDurationGreyColor: AppColor.fVenueDurationGrey,
        redColor: AppColor.fRedColor,
        greenColor: AppColor.fGreenColor,
        playmatesColor: AppColor.fPlaymatesColor,
        teamsColor: AppColor.fTeamsColor,
        storesColor: AppColor.fStoresColor,
        venuesColor: AppColor.fVenuesColor,
        textBgOnImageCard: Colors.black.withOpacity(0.4),
        combatSports: AppColor.fCombatSportsColor,
        footAndHandSports: AppColor.fFootAndHandSports,
        netSports: AppColor.fNetSports,
        racketSports: AppColor.fRacketSports,
        sticksAndBatSports: AppColor.fSticksAndBatSports,
        winterAndWaterSports: AppColor.fWinterAndWaterSports,
        games: AppColor.fGames,
        mentalAndSpiritual: AppColor.fMentalAndSpiritual,
        racingAndAthleticsSports: AppColor.fRacingAndAthletics,
        fitness: AppColor.fFitness,
        sectionFilled: AppColor.fSectionFilled,
        sectionNotFilled: AppColor.fSectionNotFilled,
        sectionAlmostFilled: AppColor.fSectionAlmostFilled,
        classesActivity: AppColor.fClassesActivity,
        competitionActivity: AppColor.fCompetitionActivity,
        eventsActivity: AppColor.fEventsActivity,
        exerciseActivity: AppColor.fExerciseActivity,
        gamesActivity: AppColor.fGamesActivity,
        outdoorTripActivity: AppColor.fOutdoorTripActivity,
        programmeActivity: AppColor.fProgrammeActivity,
        runningActivity: AppColor.fRunningActivity,
        seminarActivity: AppColor.fSeminarActivity,
        trainingActivity: AppColor.fTrainingActivity,
        walkingActivity: AppColor.fWalkingActivity,
        webinarActivity: AppColor.fWebinarActivity,
        workshopActivity: AppColor.fWorkshopActivity,
        othersActivity: const Color(0xff0F82D6),
        bronzePlan: AppColor.fBronzePlan,
        silverPlan: AppColor.fSilverPlan,
        goldPlan: AppColor.fGoldPlan,
        diamondPlan: AppColor.fDiamondPlan,
        sendMessageColor: AppColor.fSendMessageColor,
        ownChatBubbleColor: AppColor.fOwnChatBubbleColor,
        fDisableField: AppColor.fDisableField,
        fBadgeReceived: AppColor.fBadgeReceived,
        fActivityJoined: AppColor.fActivityJoined,
        circleAvatarColor: AppColor.fCircleAvatarColor,
        fAccepted: AppColor.fAccepted,
        fDeclined: AppColor.fDeclined,
        fPaid: AppColor.fPaid,
        fUnpaid: AppColor.fUnpaid,
        fWithdrawn: AppColor.fWithdrawn,
        fAwaiting: AppColor.fAwaiting,
        fPresent: AppColor.fPresent,
        fMissed: AppColor.fMissed,
        fAcceptDialogColor: AppColor.fAcceptDialogColor,
        fPresentTextColor: AppColor.fPresentTextColor,
        fUpcomingActivityStatusColor: AppColor.fUpcomingActivityStatusColor,
        fRedActivityStatusColor: AppColor.fRedActivityStatusColor,
        fUnlockedBronze: AppColor.fUnlockedBronze,
        fUnlockedSilver: AppColor.fUnlockedSilver,
        fUnlockedDiamond: AppColor.fUnlockedDiamond,
        fUnlockedGold: AppColor.fUnlockedGold,
        fAllEarningCardColor: AppColor.fAllEarningCardColor,
        fPlaymateEarningCardColor: AppColor.fPlaymateEarningCardColor,
        fVenueEarningCardColor: AppColor.fVenueEarningCardColor,
        fStoreEarningCardColor: AppColor.fStoreEarningCardColor,
        fTeamsEarningCardColor: AppColor.fTeamsEarningCardColor,
        fBronzeFreeColor: AppColor.fBronzeFreeColor,
        fDividerColor: AppColor.fDividerColor,
        shimmerColor: AppColor.fShimmerColor,
        unselectedStepperColor: AppColor.fUnselectedStepperColor,
      ),
      AppTextTheme.light,
    ],
    scrollbarTheme: ScrollbarThemeData(
      interactive: true,
      radius: const Radius.circular(10),
      thumbColor: WidgetStateProperty.resolveWith(_kGetScrollbarColor),
      thickness: WidgetStateProperty.all(5),
      minThumbLength: 50,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColor.fPrimaryColor,
      selectionColor: AppColor.fPrimaryColor.withOpacity(0.3),
      selectionHandleColor: AppColor.fPrimaryColor,
    ),
    switchTheme: _kSwitchTheme,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColor.fTextColor,
      ),
      displayMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColor.fTextColor,
      ),
      headlineLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColor.fTextColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: AppColor.fTextColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColor.fTextColor,
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColor.fTextColor,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColor.fTextColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColor.fTextColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColor.fTextColor,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColor.fTextColor,
      ),
      labelLarge: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColor.fTextColor,
      ),
      labelMedium: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: AppColor.fTextColor,
      ),
    ),
    fontFamily: FontFamily.dMSans,
    appBarTheme: AppBarTheme(
      elevation: 2,
      scrolledUnderElevation: 2,
      shadowColor: Colors.black.withOpacity(0.3),
      iconTheme: const IconThemeData(color: AppColor.fTextColor),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFD5D5D5),
      thickness: 0,
      space: 1,
    ),
    sliderTheme: const SliderThemeData(
      thumbColor: AppColor.fPrimaryColor,
      inactiveTrackColor: AppColor.fTextBoxColor,
      activeTrackColor: AppColor.fPrimaryColor,
      inactiveTickMarkColor: Colors.transparent,
      activeTickMarkColor: Colors.transparent,
      valueIndicatorColor: AppColor.fPrimaryColor,
      valueIndicatorTextStyle: TextStyle(
        color: Colors.white,
      ),
    ),
    textButtonTheme: _kTextButtonTheme,
    timePickerTheme: TimePickerThemeData(
      backgroundColor: _kLightThemePickerBg,
      dayPeriodColor: WidgetStateColor.resolveWith(
        (states) => (states.contains(WidgetState.selected))
            ? AppColor.fPrimaryColor
            : Colors.transparent,
      ),
      dayPeriodTextColor: WidgetStateColor.resolveWith(
        (states) => (states.contains(WidgetState.selected))
            ? Colors.white
            : AppColor.fTextColor,
      ),
      dayPeriodBorderSide: const BorderSide(
        color: AppColor.fPrimaryColor,
      ),
      dialHandColor: AppColor.fPrimaryColor,
      dialTextColor: WidgetStateColor.resolveWith(
        (states) => (states.contains(WidgetState.selected))
            ? Colors.white
            : AppColor.fTextColor,
      ),
      hourMinuteColor: WidgetStateColor.resolveWith(
        (states) => states.contains(WidgetState.focused)
            ? Colors.white
            : states.contains(WidgetState.selected)
                ? AppColor.fPrimaryColor
                : Colors.white,
      ),
      hourMinuteTextColor: WidgetStateColor.resolveWith(
        (states) => states.contains(WidgetState.focused)
            ? AppColor.fTextColor
            : states.contains(WidgetState.selected)
                ? Colors.white
                : AppColor.fTextColor,
      ),
      entryModeIconColor: AppColor.fPrimaryColor,
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: _kLightThemePickerBg,
      todayForegroundColor: _kLightThemeDateFgColor,
      dayForegroundColor: _kLightThemeDateFgColor,
      todayBackgroundColor: _kDateBgColor,
      dayBackgroundColor: _kDateBgColor,
      yearForegroundColor: _kLightThemeDateFgColor,
      yearBackgroundColor: _kDateBgColor,
    ),
  );
}
