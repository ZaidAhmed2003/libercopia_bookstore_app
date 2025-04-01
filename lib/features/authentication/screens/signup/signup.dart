import 'package:flutter/material.dart';
import 'package:libercopia_bookstore_app/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:libercopia_bookstore_app/utils/constants/text_strings.dart';

import '../../../../utils/constants/sizes.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(LSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Add this line
            children: [
              /// Title
              Text(
                LTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: LSizes.spaceBtwSections),

              /// Form
              const LSignupForm(),
            ],
          ),
        ),
      ),
    );
  }
}
