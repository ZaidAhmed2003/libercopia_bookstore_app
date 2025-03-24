import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../models/order_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> createOrder(OrderModel order) async {
    try {
      await _db.runTransaction((transaction) async {
        // Create order
        final orderRef = _db.collection('orders').doc(order.id);
        transaction.set(orderRef, order.toJson());

        // Update book stock
        for (final item in order.items) {
          final bookRef = _db.collection('Books').doc(item.bookId);
          transaction.update(bookRef, {
            'stock': FieldValue.increment(-item.quantity),
            'updatedAt': FieldValue.serverTimestamp(),
          });
        }

        // Clear cart
        transaction.delete(_db.collection('carts').doc(_auth.currentUser?.uid));
      });
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } catch (e) {
      throw 'Failed to create order: ${e.toString()}';
    }
  }

  Stream<List<OrderModel>> getUserOrders() {
    return _db
        .collection('orders')
        .where('userId', isEqualTo: _auth.currentUser?.uid)
        .orderBy('orderDate', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList(),
        );
  }

  Future<void> cancelOrder(String orderId) async {
    try {
      await _db.collection('orders').doc(orderId).update({
        'status': 'cancelled',
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } catch (e) {
      throw 'Failed to cancel order: ${e.toString()}';
    }
  }
}
