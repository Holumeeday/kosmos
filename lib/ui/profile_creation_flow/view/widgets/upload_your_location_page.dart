import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/cubit/profile_creation_flow_cubit.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/next_button.dart';

/// Select location permission page
///
/// @author: Godwin Mathias
class UploadYourLocationPage extends StatelessWidget {
  const UploadYourLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Your location text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              context.loc.yourLocation.capitalizeFirstLetter,
              style: context.appTextTheme.header1,
            ),
          ),
          const VSpace(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              context.loc.heyWeWillLoveToKnowWhereYouAre,
              style: context.appTextTheme.caption,
            ),
          ),
          const VSpace(20),
          const Divider(),

          const VSpace(40),

          // Location icon
          const Center(child: _LocationIcon()),
          const VSpace(100),

          // Allow button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: NextButton(
              fOnPressed: () async {
                final fIsPermitted = await context
                    .read<PermissionsRepository>()
                    .requestLocationPermission();
                if (fIsPermitted && context.mounted) {
                  // Navigate to the next stage
                  context.read<ProfileCreationFlowCubit>().nextPage();
                }
              },
              fText: context.loc.allow,
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationIcon extends StatelessWidget {
  const _LocationIcon();

  @override
  Widget build(BuildContext context) {
    final fIsDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 250,
      height: 250,
      padding: const EdgeInsets.symmetric(horizontal: 95),
      decoration: BoxDecoration(
        color: context.colors.primary.withOpacity(fIsDarkMode ? .3 : .1),
        shape: BoxShape.circle,
      ),
      child: Assets.svgs.icons.locationIconGradient.svg(
        height: 83,
        width: 59,
      ),
    );
  }
}
