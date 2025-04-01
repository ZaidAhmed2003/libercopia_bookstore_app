import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/common/widgets/containers/rounded_container.dart';
import 'package:libercopia_bookstore_app/utils/constants/image_strings.dart';
import 'package:libercopia_bookstore_app/utils/constants/sizes.dart';
import 'package:libercopia_bookstore_app/utils/helpers/helper_functions.dart';
import 'package:libercopia_bookstore_app/utils/loaders/animation_loader.dart';

import '../../../../../navigation_menu.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../controllers/order_controller.dart';

class OrderListItems extends StatelessWidget {
  const OrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = LHelperFunctions.isDarkMode(context);
    final controller = Get.put(OrderController());

    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (_, snapshot) {
        /// Nothing Found Widget
        final emptyWidget = LAnimationLoaderWidget(
          text: 'Whoops! No Orders Yet!',
          animation: LImages.orderCompletedAnimation,
          showAction: true,
          actionText: 'Let\'s fil it',
          onActionPressed: () => Get.to(() => const NavigationMenu()),
        );

        /// Helper Function: Handle Loader, No record, Or Error Message
        final response = LCloudHelperFunctions.checkMultiRecordState(
          snapshot: snapshot,
          nothingFound: emptyWidget,
        );

        if (response != null) return response;

        /// Congratulations Record Found.
        final orders = snapshot.data!;
        return ListView.separated(
          shrinkWrap: true,
          itemCount: orders.length,
          separatorBuilder:
              (_, __) => const SizedBox(height: LSizes.spaceBtwItems),
          itemBuilder: (_, index) {
            final order = orders[index];
            return LRoundedContainer(
              showBorder: true,
              padding: const EdgeInsets.all(LSizes.md),
              backgroundColor: dark ? LColors.dark : LColors.light,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Row 1
                  Row(
                    children: [
                      /// Icon
                      Icon(Iconsax.ship),
                      SizedBox(width: LSizes.spaceBtwItems / 2),

                      /// Status & Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.orderStatusText,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.apply(
                                color: LColors.primary,
                                fontSizeDelta: 1,
                              ),
                            ),
                            Text(
                              order.formattedOrderDate,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),

                      /// 3 Icon
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Iconsax.arrow_right_34,
                          size: LSizes.iconSm,
                        ),
                      ),
                    ],
                  ),

                  /// Row 2
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            /// Icon
                            Icon(Iconsax.tag),
                            SizedBox(width: LSizes.spaceBtwItems / 2),

                            /// Status & Date
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    order.id,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),

                            /// 3 Icon
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Iconsax.arrow_right_34,
                                size: LSizes.iconSm,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: LSizes.spaceBtwItems),

                      Expanded(
                        child: Row(
                          children: [
                            /// Icon
                            Icon(Iconsax.tag),
                            SizedBox(width: LSizes.spaceBtwItems / 2),

                            /// Status & Date
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Shipping Date',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    order.formattedDeliveryDate,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),

                            /// 3 Icon
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Iconsax.arrow_right_34,
                                size: LSizes.iconSm,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
