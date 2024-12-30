import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/sign_in_email/cubit/sign_in_cubit.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// Sign in with email and password page
///
/// @author: Godwin Mathias
class SignInEmailPage extends StatelessWidget {
  const SignInEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SignInEmailForm();
  }
}

class _SignInEmailForm extends StatefulWidget {
  const _SignInEmailForm({super.key});

  @override
  State<_SignInEmailForm> createState() => __SignInEmailPageForm();
}

class __SignInEmailPageForm extends State<_SignInEmailForm> {
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
    return BlocListener<SignInWithEmailCubit, SignInWithEmailState>(
      listener: (context, state) {
        if (state.status == SignInWithEmailStatus.success) {
          if (state.data?.status == true) {
            if (state.user?.fullName != null) {
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext dialogContext) {
                  return Dialog(
                    child: AuthSuccessInfoDialog(
                      fTitle: context.loc
                          .welcomeBackUser(state.user?.fullName ?? 'User'),
                      fMessage: context.loc.youAreAlllSignedInAndReadyToRoll,
                      fOnLetGo: () {
                        // Set login status to true which will re-direct the user
                        // to home page
                        context
                            .read<AuthFlowStorage>()
                            .setLogIn(
                              hasCompletedStep2: true,
                            )
                            .then((_) {
                          if (context.mounted) {
                            context.go(AppRoute.homeScreenPath);
                          }
                        });
                      },
                    ),
                  );
                },
              );
            } else {
              context
                  .read<AuthFlowStorage>()
                  .setLogIn(
                    hasCompletedStep2: false,
                  )
                  .then((_) {
                if (context.mounted) {
                  context.go(AppRoute.profileCreationFlowScreenPath);
                }
              });
            }
          }
        } else if (state.status == SignInWithEmailStatus.failure &&
            state.errorMessage != null) {
          SnackBarUtil.showError(message: state.errorMessage!);
        }
      },
      child: ShowAsyncBusyIndicator(
        fInAsync: context.select(
          (SignInWithEmailCubit cubit) =>
              cubit.state.status == SignInWithEmailStatus.loading,
        ),
        fChild: Scaffold(
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
                      onTap: () {
                        context.push(
                          AppRoute.forgotPasswordEmailScreenPath,
                        );
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
                    fDisabled: !((_dIsValidEmail ?? false) &&
                        (_dIsValidPassword ?? false)),
                    fOnPressed: () {
                      context.read<SignInWithEmailCubit>().signInEmail(
                            password: _fPasswordController.text,
                            email: _fEmailController.text,
                          );
                    },
                    fChild: Text(context.loc.loginText),
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
