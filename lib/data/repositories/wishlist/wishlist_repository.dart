import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../models/wishlist_model.dart';

class WishlistRepository extends GetxController {
  static WishlistRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  /// Get user wishlist stream
  Stream<List<WishlistModel>> getWishlistStream() {
    return _db
        .collection('Wishlists')
        .where('userId', isEqualTo: _auth.currentUser?.uid)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => WishlistModel.fromSnapshot(doc))
                  .toList(),
        );
  }

  /// Get specific wishlist item
  Future<WishlistModel?> getWishlistItem(String bookId) async {
    final snapshot =
        await _db
            .collection('wishlists')
            .where('userId', isEqualTo: _auth.currentUser?.uid)
            .where('bookId', isEqualTo: bookId)
            .limit(1)
            .get();

    return snapshot.docs.isNotEmpty
        ? WishlistModel.fromSnapshot(snapshot.docs.first)
        : null;
  }

  /// Add to wishlist
  Future<void> addToWishlist(String bookId) async {
    try {
      await _db.collection('Wishlists').add({
        'userId': _auth.currentUser?.uid,
        'bookId': bookId,
        'addedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } catch (e) {
      throw 'Failed to add to wishlist: ${e.toString()}';
    }
  }

  /// Remove from wishlist
  Future<void> removeFromWishlist(String wishlistItemId) async {
    try {
      await _db.collection('Wishlists').doc(wishlistItemId).delete();
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } catch (e) {
      throw 'Failed to remove from wishlist: ${e.toString()}';
    }
  }

  /// Check if book is in wishlist
  Future<bool> isBookInWishlist(String bookId) async {
    final snapshot =
        await _db
            .collection('Wishlists')
            .where('userId', isEqualTo: _auth.currentUser?.uid)
            .where('bookId', isEqualTo: bookId)
            .limit(1)
            .get();

    return snapshot.docs.isNotEmpty;
  }
}
