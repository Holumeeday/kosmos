import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/profile_creation_flow_page.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// The create password form page
///
/// @author: Godwin Mathias
class CreatePasswordPage extends StatefulWidget {
  const CreatePasswordPage({super.key});

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

  @override
  void dispose() {
    _fPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  context.push(const ProfileCreationFlowPage());
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
