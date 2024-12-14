import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
This displays shows the reaction icons for reacting to a post
@author: Ugochukwu Umeh
*/
class ReactionIcons extends StatefulWidget {
  /// When a new reaction is clicked
  final ValueChanged<ReactionIconTypeEnum?> fToReact;

  /// To close thumb
  final VoidCallback fClose;

  /// The selected reaction icon
  final ReactionIconTypeEnum? fSelectedIcon;

  const ReactionIcons({
    super.key,
    required this.fToReact,
    required this.fClose,
    this.fSelectedIcon,
  });

  @override
  State<ReactionIcons> createState() => _ReactionIconsState();
}

class _ReactionIconsState extends State<ReactionIcons> {
  /// The selected icon
  ReactionIconTypeEnum? get _fSelectedReaction => widget.fSelectedIcon;

  ///The list view controller
  late ScrollController _fScrollController;

  ///If the scroll is at the left
  bool _dIsScrollAtLeft = true;

  ///If the scroll is at the right
  bool _dIsScrollAtRight = false;

  /// The item extent
  final double _fReactionItemExtent = 50;

  @override
  void initState() {
    super.initState();
    _fScrollController = ScrollController(
      keepScrollOffset: false,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _toSelectedIcon());
    _fScrollController.addListener(_scrollListener);
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  /// Scrolling to the selected icon
  void _toSelectedIcon() {
    if (_fSelectedReaction == null) return;
    // Gets the position of the selected icon
    const List<ReactionIconTypeEnum> reactionList = ReactionIconTypeEnum.values;
    num position = reactionList.indexOf(_fSelectedReaction!);
    // To ensure that the position is in the middle
    position -= 1.5;
    // This multiplies a clamped position to the item extent i.e item size
    final double scrollPosition =
        position.clamp(0, reactionList.length) * _fReactionItemExtent;
    _fScrollController.jumpTo(scrollPosition);
  }

  /// The scroll listener
  void _scrollListener() {
    if (_fScrollController.position.atEdge) {
      if (_fScrollController.position.pixels == 0) {
        setState(() {
          _dIsScrollAtLeft = true;
          _dIsScrollAtRight = false;
        });
      } else {
        setState(() {
          _dIsScrollAtLeft = false;
          _dIsScrollAtRight = true;
        });
      }
    } else {
      setState(() {
        _dIsScrollAtLeft = false;
        _dIsScrollAtRight = false;
      });
    }
  }

  /// Scroll to the last icon at the right side
  void _scrollIconRightDirection() {
    _fScrollController.animateTo(
      _fScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Scroll to the last icon at the left side
  void _scrollIconLeftDirection() {
    _fScrollController.animateTo(
      _fScrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _fScrollController.removeListener(_scrollListener);
    _fScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.loc.reactionsList,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: context.colors.secondary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Left direction scroll
            MergeSemantics(
              child: Semantics(
                label: context.loc.scrollListToTheLeft,
                child: IconButton(
                  onPressed: _scrollIconLeftDirection,
                  icon: const Icon(
                    Icons.keyboard_arrow_left_rounded,
                  ),
                  color: _dIsScrollAtLeft
                      ? context.colors.tertiary
                      : context.colors.secondary,
                  iconSize: 30,
                ),
              ),
            ),

            // List of icons
            Flexible(
              child: SizedBox(
                height: 64,
                child: ListView.builder(
                  controller: _fScrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: ReactionIconTypeEnum.values.length,
                  itemExtent: _fReactionItemExtent,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (_, int index) {
                    final ReactionIconTypeEnum reactionIconEnum =
                        ReactionIconTypeEnum.values[index];
                    final String reactionIcon =
                        reactionIconEnum.getReactionIcon();
                    return Semantics(
                      label: context.loc.reaction(reactionIconEnum.name),
                      child: GestureDetector(
                        onTap: () {
                          // Close the list
                          widget.fClose();
                          // Calls the react function
                          widget.fToReact(reactionIconEnum == _fSelectedReaction
                              ? null
                              : reactionIconEnum);
                          SemanticsService.announce(
                            context.loc.reactionButtonPressed(
                                context.loc.reaction(reactionIconEnum.name)),
                            Directionality.of(context),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (reactionIconEnum == _fSelectedReaction)
                                ? context.colors.secondary.withOpacity(0.5)
                                : Colors.transparent,
                          ),
                          child: SvgPicture.asset(
                            reactionIcon,
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Right direction scroll
            MergeSemantics(
              child: Semantics(
                label: context.loc.scrollListToTheRight,
                child: IconButton(
                  onPressed: _scrollIconRightDirection,
                  icon: const Icon(
                    Icons.keyboard_arrow_right_rounded,
                  ),
                  color: _dIsScrollAtRight
                      ? context.colors.tertiary
                      : context.colors.secondary,
                  iconSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
