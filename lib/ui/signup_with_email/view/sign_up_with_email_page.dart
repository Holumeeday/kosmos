import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/email_otp_verification/view/email_otp_verification_page.dart';
import 'package:playkosmos_v3/ui/signup_with_email/cubit/sign_up_with_email_cubit.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// This defines the sign up with email page
///
///@author: Godwin Mathias
class SignUpWithEmailPage extends StatelessWidget {
  const SignUpWithEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpWithEmailCubit(
        fAuthRepository: context.read<AuthRemoteApiRepository>(),
      ),
      child: const _SignUpWithEmailPageView(),
    );
  }
}

class _SignUpWithEmailPageView extends StatefulWidget {
  const _SignUpWithEmailPageView({super.key});

  @override
  State<_SignUpWithEmailPageView> createState() =>
      _SignUpWithEmailPageViewState();
}

class _SignUpWithEmailPageViewState extends State<_SignUpWithEmailPageView> {
  /// The email controller
  late TextEditingController _fEmailController;

  /// The global key for validation of the form
  final _fFormKey = GlobalKey<FormState>();

  /// If the user can click the next button
  bool _dCanNext = false;

  @override
  void initState() {
    super.initState();
    _fEmailController = TextEditingController()
      ..addListener(() {
        if (mounted) {
          _dCanNext =
              ValidationUtil.emailValidator(_fEmailController.text) == null;
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _fEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShowAsyncBusyIndicator(
      fInAsync: context.select(
        (SignUpWithEmailCubit cubit) =>
            cubit.state.status == SignUpWithEmailStatus.loading,
      ),
      fChild: BlocListener<SignUpWithEmailCubit, SignUpWithEmailState>(
        listener: (context, state) {
          if (state.status == SignUpWithEmailStatus.success) {
            // If sign up was successful
            if (state.data?.status == true) {
              context.push(const EmailOtpVerificationPage());
            }
          } else if (state.status == SignUpWithEmailStatus.failure) {
            SnackBarUtil.showError(message: state.errorMessage!);
          }
        },
        child: Scaffold(
          appBar: const CustomAppBar(
            fElevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _fFormKey,
              child: Column(
                children: <Widget>[
                  // Enter email address text
                  Text(
                    context.loc.enterYourEmailAddress,
                    textAlign: TextAlign.center,
                    style: context.appTextTheme.header1,
                  ),
                  const VSpace(40),

                  // Email text field
                  CustomTextFormField(
                    fTextController: _fEmailController,
                    fLabelText: context.loc.emailHint,
                    fInputAction: TextInputAction.done,
                    fTextType: TextInputType.emailAddress,
                    fAutoFillHints: const [AutofillHints.email],
                    fValidator: ValidationUtil.emailValidator,
                  ),
                  const VSpace(12),

                  // OTP sent text label
                  Text(
                    context.loc.weAreSendingYouASecretCodeToVerifyEmail,
                    style: context.appTextTheme.caption,
                  ),
                  const VSpace(56),

                  // Next button
                  PrimaryGradientButton(
                    fDisabled: !_dCanNext,
                    fOnPressed: () {
                      context
                          .read<SignUpWithEmailCubit>()
                          .signUpEmail(email: _fEmailController.text);
                    },
                    fChild: Text(context.loc.nextText),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
