import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/phone_number_otp_verification%20copy/cubit/phone_number_otp_verification_cubit.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// PhoneNumber OTP verification screen
///
///@author: Godwin Mathias
class PhoneNumberOtpVerificationPage extends StatelessWidget {
  const PhoneNumberOtpVerificationPage({
    super.key,
    required this.fPhone,
  });

  /// The user phone number
  final String fPhone;

  @override
  Widget build(BuildContext context) {
    final fIsLoading = context.select(
      (PhoneNumberOtpVerificationCubit cubit) =>
          cubit.state.status == PhoneNumberOtpVerificationStatus.loading ||
          cubit.state.resendOtpStatus ==
              PhoneNumberResendOtpVerificationStatus.loading,
    );
    return ShowAsyncBusyIndicator(
      fInAsync: fIsLoading,
      fChild: Scaffold(
        appBar: const CustomAppBar(
          fElevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: MultiBlocListener(
            listeners: [
              BlocListener<PhoneNumberOtpVerificationCubit,
                  PhoneNumberOtpVerificationState>(
                listenWhen: (prev, next) => prev.status != next.status,
                listener: (context, state) {
                  if (state.status ==
                      PhoneNumberOtpVerificationStatus.success) {
                    if (state.data?.status != true) return;
                    // Show success dialog
                    showCustomDialog(
                      context,
                      barrierDismissible: false,
                      builder: (BuildContext dialogContext) {
                        return Dialog(
                          child: AuthSuccessInfoDialog(
                            fTitle: context.loc.phoneNumberIsOfficiallyVerified,
                            fMessage: context.loc.emailVerifiedDialogMessage,
                            fOnLetGo: () {
                              context.goNamed(
                                AppRoute.createPasswordScreen,
                                queryParameters: {
                                  'phone': fPhone,
                                  'is-email': false.toString()
                                },
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else if (state.status ==
                          PhoneNumberOtpVerificationStatus.failure &&
                      state.errorMessage != null) {
                    SnackBarUtil.showError(message: state.errorMessage!);
                  }
                },
              ),
              BlocListener<PhoneNumberOtpVerificationCubit,
                  PhoneNumberOtpVerificationState>(
                listenWhen: (prev, next) =>
                    prev.resendOtpStatus != next.resendOtpStatus,
                listener: (context, state) {
                  if (state.resendOtpStatus ==
                      PhoneNumberResendOtpVerificationStatus.success) {
                    if (state.data?.status != true) return;
                    // Show success snack bar
                    SnackBarUtil.showInfo(
                        message: context.loc.otpSentEnterCodeToProceed);
                  } else if (state.resendOtpStatus ==
                          PhoneNumberResendOtpVerificationStatus.failure &&
                      state.errorMessage != null) {
                    SnackBarUtil.showError(message: state.errorMessage!);
                  }
                },
              ),
            ],
            child: AuthOTPForm(
              fPageTitle: context.loc.enterYourCode,
              fPageSubTitle: context.loc.letDoubleCheckYourInfoMessage,
              fOnNextButton:
                  context.read<PhoneNumberOtpVerificationCubit>().verifyOtp,
              fOnResendCode:
                  context.read<PhoneNumberOtpVerificationCubit>().resendOtp,
              fCanResendOtp: context.select(
                  (PhoneNumberOtpVerificationCubit cubit) =>
                      cubit.state.dCanResendOtp),
              fOnEndCountdown: () => context
                  .read<PhoneNumberOtpVerificationCubit>()
                  .setResendingOtp(true),
              fOnChanged: (String value) {
                context
                    .read<PhoneNumberOtpVerificationCubit>()
                    .setOtp(fOtp: value);
              },
            ),
          ),
        ),
      ),
    );
  }
}
