import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// Sign in with phone number and password page
///
/// @author: Godwin Mathias
class SignInPhoneNumberPage extends StatefulWidget {
  const SignInPhoneNumberPage({super.key});

  @override
  State<SignInPhoneNumberPage> createState() => _SignInPhoneNumberPageState();
}

class _SignInPhoneNumberPageState extends State<SignInPhoneNumberPage> {
  // Email controller
  late TextEditingController _fPhoneController;

  // Password controller
  late TextEditingController _fPasswordController;

  /// The global key for validation of the form
  final _fFormKey = GlobalKey<FormState>();

  /// If email is valid
  bool? _dIsValidPhone;

  /// If password is valid
  bool? _dIsValidPassword;

  // User name
  final fUsername = 'John Doe';

  @override
  void initState() {
    super.initState();
    _fPhoneController = TextEditingController()
      ..addListener(() {
        if (mounted) {
          _dIsValidPhone =
              ValidationUtil.numberValidator(_fPhoneController.text) == null;
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
    _fPhoneController.dispose();
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

              // Phone number text field
              CustomPhoneField(
                fTextController: _fPhoneController,
                fValidator: ValidationUtil.numberValidator,
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
                  onTap: () {
                    context.push(AppRoute.forgotPasswordPhoneScreenPath);
                  },
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
                fDisabled: !((_dIsValidPhone ?? false) &&
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
                          fOnLetGo: () {
                            context.go(AppRoute.homeScreenPath);
                          },
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
