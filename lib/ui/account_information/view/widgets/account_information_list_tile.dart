import 'package:flutter/material.dart';

class AccountInformationListTile extends StatelessWidget {
  final String title;
  final bool isDestructive;
  final VoidCallback onTap;

  const AccountInformationListTile({
    required this.title,
    required this.isDestructive,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : Colors.black,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
