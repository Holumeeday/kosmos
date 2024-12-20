import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/sizes.dart';
import 'package:playkosmos_v3/data_transfer_objects/activity_interest_groups.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/cubit/profile_creation_flow_cubit.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/next_button.dart';

/// Define the selection of interests page
///
/// @author: Godwin Mathias
class UploadInterestPage extends StatelessWidget {
  const UploadInterestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fInterestGroupList = context.select(
        (ProfileCreationFlowCubit cubit) => cubit.state.fFlowModel.interests);
    final fSelectedInterestsList = context.select(
        (ProfileCreationFlowCubit cubit) => cubit.state.fSelectedInterestMap);

    return CustomScrollView(
      slivers: <Widget>[
        // Tell us your interest
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              context.loc.tellUsYourInterest,
              style: context.appTextTheme.header1,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: VSpace(40)),

        SliverList.separated(
          separatorBuilder: (_, __) => const VSpace(20),
          itemCount: fInterestGroupList!.length,
          itemBuilder: (context, index) {
            return _InterestGroupList(
              fInterestGroup: fInterestGroupList[index],
              fSelectedInterestsList: fSelectedInterestsList[
                      fInterestGroupList[index].categoryName] ??
                  [],
            );
          },
        ),

        const SliverToBoxAdapter(child: VSpace(30)),
        // Allow button
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: NextButton(
              fOnPressed: () async {
                if (context.mounted) {
                  // Navigate to the next stage
                  context.read<ProfileCreationFlowCubit>().nextPage();
                }
              },
              fText: context.loc.nextText,
            ),
          ),
        ),
      ],
    );
  }
}

/// Header widget for interest groups.
///
/// Displays the group title, a switch for "Select All," and an expandable toggle.
/// The widget uses a responsive layout and adapts based on screen width.

class _InterestHeader extends StatelessWidget {
  const _InterestHeader({
    required this.fIsSelectAll,
    required this.fOnSelectAll,
    required this.fTitle,
    this.fOnClosed,
    required this.fIsClosed,
  });

  /// Indicates if all interests in the group are selected.
  final bool fIsSelectAll;

  /// Callback triggered when the "Select All" switch is toggled.
  final ValueChanged<bool> fOnSelectAll;

  /// Title of the interest group.
  final String fTitle;

  /// Callback triggered when the close button is pressed.
  final void Function()? fOnClosed;

