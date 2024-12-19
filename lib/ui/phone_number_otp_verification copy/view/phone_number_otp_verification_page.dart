import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/phone_number_otp_verification%20copy/cubit/phone_number_otp_verification_cubit.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// Email OTP verification screen
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
    return Scaffold(
      appBar: const CustomAppBar(
        fElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocListener<PhoneNumberOtpVerificationCubit,
            PhoneNumberOtpVerificationState>(
          listener: (context, state) {
            if (state.dShowSuccessDialog) {
              // Show success dialog
              showDialog<void>(
                context: context,
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
            }
          },
          child: AuthOTPForm(
            fPageTitle: context.loc.enterYourCode,
            fPageSubTitle: context.loc.letDoubleCheckYourInfoMessage,
            fOnNextButton: context
                .read<PhoneNumberOtpVerificationCubit>()
                .showSuccessDialog,
            fOnResendCode:
                context.read<PhoneNumberOtpVerificationCubit>().resendOtp,
            fCanResendOtp: context.select(
                (PhoneNumberOtpVerificationCubit cubit) =>
                    cubit.state.dCanResendOtp),
            fOnEndCountdown: () => context
                .read<PhoneNumberOtpVerificationCubit>()
                .setResendingOtp(true),
            fOnChanged: (String value) {},
          ),
        ),
      ),
    );
  }
}
