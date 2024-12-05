import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/common_widgets/custom_text_form_fields.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/email_otp_verification/email_otp_verification_view.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// This defines the sign up with email page
///
///@author: Godwin Mathias
class SignUpWithEmailView extends StatefulWidget {
  const SignUpWithEmailView({super.key});

  @override
  State<SignUpWithEmailView> createState() => _SignUpWithEmailViewState();
}

class _SignUpWithEmailViewState extends State<SignUpWithEmailView> {
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
    return Scaffold(
      appBar: const CustomAppBar(
        fElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _fFormKey,
          child: Column(
            children: <Widget>[
              const VSpace(20),

              // Enter email address text
              Text(
                context.loc.enterYourEmailAddress,
                textAlign: TextAlign.center,
                style: context.appTextTheme.header1,
              ),

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
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.appColors.darkGreyColor,
                  fontSize: 14,
                ),
              ),
              const VSpace(56),

              // Next button
              PrimaryGradientButton(
                fDisabled: !_dCanNext,
                fOnPressed: () {
                  context.push(const EmailOtpVerificationView());
                },
                fChild: Text(
                  context.loc.nextText,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
