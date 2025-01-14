import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/account_information/view/widgets/account_information_list_tile.dart';
import '../../../common_widgets/common_widgets.dart';
import 'widgets/account_information_items.dart';

class AccountInformationPage extends StatelessWidget {
  const AccountInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        fElevation: 0,
        fTitle: Text(
          'Account Information',
          style: context.textTheme.displayLarge,
        ),
        fLeading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView.builder(
        itemCount:
            accountInfoItems.length + 1, // Include space for the top divider
        itemBuilder: (context, index) {
          if (index == 0) {
            // Add a top divider
            return const Divider(
              height: 0.1,
              thickness: 0.5,
              color: Colors.grey,
            );
          }
          final item =
              accountInfoItems[index - 1]; // Adjust index for the divider
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AccountInformationListTile(
                title: item['title'],
                isDestructive: item['isDestructive'],
                onTap: () {
                  item['onTap'](context); // Pass the context to the callback
                },
              ),
              // Add a bottom divider after the last item
              if (index == accountInfoItems.length)
                const Divider(
                  height: 0.1,
                  thickness: 0.5,
                  color: Colors.grey,
                ),
            ],
          );
        },
      ),
    );
  }
}
