import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/utils/utils.dart';

part 'email_otp_verification_state.dart';

class EmailOtpVerificationCubit extends Cubit<EmailOtpVerificationState> {
  EmailOtpVerificationCubit()
      : super(
          const EmailOtpVerificationState(dCanResendOtp: false),
        );

  /// Setting the [dCanResendOtp] value
  void setResendingOtp(bool value) {
    emit(state.copyWith(dCanResendOtp: value));
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
