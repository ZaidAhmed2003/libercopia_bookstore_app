import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../data/models/book_model.dart';
import '../../../../../utils/constants/sizes.dart';

class LRatingAndShare extends StatelessWidget {
  final BookModel book; // Add book parameter

  const LRatingAndShare({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Rating
        Row(
          children: [
            const Icon(Iconsax.star5, color: Colors.amber, size: 24),
            SizedBox(width: LSizes.spaceBtwItems / 2),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: book.rating.toStringAsFixed(1), // Use book rating
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextSpan(
                    text:
                        ' (${book.reviewsCount ?? 0})', // Optional reviews count
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),

        /// Share
        IconButton(
          onPressed: () {
            // TODO: Implement share functionality
          },
          icon: const Icon(Icons.share, size: LSizes.iconMd),
        ),
      ],
    );
  }
}
