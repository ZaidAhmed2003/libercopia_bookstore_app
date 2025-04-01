import 'package:flutter/material.dart';
import 'package:libercopia_bookstore_app/common/widgets/images/l_circular_image.dart';
import 'package:libercopia_bookstore_app/common/widgets/texts/product_title_text.dart';
import 'package:libercopia_bookstore_app/features/shop/screens/cart/widgets/l_product_price_text.dart';
import 'package:libercopia_bookstore_app/utils/constants/sizes.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../data/models/book_model.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';

class LProductMetaData extends StatelessWidget {
  final BookModel book; // Accept book as a parameter

  const LProductMetaData({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    /// Calculate discount price (if applicable)
    final discountedPrice = (book.price * 0.75).toStringAsFixed(2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price (Conditional Discount)
        Row(
          children: [
            if (book.isFeatured) // Show discount only for featured books
              LRoundedContainer(
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
            if (book.isFeatured) const SizedBox(width: LSizes.spaceBtwItems),

            /// Original Price (if discounted)
            if (book.isFeatured)
              Text(
                '\$${book.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleSmall!.apply(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            if (book.isFeatured) const SizedBox(width: LSizes.spaceBtwItems),

            /// Final Price
            LProductPriceText(
              price: book.isFeatured ? discountedPrice : book.price.toString(),
              isLarge: true,
            ),
          ],
        ),
        const SizedBox(height: LSizes.spaceBtwItems / 1.5),

        /// Title
        LProductTitleText(title: book.title),
        const SizedBox(height: LSizes.spaceBtwItems / 1.5),

        /// Stock Status
        Row(
          children: [
            LProductTitleText(title: 'Status'),
            const SizedBox(width: LSizes.spaceBtwItems),
            Text(
              book.stock > 0 ? 'In Stock' : 'Out of Stock',
              style: Theme.of(context).textTheme.titleMedium!.apply(
                color: book.stock > 0 ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: LSizes.spaceBtwItems / 1.5),

        /// Author (Dynamically Fetched)
        Row(
          children: [
            LCircularImage(
              image: book.author.photoUrl,
              width: 32,
              height: 32,
              imageType: ImageType.network,
            ),
            const SizedBox(width: LSizes.spaceBtwItems),
            Text(
              book.author.name, // Replace with actual author name lookup later
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),

        const SizedBox(height: LSizes.spaceBtwItems / 1.5),
        Text(book.description),
      ],
    );
  }
}
