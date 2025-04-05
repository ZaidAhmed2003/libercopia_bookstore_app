import 'package:flutter/material.dart';
import 'package:libercopia_bookstore_app/admin/screens/authors/widgets/add_author_form.dart';

import '../../../common/widgets/appbar/appbar.dart';
import '../../../utils/constants/sizes.dart';

class AddAuthorScreen extends StatelessWidget {
  const AddAuthorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LAppbar(title: Text('Add Author'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(LSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Form
              AddAuthorForm(),
            ],
          ),
        ),
      ),
    );
  }
}
