import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/email_otp_verification/cubit/email_otp_verification_cubit.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// Email OTP verification screen
///
///@author: Godwin Mathias
class EmailOtpVerificationPage extends StatelessWidget {
  /// The user email address
  final String fEmail;

  const EmailOtpVerificationPage({
    super.key,
    required this.fEmail,
  });

  @override
  Widget build(BuildContext context) {
    return _EmailOtpVerificationForm(
      fEmail: fEmail,
    );
  }
}

class _EmailOtpVerificationForm extends StatelessWidget {
  /// The user email address
  final String fEmail;

  const _EmailOtpVerificationForm({
    super.key,
    required this.fEmail,
  });

  @override
  Widget build(BuildContext context) {
    final fIsLoading = context.select(
      (EmailOtpVerificationCubit cubit) =>
          cubit.state.status == EmailOtpVerificationStatus.loading ||
          cubit.state.resendOtpStatus ==
              EmailResendOtpVerificationStatus.loading,
    );
    return ShowAsyncBusyIndicator(
      fInAsync: fIsLoading,
      fChild: Scaffold(
        appBar: const CustomAppBar(
          fElevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _EmailOtpView(
            fEmail: fEmail,
          ),
        ),
      ),
    );
  }
}

class _EmailOtpView extends StatelessWidget {
  /// The user email address of the uer
  final String fEmail;

  const _EmailOtpView({
    super.key,
    required this.fEmail,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<EmailOtpVerificationCubit, EmailOtpVerificationState>(
          listenWhen: (prev, next) => prev.status != next.status,
          listener: (context, state) {
            if (state.status == EmailOtpVerificationStatus.success) {
              if (state.data?.status != true) return;
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
                        context.goNamed(
                          AppRoute.createPasswordScreen,
                          queryParameters: {
                            'email': fEmail,
                            'is-email': true.toString()
                          },
                        );
                      },
                    ),
                  );
                },
              );
            } else if (state.status == EmailOtpVerificationStatus.failure) {
              SnackBarUtil.showError(message: state.errorMessage!);
            }
          },
        ),
        BlocListener<EmailOtpVerificationCubit, EmailOtpVerificationState>(
          listenWhen: (prev, next) =>
              prev.resendOtpStatus != next.resendOtpStatus,
          listener: (context, state) {
            if (state.resendOtpStatus ==
                EmailResendOtpVerificationStatus.success) {
              if (state.data?.status != true) return;
              // Show success snack bar
              SnackBarUtil.showInfo(
                  message: context.loc.otpSentEnterCodeToProceed);
            } else if (state.resendOtpStatus ==
                    EmailResendOtpVerificationStatus.failure &&
                state.errorMessage != null) {
              SnackBarUtil.showError(message: state.errorMessage!);
            }
          },
        ),
      ],
      child: AuthOTPForm(
          fOnChanged: (value) {
            context.read<EmailOtpVerificationCubit>().setOtp(fOtp: value);
          },
          fPageTitle: context.loc.enterYourCode,
          fPageSubTitle: context.loc.letDoubleCheckYourInfoMessage,
          fOnNextButton: context.read<EmailOtpVerificationCubit>().verifyOtp,
          fOnResendCode: context.read<EmailOtpVerificationCubit>().resendOtp,
          fCanResendOtp: true,
          fOnEndCountdown: () {}),
    );
  }
}
