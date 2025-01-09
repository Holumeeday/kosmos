import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/enums/location_type_enum.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/buddies/view/widgets/overlapping_profiles.dart';
import 'package:playkosmos_v3/ui/buddy_activities/widgets/activity_type.dart';
import 'package:playkosmos_v3/utils/theme/app_colors.dart';
class ActivityDetailsTab extends StatelessWidget {
  const ActivityDetailsTab({super.key, });

  @override
  Widget build(BuildContext context) {
    // Mock data for categories
    final categories = {
      "Daily": [
        "Monday (09-12-2024)\n12pm-3pm (3 hours)",
        "Wednesday (11-12-2024)\n10am-3pm (5 hours)",
        "Thursday (12-12-2024)\n1pm-4pm (3 hours)",
        "Friday (13-12-2024)\n9am-12pm (3 hours)",
        "Saturday (14-12-2024)\n11am-1pm (2 hours)",
        "Sunday (15-12-2024)\n2pm-5pm (3 hours)",
        "Monday (16-12-2024)\n4pm-7pm (3 hours)",
      ],
      "Ends on": [
        "Thursday (09-12-2024)\n12pm-3pm (3 hours)",
      ],
    };
    final taggedBuddies = ['', '', '', '', '', '', ''];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: getScreenHeight(context) * 0.6,
            color: Colors.red,
          ),
          const VSpace(21),
          TextWithBackground(fText: context.loc.title),
          content(Text(
              'Lorem ipsum dolor sit amet consectetur. At massa eu enim et ut. Tempus placerat est adipiscing leo felis et cursus. Curabitur id consectetur odio odio. Sed nun.',
              style: context.appTextTheme.body)),
          TextWithBackground(fText: context.loc.detailsText),
          content(
            Text('data', style: context.appTextTheme.body),
          ),
          TextWithBackground(fText: context.loc.type),
          Align(
            alignment: Alignment.centerLeft,
            child: content(
              const Wrap(
                direction: Axis.horizontal,
                spacing: 8,
                runSpacing: 8,
                children: [
                  ActivityType(typeString: "running"),
                  ActivityType(typeString: "classes"),
                ],
              ),
            ),
          ),
          TextWithBackground(fText: context.loc.location),
          content(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "(${context.loc.setLocationType(LocationTypeEnum.physical.name)})"),
              const VSpace(8),
              Text('42, Adebola street surulere, lagos Nigeria',
                  style: context.textTheme.headlineSmall!
                      .copyWith(color: context.colors.tertiary)),
            ],
          )),
          TextWithBackground(fText: context.loc.schedule),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            separatorBuilder: (context, index) => Divider(
              color: context.appColors.fDividerColor,
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              final categoryName = categories.keys.toList()[index];
              final items = categories[categoryName]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Title
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 12, right: 20, left: 20),
                    child: Text(
                      "($categoryName)",
                      style: context.appTextTheme.body,
                    ),
                  ),
                  // Items in rows of 2
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: (items.length / 2).ceil(),
                    separatorBuilder: (context, _) => Divider(
                      color: context.appColors.fDividerColor,
                      thickness: 1,
                    ),
                    itemBuilder: (context, rowIndex) {
                      final start = rowIndex * 2;
                      final end =
                          (start + 2 > items.length) ? items.length : start + 2;
                      final rowItems = items.sublist(start, end);

                      return IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, bottom: 10, right: 20, left: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // First Item in Row
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      rowItems[0],
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              color: context.colors.tertiary),
                                    ),
                                  ],
                                ),
                              ),
                              // Second Item in Row
                              if (rowItems.length > 1)
                                VerticalDivider(
                                  width: 20,
                                  thickness: 1,
                                  color: context.appColors.fDividerColor,
                                ),
                              if (rowItems.length > 1)
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        rowItems[1],
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                                color: context.colors.tertiary),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
          const VSpace(20),
          TextWithBackground(fText: context.loc.activityFee),
          content(
            Text(500.formatNumToDefaultCurrency()),
          ),
          TextWithBackground(fText: context.loc.taggedBuddies),
          content(Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
            decoration: BoxDecoration(
              // Set the background color, defaulting to reviewColor
              color:
                  //  const Color(0xffefefef),
                  const Color(0xff2F2F2F),
              // Add a subtle shadow for a raised appearance
              boxShadow: [
                BoxShadow(
                  color: context.colors.onSurface.withOpacity(0.06),
                  offset: const Offset(0, 6),
                  blurRadius: 10,
                ),
              ],
              // Round the edges of the container
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 42,
                  width: 150,
                  child: Stack(children: [
                    ...List.generate(
                        taggedBuddies.length > 5 ? 5 : taggedBuddies.length,
                        (index) {
                      return BuildProfileImage(
                        imageUrl: '',
                    
                        leftPosition: index * 27,
                        size: 40,
                      );
                    }),
                  ]),
                ),
                const HSpace(8),
                GestureDetector(
                  child: Row(
                    children: [
                      Text(
                        context.loc.seeAll,
                        style: context.appTextTheme.body!.copyWith(
                          color: context.colors.primary,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: context.colors.primary,
                        size: 15,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
          TextWithBackground(fText: context.loc.restrictionsToPost),
          content(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              restrictionLabel(context.loc.participantsAllowed, context),
              const VSpace(8),
              Text('100', style: context.appTextTheme.buttonMedium),
              const VSpace(16),
              restrictionLabel(context.loc.ageLimit, context),
              const VSpace(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("(${'Children'})",
                      style: context.textTheme.headlineSmall),
                  const VSpace(8),
                  Text('1year old - 12 years old',
                      style: context.textTheme.headlineSmall),
                ],
              ),
              const VSpace(16),
              restrictionLabel(context.loc.genderRestriction, context),
              const VSpace(8),
              Text(context.loc.none, style: context.appTextTheme.buttonMedium),
            ],
          )),
          TextWithBackground(fText: context.loc.insuranceToPost),
          content(Text(
            "(Yes) Medical bills will be covered for injured participant",
            style: context.textTheme.headlineSmall,
          )),
          TextWithBackground(fText: context.loc.otherInformationToPost),
          content(Text(
            "Lorem ipsum dolor sit amet consectetur. Et pellentesque morbi sit amet. Quam integer massa odio duis pulvinar consectetur dictum orci sod",
            style: context.textTheme.headlineSmall,
          )),
        ],
      ),
    );
  }

  Container restrictionLabel(String fText, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColor.fPrimaryGradient.map((element) {
            return element.withOpacity(0.15);
          }).toList(),
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(fText, style: context.textTheme.headlineSmall),
    );
  }

  Padding content(Widget child) => Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 21),
        child: child,
      );
}
