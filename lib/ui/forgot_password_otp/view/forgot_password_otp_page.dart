import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/data/repositories/auth_remote_api_repository.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/forgot_password_otp/cubit/forgot_password_otp_cubit.dart';
import 'package:playkosmos_v3/ui/reset_password_page/view/reset_password_page.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// Forgot password OTP verification screen
///
///@author: Godwin Mathias
class ForgotPasswordOtpVerificationPage extends StatelessWidget {
  const ForgotPasswordOtpVerificationPage({
    super.key,
    required this.fEmail,
  });

  /// The user email
  final String fEmail;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordOtpVerificationCubit(
          fEmail: fEmail,
          fAuthRepository: context.read<AuthRemoteApiRepository>()),
      child: _EmailOtpView(
        fEmail: fEmail,
      ),
    );
  }
}

class _EmailOtpView extends StatelessWidget {
  const _EmailOtpView({
    super.key,
    required this.fEmail,
  });

  /// The user email
  final String fEmail;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ForgotPasswordOtpVerificationCubit,
            ForgotPasswordOtpVerificationState>(
          listenWhen: (prev, next) => prev.status != next.status,
          listener: (context, state) {
            if (state.status == ForgotPasswordOtpVerificationStatus.success) {
              if (state.data?.status != true) return;
              // Show success dialog
              showCustomDialog(
                context,
                barrierDismissible: false,
                builder: (BuildContext dialogContext) {
                  return Dialog(
                    child: AuthSuccessInfoDialog(
                      fTitle: context.loc.codeAccepted,
                      fMessage: context.loc.youAreOfficiallyBackInActionMessage,
                      fOnLetGo: () {
                        context.push(ResetPasswordPage(
                          fEmail: fEmail,
                        ));
                      },
                    ),
                  );
                },
              );
            } else if (state.status ==
                ForgotPasswordOtpVerificationStatus.failure) {
              SnackBarUtil.showError(message: state.errorMessage!);
            }
          },
        ),
        BlocListener<ForgotPasswordOtpVerificationCubit,
            ForgotPasswordOtpVerificationState>(
          listenWhen: (prev, next) =>
              prev.resendOtpStatus != next.resendOtpStatus,
          listener: (context, state) {
            if (state.resendOtpStatus ==
                ForgotPasswordResendOtpVerificationStatus.success) {
              if (state.data?.status != true) return;
              // Show success snack bar
              SnackBarUtil.showInfo(
                  message: context.loc.otpSentEnterCodeToProceed);
            } else if (state.resendOtpStatus ==
                ForgotPasswordResendOtpVerificationStatus.failure) {
              SnackBarUtil.showError(message: state.errorMessage!);
            }
          },
        ),
      ],
      child: ShowAsyncBusyIndicator(
        fInAsync: context.select((ForgotPasswordOtpVerificationCubit cubit) =>
            cubit.state.status == ForgotPasswordOtpVerificationStatus.loading ||
            cubit.state.resendOtpStatus ==
                ForgotPasswordResendOtpVerificationStatus.loading),
        fChild: Scaffold(
          appBar: const CustomAppBar(
            fElevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AuthOTPForm(
              fPageTitle: context.loc.enterYourCode,
              fPageSubTitle: context.loc.alrightTimeToCreateEnterASecretCode,
              fOnNextButton:
                  context.read<ForgotPasswordOtpVerificationCubit>().verifyOtp,
              fOnResendCode:
                  context.read<ForgotPasswordOtpVerificationCubit>().resendOtp,
              fCanResendOtp: true,
              fOnEndCountdown: () {},
              fOnChanged: (String value) {
                context
                    .read<ForgotPasswordOtpVerificationCubit>()
                    .setOtp(fOtp: value);
              },
            ),
          ),
        ),
      ),
    );
  }
}
