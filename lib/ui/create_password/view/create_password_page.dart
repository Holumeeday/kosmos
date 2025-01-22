// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
// import 'package:playkosmos_v3/data/data.dart';
// import 'package:playkosmos_v3/extensions/extensions.dart';
// import 'package:playkosmos_v3/ui/create_password/cubit/create_password_cubit.dart';
// import 'package:playkosmos_v3/utils/utils.dart';

// /// The create password form page
// ///
// /// @author: Godwin Mathias
// class CreatePasswordPage extends StatefulWidget {
//   /// The user email address of the uer
//   final String fEmail;
//   final String fPhone;
//   final bool fIsEmail;

//   const CreatePasswordPage({
//     super.key,
//     required this.fEmail,
//     required this.fIsEmail,
//     required this.fPhone,
//   });

//   @override
//   State<CreatePasswordPage> createState() => _CreatePasswordPageState();
// }

// class _CreatePasswordPageState extends State<CreatePasswordPage> {
//   /// The password controller
//   late TextEditingController _fPasswordController;

//   /// The global key for validation of the form
//   final _fFormKey = GlobalKey<FormState>();

//   /// If the user can click the next button
//   bool _dCanNext = false;

//   @override
//   void initState() {
//     super.initState();
//     _fPasswordController = TextEditingController()
//       ..addListener(() {
//         if (mounted) {
//           _dCanNext =
//               ValidationUtil.passwordValidator(_fPasswordController.text) ==
//                   null;
//           setState(() {});
//         }
//       });
//   }

//   @override
//   void dispose() {
//     _fPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<CreatePasswordCubit, CreatePasswordState>(
//       listener: (context, state) {
//         if (state.status == CreatePasswordStatus.success) {
//           // If sign up was successful
          
//           if (state.data?.status == true) {
//             context.read<AuthFlowStorage>().hasCreatedPassword();
//             // Navigate to bio creation flow
//             context
//                 .read<AuthFlowStorage>()
//                 .setLogIn(hasCompletedStep2: false)
//                 .then((_) {
//               if (context.mounted) {
//                 context.go(AppRoute.profileCreationFlowScreenPath);
//               }
//             });
//           }
//         } else if (state.status == CreatePasswordStatus.failure &&
//             state.errorMessage != null) {
//           SnackBarUtil.showError(message: state.errorMessage!);
//         }
//       },
//       child: ShowAsyncBusyIndicator(
//         fInAsync: context.select(
//           (CreatePasswordCubit cubit) =>
//               cubit.state.status == CreatePasswordStatus.loading,
//         ),
//         fChild: Scaffold(
//           appBar: const CustomAppBar(
//             fShowBackButton: false,
//             fElevation: 0,
//           ),
//           body: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Form(
//               key: _fFormKey,
//               child: Column(
//                 children: <Widget>[
//                   // Enter password text
//                   Text(
//                     context.loc.createPassword,
//                     textAlign: TextAlign.center,
//                     style: context.appTextTheme.header1,
//                   ),
//                   const VSpace(40),

//                   // Password text field
//                   CustomPasswordField(
//                     fPasswordController: _fPasswordController,
//                   ),
//                   const VSpace(12),

//                   // text label
//                   Text(
//                     context.loc.timeToLockThingsDownPasswordCreationMessage,
//                     style: context.appTextTheme.caption,
//                   ),
//                   const VSpace(56),

//                   // Next button
//                   PrimaryGradientButton(
//                     fDisabled: !_dCanNext,
//                     fOnPressed: () {
//                       context.read<CreatePasswordCubit>().createPassword(
//                             password: _fPasswordController.text,
//                             email: widget.fEmail,
//                             phone: widget.fPhone,
//                           );
//                     },
//                     fChild: Text(context.loc.nextText),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/data/repositories/auth_flow_storage.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/create_password/cubit/create_password_cubit.dart';
import 'package:playkosmos_v3/utils/utils.dart';
import 'package:playkosmos_v3/utils/cache_util.dart';

/// The create password form page
///
/// @author: Godwin Mathias
class CreatePasswordPage extends StatefulWidget {
  final String fEmail;
  final String fPhone;
  final bool fIsEmail;

  const CreatePasswordPage({super.key, required this.fEmail, required this.fPhone, required this.fIsEmail});

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
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

  //  @override
  // void initState() {
  //   super.initState();
  //   _fPasswordController = TextEditingController()
  //     ..addListener(() {
  //       setState(() {
  //         _dCanNext =
  //             ValidationUtil.passwordValidator(_fPasswordController.text) ==
  //                 null;
  //       });
  //     });
  // }

  @override
  void dispose() {
    _fPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchCachedData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || snapshot.data == null) {
          return const Scaffold(
            body: Center(child: Text('Error: Unable to load user data.')),
          );
        }

        final email = snapshot.data!['email'] as String;
        final phone = snapshot.data!['phone'] as String;
        final isEmail = snapshot.data!['isEmail'] as bool;

        return _CreatePasswordForm(
          fEmail: email,
          fPhone: phone,
          fIsEmail: isEmail,
          fPasswordController: _fPasswordController,
          dCanNext: _dCanNext,
        );
      },
    );
  }

  /// Fetch cached email, phone, and isEmail flag
  Future<Map<String, dynamic>> _fetchCachedData() async {
    final email = await CacheUtil.getData('user_email') ?? '';
    final phone = await CacheUtil.getData('user_phone') ?? '';
    final isEmail = (await CacheUtil.getData('is_email')) == 'true';

    if (email.isEmpty && phone.isEmpty) {
      throw Exception('No email or phone cached.');
    }

    return {'email': email, 'phone': phone, 'isEmail': isEmail};
  }
}

class _CreatePasswordForm extends StatelessWidget {
  final String fEmail;
  final String fPhone;
  final bool fIsEmail;

  const _CreatePasswordForm({
    required this.fEmail,
    required this.fPhone,
    required this.fIsEmail, required TextEditingController fPasswordController, required bool dCanNext,
  });

  @override
  Widget build(BuildContext context) {
    final _fPasswordController = TextEditingController();
    final _fFormKey = GlobalKey<FormState>();
    bool _dCanNext = false;

    return BlocListener<CreatePasswordCubit, CreatePasswordState>(
      listener: (context, state) {
        if (state.status == CreatePasswordStatus.success) {
          if (state.data?.status == true) {
            context.read<AuthFlowStorage>().hasCreatePassword();
            // Navigate to bio creation flow
            context
                .read<AuthFlowStorage>()
                .setLogIn(hasCompletedStep2: false)
                .then((_) {
              if (context.mounted) {
                context.go(AppRoute.profileCreationFlowScreenPath);
              }
            });
          }
        } else if (state.status == CreatePasswordStatus.failure &&
            state.errorMessage != null) {
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
                            email: fEmail,
                            phone: fPhone,
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