  /// Indicates whether the group is currently expanded or collapsed.
  final bool fIsClosed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: context.appColors.darkGreyColor?.withOpacity(.07),
        border: Border.symmetric(
          horizontal: BorderSide(
            width: 1,
            color: context.appColors.darkGreyColor!.withOpacity(.4),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Group icon and title
          Flexible(
            child: Row(
              children: [
                const Icon(
                  Icons.sports_soccer_rounded,
                ),
                const HSpace(10),

                // Title text
                Flexible(
                  child: Text(
                    fTitle,
                    style: context.appTextTheme.body,
                  ),
                ),
              ],
            ),
          ),

          // "Select All" switch
          Switch(
            value: fIsSelectAll,
            onChanged: (v) => fOnSelectAll.call(v),
          ),
          const HSpace(12),
          Text(
            context.loc.selectAll,
            style: context.appTextTheme.buttonMedium,
          ),

          // Close/Expand toggle button
          const HRelativeSpace(32),
          Row(
            children: [
              if (getScreenWidth(context) >= 480)
                Text(
                  fIsClosed ? context.loc.close : context.loc.expand,
                  style: context.appTextTheme.header3!.copyWith(fontSize: 14),
                ),
              IconButton(
                onPressed: fOnClosed,
                icon: Icon(
                  fIsClosed
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 24,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

/// List widget for displaying interests within a group.
///
/// Displays the interest chips and provides functionality for expanding, collapsing,
/// and toggling "Select All." The widget uses an animation controller for smooth transitions.
class _InterestGroupList extends StatefulWidget {
  /// List of currently selected interests.
  final List<String> fSelectedInterestsList;

  /// Group of interests to display.
  final ActivityInterestGroups fInterestGroup;

  const _InterestGroupList({
    required this.fInterestGroup,
    required this.fSelectedInterestsList,
  });

  @override
  State<_InterestGroupList> createState() => _InterestGroupListState();
}

class _InterestGroupListState extends State<_InterestGroupList>
    with TickerProviderStateMixin {
  // Animation controller for expanding and collapsing the list.
  late final AnimationController _controller;

  // Animation for controlling the size transition.
  late final Animation<double> _animation;

  // Tween to define the size transition's start and end values.
  late final Tween<double> _sizeTween;

  // Tracks the current expansion state of the group.
  bool _isExpanded = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _sizeTween = Tween(begin: 0, end: 1);
    super.initState();
  }

  /// Toggles the expanded state of the group and triggers the animation.
  void _expandOnChanged() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    _isExpanded ? _controller.forward() : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Group header with title and toggle options
        _InterestHeader(
          fTitle: context.loc
              .setInterestCategory(widget.fInterestGroup.categoryName),
          fIsSelectAll: widget.fInterestGroup.selectAll,
          fOnSelectAll: (v) {
            context
                .read<ProfileCreationFlowCubit>()
                .setSelectAllInterestGroup(widget.fInterestGroup);
          },
          fOnClosed: _expandOnChanged,
          fIsClosed: _isExpanded,
        ),

        // Animated list of interests
        SizeTransition(
          sizeFactor: _sizeTween.animate(_animation),
          child: Column(
            children: [
              const VSpace(20),

              // Display interest chips
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 16,
                    spacing: 10,
                    children: [
                      for (final interest in (widget.fInterestGroup.showAll
                          ? widget.fInterestGroup.interests
                          : widget.fInterestGroup.interests.take(4)))
                        InkWell(
                          borderRadius: BorderRadius.circular(40),
                          onTap: () {
                            context
                                .read<ProfileCreationFlowCubit>()
                                .selectInterest(
                                  widget.fInterestGroup,
                                  interest,
                                );
                          },
                          child: _InterestChip(
                            fIsSelected: widget.fInterestGroup.selectAll ||
                                widget.fSelectedInterestsList
                                    .contains(interest),
                            fText: context.loc.setInterestName(interest),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const VSpace(25),

              // "Show All" button
              if (widget.fInterestGroup.interests.length >= 4)
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      context
                          .read<ProfileCreationFlowCubit>()
                          .setShowAll(widget.fInterestGroup);
                    },
                    child:
                        _ShowAllButton(fShowAll: widget.fInterestGroup.showAll),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShowAllButton extends StatelessWidget {
  const _ShowAllButton({
    required this.fShowAll,
  });

  /// Show all
  final bool fShowAll;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Durations.extralong4,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: !fShowAll
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.loc.showAll2,
                  style: context.appTextTheme.buttonSmall,
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: context.appTextTheme.buttonSmall?.color,
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.loc.showLess,
                  style: context.appTextTheme.buttonSmall,
                ),
                Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color: context.appTextTheme.buttonSmall?.color,
                ),
              ],
            ),
    );
  }
}

class _InterestChip extends StatelessWidget {
  const _InterestChip({
    required this.fIsSelected,
    required this.fText,
  });

  /// Is selected
  final bool fIsSelected;

  /// Chip text value
  final String fText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: fIsSelected
              ? context.colors.primary
              : context.appColors.darkGreyColor!.withOpacity(.5),
        ),
      ),
      child: Text(
        fText,
        style: context.appTextTheme.body?.copyWith(
          color: fIsSelected
              ? context.colors.primary
              : context.appColors.darkGreyColor?.withOpacity(.9),
        ),
      ),
    );
  }
}
