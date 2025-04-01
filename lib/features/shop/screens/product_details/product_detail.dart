import 'package:flutter/material.dart';
import 'package:libercopia_bookstore_app/common/widgets/appbar/appbar.dart';
import 'package:libercopia_bookstore_app/data/models/book_model.dart';
import 'package:libercopia_bookstore_app/features/shop/screens/home/widgets/cart_counter_icon.dart';

class ProductDetailScreen extends StatelessWidget {
  final BookModel book; // Store the book instance

  const ProductDetailScreen({super.key, required this.book}); // Assign book

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LAppbar(
        title: Text(book.category.name),
        showBackArrow: true,
        actions: [LCartCounterIcon()],
      ),
    );

    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         /// 1- Product Image
    //         LProductDetailImage(book: book), // Pass book to image widget
    //         /// 2- Product Details
    //         Padding(
    //           padding: const EdgeInsets.only(
    //             right: LSizes.defaultSpace,
    //             left: LSizes.defaultSpace,
    //             bottom: LSizes.defaultSpace,
    //           ),
    //           child: Column(
    //             children: [
    //               /// Rating and Share Button
    //               LRatingAndShare(book: book), // Pass book
    //               /// Price, Title, Stock & Author
    //               LProductMetaData(book: book), // Pass book
    //               /// TODO: Add Checkout, Description, Reviews
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
