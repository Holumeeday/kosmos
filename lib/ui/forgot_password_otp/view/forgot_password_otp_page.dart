import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/create_password/view/create_password_page.dart';
import 'package:playkosmos_v3/ui/forgot_password_otp/cubit/forgot_password_otp_cubit.dart';

/// Forgot password OTP verification screen
///
///@author: Godwin Mathias
class ForgotPasswordOtpVerificationPage extends StatelessWidget {
  const ForgotPasswordOtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        fElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocProvider(
          create: (context) => ForgotPasswordOtpVerificationCubit(),
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
    return BlocListener<ForgotPasswordOtpVerificationCubit,
        ForgotPasswordOtpVerificationState>(
      listener: (context, state) {
        if (state.dShowSuccessDialog) {
          // Show success dialog
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext dialogContext) {
              return Dialog(
                child: AuthSuccessInfoDialog(
                  fTitle: context.loc.codeAccepted,
                  fMessage: context.loc.youAreOfficiallyBackInActionMessage,
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
        fPageSubTitle: context.loc.alrightTimeToCreateEnterASecretCode,
        fOnNextButton: context
            .read<ForgotPasswordOtpVerificationCubit>()
            .showSuccessDialog,
        fOnResendCode:
            context.read<ForgotPasswordOtpVerificationCubit>().resendOtp,
        fCanResendOtp: context.select(
            (ForgotPasswordOtpVerificationCubit cubit) =>
                cubit.state.dCanResendOtp),
        fOnEndCountdown: () => context
            .read<ForgotPasswordOtpVerificationCubit>()
            .setResendingOtp(true),
      ),
    );
  }
}
