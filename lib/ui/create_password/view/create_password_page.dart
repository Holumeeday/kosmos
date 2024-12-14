import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/create_password/cubit/create_password_cubit.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// The create password form page
///
/// @author: Godwin Mathias
class CreatePasswordPage extends StatelessWidget {
  /// The user email address of the uer
  final String fEmail;

  const CreatePasswordPage({
    super.key,
    required this.fEmail,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePasswordCubit(
          fAuthRepository: context.read<AuthRemoteApiRepository>()),
      child: _CreatePasswordForm(
        fEmail: fEmail,
      ),
    );
  }
}

class _CreatePasswordForm extends StatefulWidget {
  /// The user email address of the uer
  final String fEmail;

  const _CreatePasswordForm({
    super.key,
    required this.fEmail,
  });

  @override
  State<_CreatePasswordForm> createState() => _CreatePasswordFormState();
}

class _CreatePasswordFormState extends State<_CreatePasswordForm> {
  /// The password controller
  late TextEditingController _fPasswordController;

  /// The global key for validation of the form
  final _fFormKey = GlobalKey<FormState>();

  /// If the user can click the next button
  bool _dCanNext = false;

  @override
  void initState() {
    super.initState();
    _fPasswordController = TextEditingController()
      ..addListener(() {
        if (mounted) {
          _dCanNext =
              ValidationUtil.passwordValidator(_fPasswordController.text) ==
                  null;
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _fPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePasswordCubit, CreatePasswordState>(
      listener: (context, state) {
        if (state.status == CreatePasswordStatus.success) {
          // If sign up was successful
          if (state.data?.status == true) {
            // Navigate to create profile or login
          }
        } else if (state.status == CreatePasswordStatus.failure) {
          SnackBarUtil.showError(message: state.errorMessage!);
        }
      },
      child: ShowAsyncBusyIndicator(
        fInAsync: context.select(
          (CreatePasswordCubit cubit) =>
              cubit.state.status == CreatePasswordStatus.loading,
        ),
        fChild: Scaffold(
          appBar: const CustomAppBar(
            fShowBackButton: false,
            fElevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _fFormKey,
              child: Column(
                children: <Widget>[
                  // Enter password text
                  Text(
                    context.loc.createPassword,
                    textAlign: TextAlign.center,
                    style: context.appTextTheme.header1,
                  ),
                  const VSpace(40),

                  // Password text field
                  CustomPasswordField(
                    fPasswordController: _fPasswordController,
                  ),
                  const VSpace(12),

                  // text label
                  Text(
                    context.loc.timeToLockThingsDownPasswordCreationMessage,
                    style: context.appTextTheme.caption,
                  ),
                  const VSpace(56),

                  // Next button
                  PrimaryGradientButton(
                    fDisabled: !_dCanNext,
                    fOnPressed: () {
                      context.read<CreatePasswordCubit>().createPassword(
                            password: _fPasswordController.text,
                            email: widget.fEmail,
                          );
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
