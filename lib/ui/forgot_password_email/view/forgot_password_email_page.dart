import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/forgot_password_otp/view/forgot_password_otp_page.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// Forgot password using email page
///
///@author: Godwin Mathias
class ForgotPasswordEmailPage extends StatefulWidget {
  const ForgotPasswordEmailPage({super.key});

  @override
  State<ForgotPasswordEmailPage> createState() =>
      _ForgotPasswordEmailPageState();
}

class _ForgotPasswordEmailPageState extends State<ForgotPasswordEmailPage> {
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
              // Enter email address text
              Text(
                context.loc.forgotPassword2,
                textAlign: TextAlign.center,
                style: context.appTextTheme.header1,
              ),
              const VSpace(10),
              Text(
                context.loc.noWorriesForgotPasswordCaption,
                textAlign: TextAlign.center,
                style: context.appTextTheme.body?.copyWith(
                  color: context.appColors.greyShade85Color,
                ),
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

              const VSpace(56),

              // Next button
              PrimaryGradientButton(
                fDisabled: !_dCanNext,
                fOnPressed: () {
                  showCustomDialog(
                    barrierDismissible: false,
                    context,
                    builder: (_) => Dialog(
                      child: AuthSuccessInfoDialog(
                        fTitle: context.loc.checkYourEmail,
                        fMessage: context.loc.dingDingCheckInboxMessage,
                        fOnLetGo: () {
                          context
                              .push(const ForgotPasswordOtpVerificationPage());
                        },
                      ),
                    ),
                  );
                },
                fChild: Text(context.loc.nextText),
              )
            ],
          ),
        ),
      ),
    );
  }
}
