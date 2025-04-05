import 'package:flutter/material.dart';
import 'package:libercopia_bookstore_app/admin/screens/categories/widgets/add_category_form.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LAppbar(title: Text('Add Category'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(LSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Form
              AddCategoryForm(),
            ],
          ),
        ),
      ),
    );
  }
}
