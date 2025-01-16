import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

import 'menu_item.dart';


List<Widget> menuItems(BuildContext context, List<MenuItem> items) {
  return items.map((item) {
    return GestureDetector(
      onTap: ()=> item.onTap(context),
      child: ListTile(
        leading: item.icon is IconData
            ? Icon(item.icon as IconData, color: Colors.grey)
            : item.icon as Widget, 
        title: Text(
          item.title!,
          style: context.textTheme.bodySmall,
        ),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ),
    );
  }).toList();
}
