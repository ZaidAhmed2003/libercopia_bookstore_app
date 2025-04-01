import 'package:flutter/material.dart';
import 'package:libercopia_bookstore_app/common/widgets/products/favourite_icon/favourite_icon.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/l_curved_edges_widget.dart';
import '../../../../../data/models/book_model.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class LProductDetailImage extends StatelessWidget {
  final BookModel book; // Add book parameter

  const LProductDetailImage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final dark = LHelperFunctions.isDarkMode(context);

    return LCurvedEdgesWidget(
      child: Container(
        color: dark ? LColors.darkerGrey : LColors.light,
        child: Stack(
          children: [
            /// Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(LSizes.productImageRadius * 2),
                child: Center(
                  child: Image.network(
                    book.imageUrls.first,
                  ), // Use book's image
                ),
              ),
            ),

            /// App Bar Icons
            LAppbar(showBackArrow: true, actions: [LFavouriteIcon(book: book)]),
          ],
        ),
      ),
    );
  }
}
