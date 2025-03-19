import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/features/personalization/screens/address/widgets/single_address.dart';
import 'package:libercopia_bookstore_app/utils/constants/colors.dart';
import 'package:libercopia_bookstore_app/utils/constants/sizes.dart';

import '../../../../common/widgets/appbar/dart/appbar.dart';
import 'add_new_address.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LAppbar(
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        backgroundColor: LColors.primary,
        child: Icon(Iconsax.add, color: LColors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(LSizes.defaultSpace),
          child: Column(
            children: [
              LSingleAddress(selectedAddress: true),
              LSingleAddress(selectedAddress: false),
            ],
          ),
        ),
      ),
    );
  }
}
