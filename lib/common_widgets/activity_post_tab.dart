import 'package:flutter/material.dart';
import 'package:playkosmos_v3/enums/activity_source_enum.dart';
import 'package:playkosmos_v3/extensions/context_extension.dart';

///This slides between activity and post tab
///
///@author: Godwin Mathias
class ActivityPostTab extends StatelessWidget {
  /// This slides between activity and post and also changes the activity or post view source
  /// This must be in a sliver as its a sliver app bar.
  const ActivityPostTab({
    super.key,
    required this.fActivitySource,
    required this.fOnSelectActivitySource,
  });

  /// Selected activity source
  final ActivitySourceEnum fActivitySource;

  /// On select activity source
  final ValueChanged<ActivitySourceEnum> fOnSelectActivitySource;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 0,
      pinned: true,
      stretch: true,
      scrolledUnderElevation: 0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(
          context.scaleWithTextFactor(2, 75),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Container(
            color: context.appColors.darkGreyColor?.withOpacity(0.15),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 12,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Activity - status switch
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: TabBar(
                      isScrollable: true,
                      labelStyle: context.textTheme.bodyMedium,
                      indicatorWeight: 4,
                      labelColor: context.colors.primary,
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabAlignment: TabAlignment.start,
                      indicator: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: context.colors.primary))),
                      tabs: [
                        Tab(
                          height: context.scaleWithTextFactor(2, 33),
                          text: context.loc.activity,
                        ),
                        Tab(
                          height: context.scaleWithTextFactor(2, 33),
                          text: context.loc.post,
                        ),
                      ],
                    ),
                  ),

                  // View type switch
                  CustomDropdown(
                    defaultValue: fActivitySource,
                    onChanged: fOnSelectActivitySource,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final ActivitySourceEnum defaultValue;
  final Function(ActivitySourceEnum) onChanged;

  const CustomDropdown({
    super.key,
    required this.defaultValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<ActivitySourceEnum>(
      value: defaultValue,
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
      items: ActivitySourceEnum.values.map((option) {
        return DropdownMenuItem<ActivitySourceEnum>(
          value: option,
          child: Text(
            context.loc.setActivitySource(option.name),
            style: context.appTextTheme.buttonMedium,
          ),
        );
      }).toList(),
      // Styling for the dropdown
      underline: Container(),
      icon: const Icon(Icons.keyboard_arrow_down),
      alignment: Alignment.centerRight,
    );
  }
}
