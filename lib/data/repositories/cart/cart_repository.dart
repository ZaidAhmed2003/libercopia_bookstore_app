import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../models/book_model.dart';
import '../../models/cart_item_model.dart';
import '../../models/cart_model.dart';

class CartRepository extends GetxController {
  static CartRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Stream<CartModel> getCartStream() {
    return _db
        .collection('carts')
        .doc(_auth.currentUser?.uid)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.exists
                  ? CartModel.fromSnapshot(snapshot)
                  : CartModel.empty(),
        );
  }

  Future<void> addToCart(String bookId, int quantity) async {
    try {
      final userCartRef = _db.collection('carts').doc(_auth.currentUser?.uid);

      await _db.runTransaction((transaction) async {
        final snapshot = await transaction.get(userCartRef);
        final bookSnapshot = await transaction.get(
          _db.collection('Books').doc(bookId),
        );

        // Verify stock
        final book = BookModel.fromSnapshot(bookSnapshot);
        if (book.stock < quantity) {
          throw 'Insufficient stock available';
        }

        // Update cart
        if (snapshot.exists) {
          final cart = CartModel.fromSnapshot(snapshot);
          final existingItem = cart.items.firstWhere(
            (item) => item.bookId == bookId,
            orElse:
                () => CartItemModel(
                  bookId: bookId,
                  title: book.title,
                  price: book.price,
                  quantity: 0,
                  image: book.imageUrls.first,
                ),
          );

          final newQuantity = existingItem.quantity + quantity;
          if (newQuantity > 10) throw 'Maximum quantity per item is 10';

          final updatedItems =
              cart.items.where((i) => i.bookId != bookId).toList()
                ..add(existingItem.copyWith(quantity: newQuantity));

          transaction.update(userCartRef, {
            'items': updatedItems.map((i) => i.toJson()).toList(),
            'updatedAt': FieldValue.serverTimestamp(),
          });
        } else {
          transaction.set(userCartRef, {
            'userId': _auth.currentUser?.uid,
            'items': [
              CartItemModel(
                bookId: bookId,
                title: book.title,
                price: book.price,
                quantity: quantity,
                image: book.imageUrls.first,
              ).toJson(),
            ],
            'createdAt': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
          });
        }
      });
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } catch (e) {
      throw 'Failed to add to cart: ${e.toString()}';
    }
  }

  Future<void> removeFromCart(String bookId) async {
    try {
      await _db.collection('carts').doc(_auth.currentUser?.uid).update({
        'items': FieldValue.arrayRemove([
          {'bookId': bookId},
        ]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } catch (e) {
      throw 'Failed to remove item: ${e.toString()}';
    }
  }
}
