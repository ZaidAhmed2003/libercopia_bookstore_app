import 'package:flutter/material.dart';
import 'package:libercopia_bookstore_app/features/shop/screens/order/widgets/order_list_items.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Appbar
      appBar: LAppbar(
        showBackArrow: true,
        title: Text(
          'My Order',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(LSizes.defaultSpace),

        /// Orders
        child: OrderListItems(),
      ),
    );
  }
}
