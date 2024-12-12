import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/*
The validation functions
@author: Ugochukwu Umeh
 */
class ValidationUtil {
  static AppLocalizations get _loc => GetContext.loc;

  /// To validate a user's name. Maybe first name, last name or username
  /// depending on the value of [isFirstName]
  static String? nameValidator(String? value, [bool? isFirstName]) {
    String regularExpression = r"^[a-zA-Z- ]+$";
    if (value == null || value.isEmpty) {
      return switch (isFirstName) {
        null => _loc.enterName,
        true => _loc.enterFirstName,
        false => _loc.enterLastName,
      };
    } else if (!RegExp(regularExpression).hasMatch(value)) {
      return _loc.invalidName;
    }
    return null;
  }

  /// To validate user's email
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return _loc.enterEmail;
    } else if (!RegExp(
            r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return _loc.invalidEmail;
    }
    return null;
  }

  /// To validate user's number
  static String? numberValidator(String? value) {
    if (value != null && value.length > 4) {
      return null;
    }
    return _loc.enterPhoneNumber;
  }

  /// Bio validator
  static String? bioValidator(String? value) {
    if (value == null || value.length >= 150 || value.isEmpty) {
      return null;
    }
    return _loc.bioTooShort;
  }

  /// To validate user's dob,
  static String? dobValidator(String? value) {
    if (value == null || value.isEmpty) {
      return _loc.invalidDateOfBirth;
    }
    return null;
  }

  /// To validate password
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return _loc.enterPassword;
    } else if (value.length < 6) {
      return _loc.passwordMinError;
    }
    return null;
  }

  /// To validate otp
  static String? otpValidatorWithCode(String? value, String otpCode) {
    if (value == null || value.isEmpty) {
      return _loc.enterOtpError;
    } else if (value != otpCode) {
      return _loc.wrongOtpError;
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return _loc.enterValidNumericOtp;
    }
    return null;
  }

  /// To validate otp without a code
  static String? otpValidatorWithoutCode(String? value) {
    if (value == null || value.isEmpty) {
      return _loc.enterOtpError;
    } else if (value.length != 6) {
      return _loc.otpExactly6Digits;
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return _loc.enterValidNumericOtp;
    }
    return null;
  }

  /// A generic validator for text
  static String? textValidator(String? value, String textFieldTitle) {
    if (value == null || value.isEmpty) {
      return _loc.textFieldCannotBeEmpty(textFieldTitle);
    }
    return null;
  }

  /// Validates the card month
  static String? validateMonth(String? input, String year) {
    if (input == null || input.isEmpty) {
      return _loc.thisFieldIsRequired;
    }
    int month = int.parse(input);
    if ((month < 1) || (month > 12)) {
      return _loc.invalidMonth;
    }
    if (_hasMonthPassed(int.parse(year), month)) {
      return _loc.expiredCard;
    }
    return null;
  }

  /// Validates the card year
  static String? validateYear(String? input) {
    if (input == null || input.isEmpty) {
      return _loc.thisFieldIsRequired;
    }
    int year = int.parse(input);
    if (_hasYearPassed(year)) {
      return _loc.expiredCard;
    }
    return null;
  }

  /// Validates the CVV
  static String? validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return _loc.thisFieldIsRequired;
    }
    if (value.length < 3 || value.length > 4) {
      return _loc.invalidCVV;
    }
    return null;
  }

  /// Validates the hours
  static String? validateHours(String? value) {
    if (value == null || value.isEmpty) {
      return _loc.pleaseEnterHours;
    }
    final int? parsedValue = int.tryParse(value);
    if (parsedValue == null || parsedValue < 1) {
      return _loc.invalidHours;
    }
    return null;
  }

  /// Validates the minutes
  static String? validateMinutes(String? value) {
    if (value == null || value.isEmpty) {
      return _loc.pleaseEnterMinutes;
    }
    final int? parsedValue = int.tryParse(value);
    if (parsedValue == null || parsedValue < 1) {
      return _loc.invalidMinutes;
    }
    return null;
  }

  /// Validates the price
  static String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return _loc.thisFieldIsRequired;
    }
    final double? parsedValue = double.tryParse(value);
    if (parsedValue == null || parsedValue < 0) {
      return _loc.invalidPrice;
    }
    return null;
  }

  /// Validates the amount to withdraw
  static String? validateWithdrawal(String? value) {
    if (value == null || value.isEmpty) {
      return _loc.thisFieldIsRequired;
    }
    final double? parsedValue = double.tryParse(value);
    if (parsedValue == null || parsedValue <= 0) {
      return _loc.pleaseEnterAValidWithdrawalAmount;
    }
    return null; // Validation passed
  }

  /// Converts the year to 4 digits
  static int _convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      DateTime now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  /// Checks if month has passed
  static bool _hasMonthPassed(int year, int month) {
    DateTime now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past.
    // 2. Card's month is more than current month.
    return _hasYearPassed(year) ||
        _convertYearTo4Digits(year) == now.year && (month <= now.month);
  }

  /// Checks if year has passed
  static bool _hasYearPassed(int year) {
    int fourDigitsYear = _convertYearTo4Digits(year);
    DateTime now = DateTime.now();
    return fourDigitsYear < now.year;
  }
}
