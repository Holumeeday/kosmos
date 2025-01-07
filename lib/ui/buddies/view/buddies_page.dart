import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/connection_type_extention.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/models/buddy_model.dart';
import 'package:playkosmos_v3/ui/buddies/cubit/buddies_cubit.dart';
import 'package:playkosmos_v3/ui/buddies/view/widgets/interest_chips.dart';
import 'package:playkosmos_v3/ui/buddies/view/widgets/next_arrow_button.dart';
import 'package:playkosmos_v3/ui/buddies/view/widgets/overlapping_profiles.dart';
import 'package:playkosmos_v3/ui/sign_in_email/cubit/sign_in_cubit.dart';
import 'package:playkosmos_v3/ui/sign_in_phone/cubit/sign_in_phone_cubit.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// Buddies Page
/// A page that displays a user profile with details like distance, interests, and mutual buddies.
/// @author: Chidera Chijama
class BuddiesPage extends StatefulWidget {
  const BuddiesPage({super.key});

  @override
  State<BuddiesPage> createState() => _BuddiesPageState();
}

class _BuddiesPageState extends State<BuddiesPage> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<BuddiesCubit>().fetchBuddies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BuddiesCubit, BuddiesState>(
      listener: (context, state) {
        if (state.status == BuddiesStatus.failure &&
            state.errorMessage != null) {
          SnackBarUtil.showError(message: state.errorMessage!);
        }
      },
      builder: (context, state) {
        return state.fBuddiesModel == null
            ? const Center(child: CircularProgressIndicator())
            : ShowAsyncBusyIndicator(
                fInAsync: context.select((BuddiesCubit cubit) =>
                    cubit.state.status == BuddiesStatus.loading),
                fChild: PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: state.fBuddiesModel!.length,
                  itemBuilder: (context, index) {
                    return _BuddyProfile(
                      fBuddyId: state.fBuddiesModel![index].id,
                    );
                  },
                ));
        //  ShowAsyncBusyIndicator(

        //     fInAsync: context.select((BuddiesCubit cubit) =>
        //         cubit.state.status == BuddiesStatus.loading),
        //     fChild: PageView.builder(
        //       scrollDirection: Axis.vertical,
        //       itemCount: state.fBuddiesModel!.length,
        //       itemBuilder: (context, index) {
        //         return _BuddyProfile(
        //           fBuddyId: state.fBuddiesModel![index].id,
        //         );
        //       },
        //     ));
      },
    );
  }
}

class _BuddyProfile extends StatelessWidget {
  const _BuddyProfile({
    required this.fBuddyId,
  });

  final String fBuddyId;

  @override
  Widget build(BuildContext context) {
    final fProfile =
        context.watch<BuddiesCubit>().state.fBuddiesModel!.firstWhere(
              (element) => element.id == fBuddyId,
            );
    double distance = Geolocator.distanceBetween(
      fProfile.location!.latitude!,
      fProfile.location!.longitude!,
      context.read<SignInWithEmailCubit>().state.user?.locations!.latitude! ??
          context.read<SignInPhoneCubit>().state.user!.locations!.latitude!,
      context.read<SignInWithEmailCubit>().state.user?.locations!.longitude! ??
          context.read<SignInPhoneCubit>().state.user!.locations!.longitude!,
    );
    return Stack(
      children: [
        // Background Image
        if (fProfile.pictures!.isNotEmpty)
          Positioned.fill(
              child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(fProfile.pictures!.first))),
          )),

        // Gradient Overlay at the bottom
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black87,
                  Colors.black,
                ],
                stops: [0.8, 0.85, 0.9],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        // Bottom Content
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  runSpacing: 9,
                  spacing: 8,
                  children: [
                    _buildBadge(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.location_on_sharp,
                                color: context.colors.primary),
                            Text(
                              "$distance ${context.loc.miles} ${context.loc.away}",
                              style: context.textTheme.bodyMedium!
                                  .copyWith(color: context.colors.primary),
                            )
                          ],
                        ),
                        context),
                    _buildBadge(
                        Text(
                          "${fProfile.similarInterests!.length} ${context.loc.similarInterests} ",
                          style: context.textTheme.headlineSmall!
                              .copyWith(color: context.appColors.textColor),
                        ),
                        context),
                    _buildBadge(
                        Row(
                          children: [
                            const OverlappingProfiles(),
                            Text(
                              " ${fProfile.mutualBuddies!.total! > 12 ? '+' : ''}${fProfile.mutualBuddies!.total} ${context.loc.mutualBuddies}",
                              style: context.textTheme.headlineSmall!
                                  .copyWith(color: context.appColors.textColor),
                            )
                          ],
                        ),
                        context),
                  ],
                ),

                const VSpace(12),

                // User name and follow button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextScaleFactorClamp(
                        fChild: Text(fProfile.fullname!,
                            style: context.textTheme.displayLarge!
                                .copyWith(color: Colors.white, fontSize: 28)),
                      ),
                    ),
                    const HSpace(8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // fProfile.l connectionType.toConnectionButton(context),
                        const HSpace(5),
                        NextArrowButton(
                          fOnTap: () {
                            context.push(
                              AppRoute.buddyProfileScreenPath,
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
                const VSpace(12),

                // Interests Chips
                InterestChips(
                  // Should only show few interests here
                  fInterests: fProfile.interests!.take(4).toList(),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Builds a badge with an icon and text
  Widget _buildBadge(Widget fChild, BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 33,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: fChild,
      ),
    );
  }
}
