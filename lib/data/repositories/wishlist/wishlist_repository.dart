import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../models/wishlist_model.dart';

class WishlistRepository extends GetxController {
  static WishlistRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get current user's ID
  String get _userId {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');
    return user.uid;
  }

  /// Firestore reference for the user's wishlist sub-collection
  CollectionReference _wishlistCollection(String userId) =>
      _db.collection('users').doc(userId).collection('wishlist');

  /// Get user wishlist stream
  Stream<List<WishlistModel>> getWishlistStream() {
    return _wishlistCollection(_userId).snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => WishlistModel.fromSnapshot(doc)).toList(),
    );
  }

  /// Check if a book is in the wishlist
  Future<bool> isBookInWishlist(String bookId) async {
    final doc = await _wishlistCollection(_userId).doc(bookId).get();
    return doc.exists;
  }

  /// Add to wishlist
  Future<void> addToWishlist(String bookId) async {
    try {
      await _wishlistCollection(_userId).doc(bookId).set({
        'userId': _userId,
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
  Future<void> removeFromWishlist(String bookId) async {
    try {
      await _wishlistCollection(_userId).doc(bookId).delete();
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } catch (e) {
      throw 'Failed to remove from wishlist: ${e.toString()}';
    }
  }
}
