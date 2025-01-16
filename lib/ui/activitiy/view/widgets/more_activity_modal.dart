import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/sizes.dart';

class MoreActivityModal extends StatelessWidget {
  const MoreActivityModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
     
      
      const VSpace(10),
       _buildMenuItem(
        context,
        label: 'Manage',
        onTap: () {
          // Handle "Manage" action
        },
      ),
      Divider(height: 1, color: Colors.grey[300]),
       _buildMenuItem(
        context,
        label: 'Copy Activity URL',
        onTap: () {
          // Handle "Manage" action
        },
      ),
      Divider(height: 1, color: Colors.grey[300]),
       _buildMenuItem(
        context,
        label: 'Edit',
        onTap: () {
          // Handle "Manage" action
        },
      ),
       Divider(height: 1, color: Colors.grey[300]),
      _buildMenuItem(
        context,
        label: 'Cancel Activity',
        onTap: () {
          // Handle "Cancel Activity" action
        },
        textColor: Colors.red,
      ),
      
    ]);
  }
}

Widget _buildMenuItem(
    BuildContext context, {
    required String label,
    required VoidCallback onTap,
    Color textColor = Colors.black,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: textColor,
          ),
        ),
      ),
    );
  }
