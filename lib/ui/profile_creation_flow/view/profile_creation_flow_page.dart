import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/cubit/profile_creation_flow_cubit.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/upload_birthday_page.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/upload_gender_page.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/upload_interest_page.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/upload_name_page.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/upload_pics_page.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/upload_search_radius_page.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/upload_your_location_page.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// The profile creation flow a successful sign up
///
/// @author: Godwin Mathias
class ProfileCreationFlowPage extends StatelessWidget {
  const ProfileCreationFlowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProfileCreationFlowPage();
  }
}

class _ProfileCreationFlowPage extends StatefulWidget {
  const _ProfileCreationFlowPage();

  @override
  State<_ProfileCreationFlowPage> createState() =>
      __ProfileCreationFlowPageState();
}

class __ProfileCreationFlowPageState extends State<_ProfileCreationFlowPage>
    with AutomaticKeepAliveClientMixin {
  // Page view controller
  final fPageController = PageController();

  @override
  void initState() {
    super.initState();
    final fCurrentUser = context.read<UserProfileStorage>().fUserModel;
    // Navigate to the next profile flow if the user name is already set
    if (fCurrentUser.data?.fullName != null) {
      context.read<ProfileCreationFlowCubit>().nextPage();
    }
  }

  @override
  void dispose() {
    fPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileCreationFlowCubit, ProfileCreationFlowState>(
          listener: (context, state) {
            fPageController.jumpToPage(
              state.fProfileCreationStage.index,
            );
          },
        ),

        // Uploading Name and Bio listener
        BlocListener<ProfileCreationFlowCubit, ProfileCreationFlowState>(
          listenWhen: (prev, next) =>
              prev.uploadNameStatus != next.uploadNameStatus,
          listener: (context, state) {
            if (state.uploadNameStatus ==
                ProfileCreationUploadNameStatus.success) {
              if (state.data?.status != true) return;
              context.read<ProfileCreationFlowCubit>().nextPage();
            } else if (state.uploadNameStatus ==
                    ProfileCreationUploadNameStatus.failure &&
                state.errorMessage != null) {
              SnackBarUtil.showError(message: state.errorMessage!);
            }
          },
        ),
      ],
      child: ShowAsyncBusyIndicator(
        fInAsync: context.select((ProfileCreationFlowCubit cubit) =>
            cubit.state.uploadNameStatus ==
                ProfileCreationUploadNameStatus.loading ||
            cubit.state.uploadOthersStatus ==
                ProfileCreationUploadOthersStatus.loading),
        fChild: Scaffold(
          body: SafeArea(
            child: Column(
              children: <Widget>[
                // Progress bar
                const _ProgressBar(),
                const VSpace(20),

                // Back button
                const _BackButtonAndSkip(),

                // Pages
                Expanded(
                  child: PageView(
                    controller: fPageController,
                    allowImplicitScrolling: false,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      // Name and Bio
                      UploadNamePage(),

                      // Profile pics
                      UploadPicsPage(),

                      // Birthday
                      UploadBirthdayPage(),

                      // Gender
                      UploadGenderPage(),

                      // Interest
                      UploadInterestPage(),

                      // Location selection
                      UploadYourLocationPage(),

                      // Search radius
                      UploadSearchRadiusPage(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar();

  @override
  Widget build(BuildContext context) {
    final dSelectedPage = context.select(
        (ProfileCreationFlowCubit cubit) => cubit.state.fProfileCreationStage);

    return LinearProgressIndicator(
      minHeight: 6,
      backgroundColor: context.appColors.greyShade85Color?.withOpacity(.2),
      valueColor: AlwaysStoppedAnimation(context.colors.primary),
      value: (dSelectedPage.index == 0 ? 1 : dSelectedPage.index + 1) /
          ProfileCreationFlowEnum.values.length,
    );
  }
}

class _BackButtonAndSkip extends StatelessWidget {
  const _BackButtonAndSkip();

  @override
  Widget build(BuildContext context) {
    final fFirstPage = ProfileCreationFlowEnum.values.first;
    final fLastPage = ProfileCreationFlowEnum.values.last;
    final dSelectedPage = context.select(
        (ProfileCreationFlowCubit cubit) => cubit.state.fProfileCreationStage);
    final fCanShowSkip = canShowSkip(context, dSelectedPage);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Back button
              if (dSelectedPage != fFirstPage)
                InkWell(
                  onTap: () {
                    context.read<ProfileCreationFlowCubit>().changePage(
                          ProfileCreationFlowEnum.values
                              .elementAt(dSelectedPage.index - 1),
                        );
                  },
                  child: const Icon(
                    Icons.arrow_back_rounded,
                  ),
                )
              else
                const SizedBox.shrink(),

              // Skip button
              if (dSelectedPage != fLastPage &&
                  dSelectedPage != fFirstPage &&
                  fCanShowSkip)
                GestureDetector(
                  onTap: () {
                    context.read<ProfileCreationFlowCubit>().nextPage();
                  },
                  child: Text(
                    context.loc.skipText,
                    style: context.appTextTheme.buttonMedium?.copyWith(
                      color: context.appColors.greyShade85Color,
                    ),
                  ),
                )
              else
                const SizedBox.shrink(),
            ],
          ),
          if (dSelectedPage != fFirstPage) const VSpace(22),
        ],
      ),
    );
  }

  bool canShowSkip(BuildContext context, ProfileCreationFlowEnum currentPage) {
    return switch (currentPage) {
      ProfileCreationFlowEnum.uploadName => false,
      ProfileCreationFlowEnum.uploadProfilePics => context.select(
          (ProfileCreationFlowCubit cubit) =>
              cubit.state.fFlowModel.profilePicsList!.every((e) => e == null)),
      ProfileCreationFlowEnum.uploadBirthday => context.select(
          (ProfileCreationFlowCubit cubit) =>
              cubit.state.fFlowModel.dateOfBirth == null),
      ProfileCreationFlowEnum.uploadGender => context.select(
          (ProfileCreationFlowCubit cubit) =>
              cubit.state.fFlowModel.gender == null),
      ProfileCreationFlowEnum.uploadInterest =>
        context.select((ProfileCreationFlowCubit cubit) {
          final interests =
              cubit.state.fSelectedInterestMap.values.expand((e) => e);
          return interests
              .isEmpty; // If no interests are selected, show the button
        }),
      ProfileCreationFlowEnum.uploadSearchRadius => context.select(
          (ProfileCreationFlowCubit cubit) =>
              cubit.state.fFlowModel.radius == null),
      ProfileCreationFlowEnum.uploadLocation =>
        context.select((ProfileCreationFlowCubit cubit) => false),
    };
  }
}
