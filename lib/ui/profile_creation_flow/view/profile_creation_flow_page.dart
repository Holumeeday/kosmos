import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/sizes.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/cubit/profile_creation_flow_cubit.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/upload_name_page.dart';

/// The profile creation flow a successful sign up
///
/// @author: Godwin Mathias
class ProfileCreationFlowPage extends StatelessWidget {
  const ProfileCreationFlowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCreationFlowCubit(),
      child: const _ProfileCreationFlowPage(),
    );
  }
}

class _ProfileCreationFlowPage extends StatefulWidget {
  const _ProfileCreationFlowPage({super.key});

  @override
  State<_ProfileCreationFlowPage> createState() =>
      __ProfileCreationFlowPageState();
}

class __ProfileCreationFlowPageState extends State<_ProfileCreationFlowPage> {
  // Page view controller
  final fPageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCreationFlowCubit, ProfileCreationFlowState>(
      listener: (context, state) {
        fPageController.jumpToPage(
          state.fProfileCreationStage.index,
        );
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            // Progress bar
            const _ProgressBar(),
            const VSpace(40),

            // Back button
            const _BackButtonAndSkip(),

            // Pages
            Expanded(
              child: PageView(
                controller: fPageController,
                children: const [
                  // Name and Bio
                  UploadNamePage(),

                  // Profile pics
                  SizedBox(),

                  // Birthday
                  SizedBox(),

                  // Gender
                  SizedBox(),

                  // Interest
                  SizedBox(),

                  // Location selection
                  SizedBox(),

                  // Search radius
                  SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final dSelectedPage = context.select(
        (ProfileCreationFlowCubit cubit) => cubit.state.fProfileCreationStage);

    return SafeArea(
      child: LinearProgressIndicator(
        backgroundColor: context.appColors.greyShade85Color?.withOpacity(.2),
        valueColor: AlwaysStoppedAnimation(context.colors.primary),
        value: (dSelectedPage.index == 0 ? 1 : dSelectedPage.index) /
            ProfileCreationFlowEnum.values.length,
      ),
    );
  }
}

class _BackButtonAndSkip extends StatelessWidget {
  const _BackButtonAndSkip({super.key});

  @override
  Widget build(BuildContext context) {
    final fFirstPage = ProfileCreationFlowEnum.values.first;
    final fLastPage = ProfileCreationFlowEnum.values.last;
    final dSelectedPage = context.select(
        (ProfileCreationFlowCubit cubit) => cubit.state.fProfileCreationStage);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Back button
          if (dSelectedPage != fFirstPage)
            IconButton(
              onPressed: () {
                context.read<ProfileCreationFlowCubit>().changePage(
                      ProfileCreationFlowEnum.values
                          .elementAt(dSelectedPage.index - 1),
                    );
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
              ),
            )
          else
            const SizedBox.shrink(),

          // Skip button
          if (dSelectedPage != fLastPage && dSelectedPage != fFirstPage)
            Text(
              context.loc.skipText,
              style: context.appTextTheme.buttonMedium?.copyWith(
                color: context.appColors.greyShade85Color,
              ),
            )
          else
            const SizedBox.shrink(),

          if (dSelectedPage != fFirstPage) const VSpace(22),
        ],
      ),
    );
  }
}
