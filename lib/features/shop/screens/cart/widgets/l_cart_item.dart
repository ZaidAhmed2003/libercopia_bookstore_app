import 'package:flutter/material.dart';
import 'package:libercopia_bookstore_app/common/widgets/images/l_rounded_image.dart';

import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../data/models/cart_item_model.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class LCartItem extends StatelessWidget {
  const LCartItem({super.key, required this.cartItem});

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Image
        LRoundedImage(
          imageUrl: cartItem.image ?? '',
          height: 60,
          width: 60,
          padding: EdgeInsets.all(LSizes.sm),
          backgroundColor:
              LHelperFunctions.isDarkMode(context)
                  ? LColors.darkerGrey
                  : LColors.light,
          isNetworkImage: true,
        ),
        const SizedBox(width: LSizes.spaceBtwItems),

        // Title Price & Quantity
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: LProductTitleText(
                  title: cartItem.title ?? '',
                  maxLines: 1,
                ),
              ),

              const SizedBox(height: LSizes.sm),

              // Attributes
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Price: ',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        TextSpan(
                          text: cartItem.price.toString(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: LSizes.spaceBtwItems),

                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Quantity: ',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        TextSpan(
                          text: cartItem.quantity.toString(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
