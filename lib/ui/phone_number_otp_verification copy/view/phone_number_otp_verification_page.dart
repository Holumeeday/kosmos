import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/create_password/view/create_password_page.dart';
import 'package:playkosmos_v3/ui/phone_number_otp_verification%20copy/cubit/phone_number_otp_verification_cubit.dart';

/// Email OTP verification screen
///
///@author: Godwin Mathias
class PhoneNumberOtpVerificationPage extends StatelessWidget {
  const PhoneNumberOtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        fElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocProvider(
          create: (context) => PhoneNumberOtpVerificationCubit(),
          child: const _PhoneNumberOtpView(),
        ),
      ),
    );
  }
}

class _PhoneNumberOtpView extends StatelessWidget {
  const _PhoneNumberOtpView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneNumberOtpVerificationCubit,
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
                    context.pop();

                    context.push(const CreatePasswordPage(
                      fEmail: '',
                    ));
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
            context.read<PhoneNumberOtpVerificationCubit>().showSuccessDialog,
        fOnResendCode:
            context.read<PhoneNumberOtpVerificationCubit>().resendOtp,
        fCanResendOtp: context.select((PhoneNumberOtpVerificationCubit cubit) =>
            cubit.state.dCanResendOtp),
        fOnEndCountdown: () => context
            .read<PhoneNumberOtpVerificationCubit>()
            .setResendingOtp(true),
        fOnChanged: (String value) {},
      ),
    );
  }
}
