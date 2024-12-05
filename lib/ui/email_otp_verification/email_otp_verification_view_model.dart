import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/*
This view model controls the otp verification screen
@author: Godwin Mathias
*/
class EmailOTPVerificationViewModel extends ChangeNotifier {
  /// Checks if user can resend otp
  bool dCantResendOtp = true;

  /// Setting the [dCanResendOtp] value
  void setResendingOtp(bool value) {
    dCantResendOtp = value;
    notifyListeners();
  }

  /// To resend the otp
  void resendOtp() async {}

  /// To show the successful otp modal bottom sheet
  Future showSuccessDialog() async {
    showDialog<void>(
      context: GetContext.current,
      builder: (BuildContext dialogContext) {
        return Dialog(
          child: AuthSuccessInfoDialog(
            fTitle: GetContext.loc.emailIsOfficiallyVerified,
            fMessage: GetContext.loc.emailVerifiedDialogMessage,
            fOnLetGo: () {},
          ),
        );
      },
    );
  }
}
