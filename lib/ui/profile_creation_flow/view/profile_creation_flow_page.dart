import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/cubit/profile_creation_flow_cubit.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/upload_birthday_page.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/upload_gender_page.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/upload_interest_per_category_page.dart';
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
    if (fCurrentUser.fullName != null) {
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

        // Uploading other details
        BlocListener<ProfileCreationFlowCubit, ProfileCreationFlowState>(
          listenWhen: (prev, next) =>
              prev.uploadOthersStatus != next.uploadOthersStatus,
          listener: (context, state) {
            if (state.uploadOthersStatus ==
                ProfileCreationUploadOthersStatus.success) {
              if (state.data?.status != true) return;
              // If other details were successfully uploaded
              // go to home
              showDialog(
                context: context,
                builder: (_) {
                  return Dialog(
                    child: AuthSuccessInfoDialog(
                        fTitle: '',
                        fMessage: context.loc.profileCreationDialogMessage,
                        fWidget: Image.asset(
                            Assets.webp.onboarding.welcomeOnboarding.path),
                        fOnLetGo: () {
                          context.go(AppRoute.homeScreenPath);
                        }),
                  );
                },
              );
            } else if (state.uploadOthersStatus ==
                    ProfileCreationUploadOthersStatus.failure &&
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

                      // Sports Interest
                      UploadInterestPerCategoryPage(fCategoryTitle: 'sports'),

                      // Arts Interest
                      UploadInterestPerCategoryPage(fCategoryTitle: 'arts'),

                      // Technology Interest
                      UploadInterestPerCategoryPage(
                          fCategoryTitle: 'technology'),

                      // Food Interest
                      UploadInterestPerCategoryPage(fCategoryTitle: 'food'),

                      // Education Interest
                      UploadInterestPerCategoryPage(
                          fCategoryTitle: 'education'),

                      // Social Interest
                      UploadInterestPerCategoryPage(fCategoryTitle: 'social'),

                      // Wellness Interest
                      UploadInterestPerCategoryPage(fCategoryTitle: 'wellness'),

                      // Animals Interest
                      UploadInterestPerCategoryPage(fCategoryTitle: 'animals'),

                      // Religion & Spirituality
                      UploadInterestPerCategoryPage(
                          fCategoryTitle: 'spirituality'),

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
    final fSelectedInterests = context.select(
        (ProfileCreationFlowCubit cubit) => cubit.state.fSelectedInterestMap);
    final fCanShowSkip =
        canShowSkip(context, dSelectedPage, fSelectedInterests);
    print(dSelectedPage);
    print(fCanShowSkip);
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

  bool canShowSkip(
    BuildContext context,
    ProfileCreationFlowEnum currentPage,
    Map<String, List<String>> selectedInterests,
  ) {
    printI(selectedInterests['education']?.isEmpty);
    return switch (currentPage) {
      ProfileCreationFlowEnum.uploadName => false,
      ProfileCreationFlowEnum.uploadSportInterest =>
        selectedInterests['sports']?.isEmpty ?? true,
      ProfileCreationFlowEnum.uploadArtInterest =>
        selectedInterests['arts']?.isEmpty ?? true,
      ProfileCreationFlowEnum.uploadTechInterest =>
        selectedInterests['technology']?.isEmpty ?? true,
      ProfileCreationFlowEnum.uploadEducationInterest =>
        selectedInterests['education']?.isEmpty ?? true,
      ProfileCreationFlowEnum.uploadFoodInterest =>
        selectedInterests['food']?.isEmpty ?? true,
      ProfileCreationFlowEnum.uploadWellnessInterest =>
        selectedInterests['wellness']?.isEmpty ?? true,
      ProfileCreationFlowEnum.uploadAnimalInterest =>
        selectedInterests['animals']?.isEmpty ?? true,
      ProfileCreationFlowEnum.uploadSpiritualityInterest =>
        selectedInterests['spirituality']?.isEmpty ?? true,
      ProfileCreationFlowEnum.uploadSocialInterest =>
        selectedInterests['social']?.isEmpty ?? true,
      ProfileCreationFlowEnum.uploadProfilePics => context.select(
          (ProfileCreationFlowCubit cubit) =>
              cubit.state.fFlowModel.profilePicsList!.every((e) => e == null)),
      ProfileCreationFlowEnum.uploadBirthday => context.select(
          (ProfileCreationFlowCubit cubit) =>
              cubit.state.fFlowModel.dateOfBirth == null),
      ProfileCreationFlowEnum.uploadGender => context.select(
          (ProfileCreationFlowCubit cubit) =>
              cubit.state.fFlowModel.gender == null),
      ProfileCreationFlowEnum.uploadSearchRadius => context.select(
          (ProfileCreationFlowCubit cubit) =>
              cubit.state.fFlowModel.radius == null),
      ProfileCreationFlowEnum.uploadLocation =>
        context.select((ProfileCreationFlowCubit cubit) => false),
    };
  }
}
