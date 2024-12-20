import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/cubit/profile_creation_flow_cubit.dart';
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
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            context.loc.whatsYourName,
            style: context.appTextTheme.header1,
          ),
          const VSpace(12),
          Text(
            context.loc.thisIsTheNameEveryoneWillSee,
            style: context.appTextTheme.caption,
          ),
          const VSpace(40),

          // Full name text field
          CustomTextFormField(
            fHintText: context.loc.enterFullName,
            fTextController: _fNameController,
            fValidator: ValidationUtil.nameValidator,
          ),

          // Bio text field
          CustomTextFormField(
            fHintText: context.loc.tellUsAboutYourselfOptional,
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
            fOnPressed: () {
              context.read<ProfileCreationFlowCubit>().uploadNameBio(
                    name: _fNameController.text,
                    bio: _fBioController.text.isEmpty
                        ? null
                        : _fBioController.text,
                  );
            },
            fChild: Text(context.loc.nextText),
          ),
        ],
      ),
    );
  }
}
