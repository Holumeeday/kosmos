// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
// import 'package:playkosmos_v3/data/repositories/auth_flow_storage.dart';
// import 'package:playkosmos_v3/extensions/extensions.dart';
// import 'package:playkosmos_v3/ui/email_otp_verification/cubit/email_otp_verification_cubit.dart';
// import 'package:playkosmos_v3/utils/utils.dart';

// /// Email OTP verification screen
// ///
// ///@author: Godwin Mathias
// class EmailOtpVerificationPage extends StatelessWidget {
//   /// The user email address
//   final String fEmail;

//   const EmailOtpVerificationPage({
//     super.key,
//     required this.fEmail,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return _EmailOtpVerificationForm(
//       fEmail: fEmail,
//     );
//   }
// }

// class _EmailOtpVerificationForm extends StatelessWidget {
//   /// The user email address
//   final String fEmail;

//   const _EmailOtpVerificationForm({

//     required this.fEmail,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final fIsLoading = context.select(
//       (EmailOtpVerificationCubit cubit) =>
//           cubit.state.status == EmailOtpVerificationStatus.loading ||
//           cubit.state.resendOtpStatus ==
//               EmailResendOtpVerificationStatus.loading,
//     );
//     return ShowAsyncBusyIndicator(
//       fInAsync: fIsLoading,
//       fChild: Scaffold(
//         appBar: const CustomAppBar(
//           fElevation: 0,
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: _EmailOtpView(
//             fEmail: fEmail,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _EmailOtpView extends StatelessWidget {
//   /// The user email address of the uer
//   final String fEmail;

//   const _EmailOtpView({

//     required this.fEmail,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<EmailOtpVerificationCubit, EmailOtpVerificationState>(
//           listenWhen: (prev, next) => prev.status != next.status,
//           listener: (context, state) {
//             if (state.status == EmailOtpVerificationStatus.success) {
//               if (state.data?.status != true) return;
//               context.read<AuthFlowStorage>().hasJustCreatedAccount();
//               // Show success dialog
//               showCustomDialog(
//                 context,
//                 barrierDismissible: false,
//                 builder: (BuildContext dialogContext) {
//                   return Dialog(
//                     child: AuthSuccessInfoDialog(
//                       fTitle: context.loc.emailIsOfficiallyVerified,
//                       fMessage: context.loc.emailVerifiedDialogMessage,
//                       fOnLetGo: () {
//                         context.goNamed(
//                           AppRoute.createPasswordScreen,
//                           queryParameters: {
//                             'email': fEmail,
//                             'is-email': true.toString()
//                           },
//                         );
//                       },
//                     ),
//                   );
//                 },
//               );
//             } else if (state.status == EmailOtpVerificationStatus.failure) {
//               SnackBarUtil.showError(message: state.errorMessage!);
//             }
//           },
//         ),
//         BlocListener<EmailOtpVerificationCubit, EmailOtpVerificationState>(
//           listenWhen: (prev, next) =>
//               prev.resendOtpStatus != next.resendOtpStatus,
//           listener: (context, state) {
//             if (state.resendOtpStatus ==
//                 EmailResendOtpVerificationStatus.success) {
//               if (state.data?.status != true) return;
//               // Show success snack bar
//               SnackBarUtil.showInfo(
//                   message: context.loc.otpSentEnterCodeToProceed);
//             } else if (state.resendOtpStatus ==
//                     EmailResendOtpVerificationStatus.failure &&
//                 state.errorMessage != null) {
//               SnackBarUtil.showError(message: state.errorMessage!);
//             }
//           },
//         ),
//       ],
//       child: AuthOTPForm(
//           fOnChanged: (value) {
//             context.read<EmailOtpVerificationCubit>().setOtp(fOtp: value);
//           },
//           fPageTitle: context.loc.enterYourCode,
//           fPageSubTitle: context.loc.letDoubleCheckYourInfoMessage,
//           fOnNextButton: context.read<EmailOtpVerificationCubit>().verifyOtp,
//           fOnResendCode: context.read<EmailOtpVerificationCubit>().resendOtp,
//           fCanResendOtp: true,
//           fOnEndCountdown: () {}),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/data/repositories/auth_flow_storage.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/email_otp_verification/cubit/email_otp_verification_cubit.dart';
import 'package:playkosmos_v3/utils/utils.dart';
import 'package:playkosmos_v3/utils/cache_util.dart';

/// Email OTP verification screen
///
/// @author: Godwin Mathias
class EmailOtpVerificationPage extends StatelessWidget {
   final String fEmail;
  
  const EmailOtpVerificationPage({super.key, required this.fEmail});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: CacheUtil.getData('user_email'), // Retrieve cached email
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError || snapshot.data == null) {
          return const Scaffold(
            body: Center(child: Text('Error: Unable to load email.')),
          );
        }

        // Pass the cached email to the form
        return _EmailOtpVerificationForm(fEmail: snapshot.data!);
      },
    );
  }
}

class _EmailOtpVerificationForm extends StatelessWidget {
  /// The user email address
  final String fEmail;

  const _EmailOtpVerificationForm({
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
          child: _EmailOtpView(fEmail: fEmail),
        ),
      ),
    );
  }
}

class _EmailOtpView extends StatelessWidget {
  /// The user email address
  final String fEmail;

  const _EmailOtpView({
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
              context.read<AuthFlowStorage>().hasJustCreatedAccount();
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
                        // Navigate to the Create Password page
                        // context.goNamed(AppRoute.createPasswordScreen);
                       
                      context.read<AuthFlowStorage>().setVerified().then(
                              (_) => context.goNamed(
                                AppRoute.createPasswordScreen,
                                queryParameters: {
                                  'email': fEmail, // Pass the email value as a query parameter
                                  'is-email': true.toString(),
                                },
                              ),
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
                    context
              .read<EmailOtpVerificationCubit>()
              .setOtp(fOtp: value);   // Correctly passing fOtp
                  },
                  fPageTitle: context.loc.enterYourCode,
                  fPageSubTitle: context.loc.letDoubleCheckYourInfoMessage,
                  fOnNextButton: context.read<EmailOtpVerificationCubit>().verifyOtp,
                  fOnResendCode: context.read<EmailOtpVerificationCubit>().resendOtp,
                  fCanResendOtp: true,
                  fOnEndCountdown: () {},
                ),
      // child: AuthOTPForm(
      //   fOnChanged: (value) {
      //     context.read<EmailOtpVerificationCubit>().setOtp(fOtp: value);
      //   },
      //   fPageTitle: context.loc.enterYourCode,
      //   fPageSubTitle: context.loc.letDoubleCheckYourInfoMessage,
      //   fOnNextButton: context.read<EmailOtpVerificationCubit>().verifyOtp,
      //   fOnResendCode: context.read<EmailOtpVerificationCubit>().resendOtp,
      //   fCanResendOtp: true,
      //   fOnEndCountdown: () {},
      // ),
    );
  }
}
