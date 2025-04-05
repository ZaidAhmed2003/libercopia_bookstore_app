import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/data/models/book_model.dart';
import 'package:libercopia_bookstore_app/utils/constants/colors.dart';
import 'package:libercopia_bookstore_app/utils/constants/sizes.dart';
import 'package:libercopia_bookstore_app/utils/helpers/helper_functions.dart';

import '../../../../features/shop/controllers/cart_controller.dart';
import '../../../../features/shop/screens/cart/widgets/l_product_price_text.dart';
import '../../../../features/shop/screens/product_details/product_detail.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    final dark = LHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(book: book)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            // Book cover image container
            Container(
              height: 140,
              width: double.infinity, // Ensure full width
              decoration: BoxDecoration(
                color: const Color(0xFFB7B7B7),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    bottom: -15,
                    child: Image.network(
                      book.imageUrls.first,
                      fit: BoxFit.cover,
                      height: 140,
                    ),
                  ),
                ],
              ),
            ),
            // Book details container
            Expanded(
              // Added Expanded to take remaining space
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                height: 148,
                width: double.infinity, // Ensure full width
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: LSizes.sm,
                    vertical: LSizes.sm,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Author name at top
                      Text(
                        book.category.name,
                        style: TextStyle(
                          fontSize: 10.85,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: LSizes.xs),
                      // Main title
                      Text(
                        book.title,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 15.39,
                          fontWeight: FontWeight.w600,
                          color: Colors.white, // Added text color
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: LSizes.xs),
                      // Author name
                      Text(
                        book.author.name,
                        style: TextStyle(
                          fontSize: 10.99,
                          color: Colors.grey[400], // Added text color
                        ),
                      ),
                      const Spacer(),
                      // Price at bottom
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LProductPriceText(price: book.price.toString()),
                          ProductAddToCartButton(book: book),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // return GestureDetector(
    //   onTap: () => Get.to(() => ProductDetailScreen(book: book)),
    //   child: Container(
    //     width: 180,
    //     padding: const EdgeInsets.all(1),
    //     decoration: BoxDecoration(
    //       boxShadow: [LShadowStyle.verticalProductShadow],
    //       borderRadius: BorderRadius.circular(LSizes.productImageRadius),
    //       color: dark ? LColors.darkerGrey : LColors.white,
    //     ),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         /// Thumbnail, Favourite Button, Discount Tag
    //         LRoundedContainer(
    //           height: 175,
    //           padding: EdgeInsets.all(LSizes.sm),
    //           backgroundColor: dark ? LColors.dark : LColors.light,
    //           child: Stack(
    //             children: [
    //               /// Thumbnail Image
    //               LRoundedImage(
    //                 width: double.infinity,
    //                 imageUrl:
    //                     book.imageUrls.isNotEmpty ? book.imageUrls[0] : '',
    //                 isNetworkImage: true,
    //                 applyImageRadius: true,
    //               ),
    //
    //               /// Favourite Icon
    //               LFavouriteIcon(book: book),
    //             ],
    //           ),
    //         ),
    //
    //         const SizedBox(height: LSizes.spaceBtwItems / 2),
    //
    //         /// Details Section
    //         Padding(
    //           padding: const EdgeInsets.only(left: LSizes.sm),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               LProductTitleText(title: book.title, smallSize: true),
    //               const SizedBox(height: LSizes.spaceBtwItems / 2),
    //
    //               /// Author Name & Verified Icon
    //               Row(
    //                 children: [
    //                   Expanded(
    //                     child: Text(
    //                       book
    //                           .author
    //                           .name, // Replace with author name if available
    //                       overflow: TextOverflow.ellipsis,
    //                       style: Theme.of(context).textTheme.labelMedium,
    //                       maxLines: 1,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //
    //         /// Spacer to push content to the bottom
    //         const Spacer(),
    //
    //         /// Price & Add to Cart Button
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.only(left: LSizes.sm),
    //               child: LProductPriceText(price: book.price.toString()),
    //             ),
    //             ProductAddToCartButton(book: book),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

class ProductAddToCartButton extends StatelessWidget {
  const ProductAddToCartButton({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());

    return InkWell(
      onTap: () {
        final cartItem = cartController.convertBookToCartItem(book, 1);
        cartController.addOneToCart(cartItem);
      },
      child: Obx(() {
        final bookQuantityInCart = cartController.getBookQuantityInCart(
          book.id,
        );
        final isInCart = bookQuantityInCart > 0;

        return Container(
          decoration: BoxDecoration(
            color: isInCart ? LColors.primary : LColors.dark,
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
                  isInCart
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
