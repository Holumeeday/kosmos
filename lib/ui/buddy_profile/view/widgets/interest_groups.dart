import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/models/activity_interest_groups.dart';

class InterestGroups extends StatelessWidget {
  const InterestGroups({
    super.key,
    required this.fActivityInterestGroupList,
    this.fSeeMore,
  });

  final List<ActivityInterestGroups> fActivityInterestGroupList;
  final void Function(ActivityInterestGroups fInterestGroup)? fSeeMore;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemCount: fActivityInterestGroupList.length,
      itemBuilder: (context, index) {
        return InterestGroupList(
          fInterestGroup: fActivityInterestGroupList[index],
          fSeeMore: fSeeMore!,
        );
      },
    );
  }
}

class InterestGroupList extends StatefulWidget {
  const InterestGroupList({
    super.key,
    required this.fInterestGroup,
    required this.fSeeMore,
  });

  final ActivityInterestGroups fInterestGroup;
  final void Function(ActivityInterestGroups fInterestGroup) fSeeMore;

  @override
  State<InterestGroupList> createState() => _InterestGroupListState();
}

class _InterestGroupListState extends State<InterestGroupList>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    if (widget.fInterestGroup.showAll) {
      _controller.forward();
    }
  }

  void _toggleExpansion() {
    setState(() {
      if (widget.fInterestGroup.showAll) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      widget.fSeeMore(widget.fInterestGroup);
    });
  }

  @override
  Widget build(BuildContext context) {
    final interestsToDisplay = widget.fInterestGroup.showAll
        ? widget.fInterestGroup.interests
        : widget.fInterestGroup.interests.take(4).toList();
    log("###### display ${interestsToDisplay}");
    log("######widget ${widget.fInterestGroup.interests}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Group Header
        _InterestHeader(
            fTitle: widget.fInterestGroup.categoryName.capitalizeFirstLetter),
        const SizedBox(height: 8),
        Wrap(
          runSpacing: 16,
          spacing: 10,
          children: [
            ...interestsToDisplay.map(
              (interest) => _InterestChip(
                fIsSeeMore: false,
                fText: context.loc.setInterestName(interest),
              ),
            ),
            if (widget.fInterestGroup.interests.length > 4)
              GestureDetector(
                onTap: _toggleExpansion,
                child: _InterestChip(
                  fIsSeeMore: true,
                  fText: widget.fInterestGroup.showAll
                      ? context.loc.seeLess
                      : context.loc.seeMore,
                ),
              ),
          ],
        ),
        // Interests with animation
        // SizeTransition(
        //   sizeFactor: _animation,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
        //     child: Wrap(
        //       runSpacing: 16,
        //       spacing: 10,
        //       children: [
        //         ...interestsToDisplay.map(
        //           (interest) => _InterestChip(
        //             fIsSeeMore: false,
        //             fText: context.loc.setInterestName(interest),
        //           ),
        //         ),
        //         if (widget.fInterestGroup.interests.length > 4)
        //           GestureDetector(
        //             onTap: _toggleExpansion,
        //             child: _InterestChip(
        //               fIsSeeMore: true,
        //               fText: widget.fInterestGroup.showAll
        //                   ? context.loc.seeLess
        //                   : context.loc.seeMore,
        //             ),
        //           ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _InterestHeader extends StatelessWidget {
  const _InterestHeader({required this.fTitle});

  final String fTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: context.appColors.darkGreyColor?.withOpacity(0.07),
        border: Border.symmetric(
          horizontal: BorderSide(
            width: 1,
            color: context.appColors.darkGreyColor!.withOpacity(0.4),
          ),
        ),
      ),
      child: Text(
        fTitle,
        style: context.appTextTheme.body,
      ),
    );
  }
}

class _InterestChip extends StatelessWidget {
  const _InterestChip({
    required this.fText,
    required this.fIsSeeMore,
  });

  final String fText;
  final bool fIsSeeMore;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: context.appColors.darkGreyColor!.withOpacity(0.5),
        ),
      ),
      child: Text(
        fText,
        style: context.appTextTheme.body?.copyWith(
          color: fIsSeeMore
              ? context.colors.primary
              : context.appColors.darkGreyColor?.withOpacity(0.9),
        ),
      ),
    );
  }
}
