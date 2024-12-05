import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/email_otp_verification/cubit/email_otp_verification_cubit.dart';

/// Email OTP verification screen
///
///@author: Godwin Mathias
class EmailOtpVerificationView extends StatelessWidget {
  const EmailOtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        fElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocProvider(
          create: (context) => EmailOtpVerificationCubit(),
          child: const _EmailOtpView(),
        ),
      ),
    );
  }
}

class _EmailOtpView extends StatelessWidget {
  const _EmailOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthOTPForm(
      fPageTitle: context.loc.enterYourCode,
      fPageSubTitle: context.loc.letDoubleCheckYourInfoMessage,
      fOnNextButton:
          context.read<EmailOtpVerificationCubit>().showSuccessDialog,
      fOnResendCode: context.read<EmailOtpVerificationCubit>().resendOtp,
      fCanResendOtp: context.select(
          (EmailOtpVerificationCubit cubit) => cubit.state.dCanResendOtp),
      fOnEndCountdown: () =>
          context.read<EmailOtpVerificationCubit>().setResendingOtp(true),
    );
  }
}
