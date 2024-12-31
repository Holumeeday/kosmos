import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/forgot_password_otp/cubit/forgot_password_otp_cubit.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// Forgot password OTP verification screen
///
///@author: Godwin Mathias
class ForgotPasswordOtpVerificationPage extends StatelessWidget {
  const ForgotPasswordOtpVerificationPage({
    super.key,
    required this.fEmail,
    required this.fPhone,
    required this.fIsEmail,
  });

  /// The user email
  final String? fEmail;

  /// The user phone number
  final String? fPhone;

  /// If the user is using phone or email
  final bool fIsEmail;

  @override
  Widget build(BuildContext context) {
    return _EmailOtpView(
      fEmail: fEmail,
      fIsEmail: fIsEmail,
      fPhone: fPhone,
    );
  }
}

class _EmailOtpView extends StatelessWidget {
  const _EmailOtpView({
    this.fEmail,
    this.fPhone,
    required this.fIsEmail,
  });

  /// The user email
  final String? fEmail;

  /// The user phone number
  final String? fPhone;

  /// If the user is using phone or email
  final bool fIsEmail;

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
                        context.goNamed(
                          AppRoute.resetPasswordScreen,
                          queryParameters: {
                            if (fEmail != null) 'email': fEmail!,
                            if (fPhone != null) 'phone': fPhone!,
                            'is-email': fIsEmail.toString(),
                          },
                        );
                      },
                    ),
                  );
                },
              );
            } else if (state.status ==
                    ForgotPasswordOtpVerificationStatus.failure &&
                state.errorMessage != null) {
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
              fCanResendOtp: fIsEmail
                  ? true
                  : context.select((ForgotPasswordOtpVerificationCubit cubit) =>
                      cubit.state.canResendOtp),
              fOnEndCountdown: () => context
                  .read<ForgotPasswordOtpVerificationCubit>()
                  .setResendingOtp(true),
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
