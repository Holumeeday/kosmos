import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/create_password/view/create_password_page.dart';
import 'package:playkosmos_v3/ui/email_otp_verification/cubit/email_otp_verification_cubit.dart';
import 'package:playkosmos_v3/utils/pop_up_util.dart';

/// Email OTP verification screen
///
///@author: Godwin Mathias
class EmailOtpVerificationPage extends StatelessWidget {
  const EmailOtpVerificationPage({super.key});

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
    return BlocListener<EmailOtpVerificationCubit, EmailOtpVerificationState>(
      listener: (context, state) {
        if (state.dShowSuccessDialog) {
          // Show success dialog
          showCustomDialog(
            context,
            barrierDismissible: false,
            builder: (BuildContext dialogContext) {
              return Dialog(
                child: AuthSuccessInfoDialog(
                  fTitle: context.loc.emailIsOfficiallyVerified,
                  fMessage: context.loc.emailVerifiedDialogMessage,
                  fOnLetGo: () {
                    context.push(const CreatePasswordPage());
                  },
                ),
              );
            },
          );
        }
      },
      child: AuthOTPForm(
        fPageTitle: context.loc.enterYourCode,
        fPageSubTitle: context.loc.letDoubleCheckYourInfoMessage,
        fOnNextButton:
            context.read<EmailOtpVerificationCubit>().showSuccessDialog,
        fOnResendCode: context.read<EmailOtpVerificationCubit>().resendOtp,
        fCanResendOtp: context.select(
            (EmailOtpVerificationCubit cubit) => cubit.state.dCanResendOtp),
        fOnEndCountdown: () =>
            context.read<EmailOtpVerificationCubit>().setResendingOtp(true),
      ),
    );
  }
}
