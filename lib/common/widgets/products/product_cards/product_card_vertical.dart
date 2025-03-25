import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/common/styles/shadow_styles.dart';
import 'package:libercopia_bookstore_app/common/widgets/containers/rounded_container.dart';
import 'package:libercopia_bookstore_app/common/widgets/images/l_rounded_image.dart';
import 'package:libercopia_bookstore_app/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:libercopia_bookstore_app/common/widgets/products/product_cards/product_price_text.dart';
import 'package:libercopia_bookstore_app/common/widgets/texts/product_title_text.dart';
import 'package:libercopia_bookstore_app/data/models/book_model.dart';
import 'package:libercopia_bookstore_app/utils/constants/colors.dart';
import 'package:libercopia_bookstore_app/utils/constants/sizes.dart';
import 'package:libercopia_bookstore_app/utils/helpers/helper_functions.dart';

import '../../../../features/shop/controllers/cart_controller.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    // final _bookController = BookController.instance;
    // final _cartController = CartController.instance;

    final dark = LHelperFunctions.isDarkMode(context);

    /// Container with side paddings, color, edges, radius, and shadows
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [LShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(LSizes.productImageRadius),
          color: dark ? LColors.darkerGrey : LColors.white,
        ),
        child: Column(
          children: [
            /// Thumbnail, Whitelist Button, Discount Tag
            LRoundedContainer(
              height: 175,
              padding: EdgeInsets.all(LSizes.sm),
              backgroundColor: dark ? LColors.dark : LColors.light,
              child: Stack(
                children: [
                  /// Thumnail Image
                  LRoundedImage(
                    width: double.infinity,
                    imageUrl: book.imageUrls[0],
                    isNetworkImage: true,
                    applyImageRadius: true,
                  ),

                  /// Sale Tag
                  Positioned(
                    top: 12,
                    child: LRoundedContainer(
                      radius: LSizes.sm,
                      backgroundColor: LColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: LSizes.sm,
                        vertical: LSizes.xs,
                      ),
                      child: Text(
                        '25%',
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge!.apply(color: LColors.black),
                      ),
                    ),
                  ),

                  /// Favourite Icon Button
                  LFavouriteIcon(),
                ],
              ),
            ),

            const SizedBox(height: LSizes.spaceBtwItems / 2),

            /// Details
            Padding(
              padding: const EdgeInsets.only(left: LSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LProductTitleText(title: book.title, smallSize: true),
                  SizedBox(height: LSizes.spaceBtwItems / 2),
                  Row(
                    children: [
                      Text(
                        book.authorId,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium,
                        maxLines: 1,
                      ),
                      const SizedBox(width: LSizes.xs),
                      const Icon(
                        Iconsax.verify5,
                        size: LSizes.iconXs,
                        color: LColors.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Price
                Padding(
                  padding: const EdgeInsets.only(left: LSizes.sm),
                  child: LProductPriceText(price: '33'),
                ),

                /// ADD to Cart Button
                ProductAddToCartButton(book: book),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProductAddToCartButton extends StatelessWidget {
  const ProductAddToCartButton({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return InkWell(
      onTap: () {
        final cartItem = cartController.convertBookToCartItem(book, 1);
        cartController.addOneToCart(cartItem);
      },
      child: Obx(() {
        final bookQuantityInCart = cartController.getBookQuantityInCart(
          book.id,
        );
        return Container(
          decoration: BoxDecoration(
            color: bookQuantityInCart > 0 ? LColors.primary : LColors.dark,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(LSizes.cardRadiusMd),
              bottomRight: Radius.circular(LSizes.productImageRadius),
            ),
          ),
          child: SizedBox(
            width: LSizes.iconLg * 1.2,
            height: LSizes.iconLg * 1.2,
            child: Center(
              child:
                  bookQuantityInCart > 0
                      ? Text(
                        bookQuantityInCart.toString(),
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.apply(color: LColors.white),
                      )
                      : const Icon(Iconsax.add, color: LColors.white),
            ),
          ),
        );
      }),
    );
  }
}
