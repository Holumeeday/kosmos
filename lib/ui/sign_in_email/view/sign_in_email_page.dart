import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// Sign in with email and password page
///
/// @author: Godwin Mathias
class SignInEmailPage extends StatefulWidget {
  const SignInEmailPage({super.key});

  @override
  State<SignInEmailPage> createState() => _SignInEmailPageState();
}

class _SignInEmailPageState extends State<SignInEmailPage> {
  // Email controller
  late TextEditingController _fEmailController;

  // Password controller
  late TextEditingController _fPasswordController;

  /// The global key for validation of the form
  final _fFormKey = GlobalKey<FormState>();

  /// If email is valid
  bool? _dIsValidEmail;

  /// If password is valid
  bool? _dIsValidPassword;

  // User name
  final fUsername = 'John Doe';

  @override
  void initState() {
    super.initState();
    _fEmailController = TextEditingController()
      ..addListener(() {
        if (mounted) {
          _dIsValidEmail =
              ValidationUtil.emailValidator(_fEmailController.text) == null;
          setState(() {});
        }
      });

    _fPasswordController = TextEditingController()
      ..addListener(() {
        if (mounted) {
          _dIsValidPassword =
              ValidationUtil.passwordValidator(_fPasswordController.text) ==
                  null;
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _fPasswordController.dispose();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                context.loc.signIn,
                style: context.appTextTheme.header1,
              ),
              const VSpace(10),
              Text(
                context.loc.welcomeBackWeMissedYouSignInEmail,
                style: context.appTextTheme.body?.copyWith(
                  color: context.appColors.greyShade85Color,
                ),
              ),
              const VSpace(56),

              // Email text field
              CustomTextFormField(
                fTextController: _fEmailController,
                fLabelText: context.loc.emailHint,
                fInputAction: TextInputAction.done,
                fTextType: TextInputType.emailAddress,
                fAutoFillHints: const [AutofillHints.email],
                fValidator: ValidationUtil.emailValidator,
              ),
              const VSpace(24),

              // Password text field
              CustomPasswordField(
                fPasswordController: _fPasswordController,
              ),
              const VSpace(8),

              // Forgot password
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  child: Text(
                    context.loc.forgotPassword,
                    style: context.appTextTheme.buttonMedium?.copyWith(
                      color: context.appColors.fHyperLinkColor,
                    ),
                  ),
                ),
              ),
              const VSpace(85),

              // Login button
              PrimaryGradientButton(
                fDisabled: !((_dIsValidEmail ?? false) &&
                    (_dIsValidPassword ?? false)),
                fOnPressed: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext dialogContext) {
                      return Dialog(
                        child: AuthSuccessInfoDialog(
                          fTitle: context.loc.welcomeBackUser(fUsername),
                          fMessage:
                              context.loc.youAreAlllSignedInAndReadyToRoll,
                          fOnLetGo: () {},
                        ),
                      );
                    },
                  );
                },
                fChild: Text(context.loc.loginText),
              )
            ],
          ),
        ),
      ),
    );
  }
}
