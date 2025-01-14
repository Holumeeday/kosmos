import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/common_widgets/custom_app_bar.dart';
import 'package:playkosmos_v3/common_widgets/custom_text_form_fields.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

class AddEmailPage extends StatefulWidget {
  const AddEmailPage({super.key});

  @override
  State<AddEmailPage> createState() => _AddEmailPageState();
}

class _AddEmailPageState extends State<AddEmailPage> {

   final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controller when the widget is removed
    _emailController.dispose();
    super.dispose();
  }

  // Validator function
  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email address is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(
        fElevation: 0,
        fTitle: Text(
          'Add Email Address',
          style: context.textTheme.displayLarge,
        ),
        fLeading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [

         const VSpace(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomTextFormField(
              fTextController: _emailController,
              fHintText: 'Enter your email address',
              fValidator: _emailValidator,
              fTextType: TextInputType.emailAddress,
            ),
          ),
          const VSpace(10),
          // const Text('We’re sending you a secret code to prove this email address is really yours, Keep an eye out!')
          
        ],
      ),
    );
  }
}