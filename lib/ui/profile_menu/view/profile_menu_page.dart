import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/context_extension.dart';

import 'widgets/menu_item.dart';
import 'widgets/menu_item_helpers.dart';
import 'widgets/menu_searchbar.dart';

class ProfileMenuPage extends StatelessWidget {
  const ProfileMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        fElevation: 0,
        fTitle: Text('Menu', style: context.textTheme.displayLarge,),
        fLeading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MenuSearchbar(),
              const VSpace(15),
             const TextWithBackground(fText: 'Account'),
             ...menuItems(context, accountItems),
             const TextWithBackground(fText: 'Preference'),     
             ...menuItems(context, preferenceItems),
              const TextWithBackground(fText: 'Support & Feedback'),  
             ...menuItems(context, supportItems),
             const TextWithBackground(fText: 'Terms & Policies'), 
             ...menuItems(context, termsItems),
              const TextWithBackground(fText: 'Login'), 
             ...menuItems(context, loginItem)



            
            ],
          ),
        ),
      ),
    );
  }
}


