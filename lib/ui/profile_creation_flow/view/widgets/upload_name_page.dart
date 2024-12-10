import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// This is the user name and basic information page
///
/// @author: Godwin Mathias
class UploadNamePage extends StatefulWidget {
  const UploadNamePage({super.key});

  @override
  State<UploadNamePage> createState() => _UploadNamePageState();
}

class _UploadNamePageState extends State<UploadNamePage> {
  /// The user name controller
  late TextEditingController _fNameController;

  /// The user info controller
  late TextEditingController _fBioController;

  /// The global key for validation of the form
  final _fFormKey = GlobalKey<FormState>();

  /// If user name is valid
  bool? _dNameIsValid;

  /// If user bio is valid
  bool? _dBioIsValid;

  /// Bio text count
  int _dBioTextCount = 0;

  @override
  void initState() {
    super.initState();
    _fNameController = TextEditingController()
      ..addListener(() {
        if (mounted) {
          _dNameIsValid =
              ValidationUtil.nameValidator(_fNameController.text) == null;
          setState(() {});
        }
      });

    _fBioController = TextEditingController()
      ..addListener(() {
        if (mounted) {
          _dBioIsValid =
              ValidationUtil.bioValidator(_fBioController.text) == null;
          _dBioTextCount = _fBioController.text.length;
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _fNameController.dispose();
    _fBioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "What's your name ?",
              style: context.appTextTheme.header1,
            ),
            const VSpace(12),
            Text(
              'This is the name everyone will see — make it shine!',
              style: context.appTextTheme.caption,
            ),
            const VSpace(40),

            // Full name text field
            CustomTextFormField(
              fHintText: 'Enter full name',
              fTextController: _fNameController,
              fValidator: ValidationUtil.nameValidator,
            ),

            // Bio text field
            CustomTextFormField(
              fHintText: 'Tell us about yourself (optional)',
              fTextController: _fBioController,
              fMaxLines: 5,
              fValidator: ValidationUtil.bioValidator,
            ),
            const VSpace(12),

            // Bio text counter
            Align(
              alignment: Alignment.topRight,
              child: Text(
                '$_dBioTextCount/150',
                style: context.appTextTheme.caption,
              ),
            ),
            const VSpace(40),

            // Next button
            PrimaryGradientButton(
              fDisabled: !((_dNameIsValid ?? false) && (_dBioIsValid ?? true)),
              fOnPressed: () {},
              fChild: Text(context.loc.nextText),
            ),
          ],
        ),
      ),
    );
  }
}
