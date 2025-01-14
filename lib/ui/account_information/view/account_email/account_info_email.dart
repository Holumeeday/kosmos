import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

import '../../../../assets_gen/assets.gen.dart';
import '../../../../common_widgets/common_widgets.dart';
import '../../../../utils/app_router/app_router.dart';

class AccountInfomationEmailPage extends StatelessWidget {
  const AccountInfomationEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        fElevation: 0,
        fTitle: Text( 
          'Email Address',
          style: context.textTheme.displayLarge,
        ),
        fLeading:  IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            const Divider(
              height: 0.1,
              thickness: 0.5,
              color: Colors.grey,
            ),
           const VSpace(15),
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12,),
              child: Container(
                height:20,
                width: 110,
                decoration: BoxDecoration(
                  color: context.appColors.reviewColor,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  child: Text('Primary Email', style: context.textTheme.bodySmall, textAlign: TextAlign.center,),
                ),
              ),
            ),
      
           const VSpace(20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('Jandoe@mail.com', style: context.textTheme.bodyLarge,),
            ),

           const VSpace(20),

           const Divider(
            height: 0.1,
            thickness: 0.5,
            color: Colors.grey,
          ),

          const VSpace(10),
          GestureDetector(
            onTap: ()=>  context.push(AppRoute.addemailPath),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, ),
              child: Row(
                children: [
                  Container(
                    height: 27,
                    width: 25,
                    decoration:BoxDecoration(
                     
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: SvgPicture.asset(
                      Assets.svgs.icons.addEmail.path,
                      width: 20,
                      height: 20,
                    ),
                  ),
                const  HSpace(10),       
                  Text('Add New Email Address', style: context.textTheme.bodyMedium,)
                ],
              ),
            ),
          ),
          
         
        ],
      ),
    );
  }
}