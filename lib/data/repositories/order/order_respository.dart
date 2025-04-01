import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/data/repositories/authentication/authentication_repository.dart';

import '../../models/order_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// get all orders related to current user
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      // Get the current user's ID
      final userId = AuthenticationRepository.instance.authUser!.uid;
      // Check if the user ID is not empty
      if (userId.isEmpty) {
        throw 'Unable to find user information, please try again later';
      }

      final result =
          await _db.collection('users').doc(userId).collection('orders').get();
      return result.docs
          .map((snapshot) => OrderModel.fromSnapshot(snapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching orders';
    }
  }

  /// Store a new User Order
  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('orders')
          .add(order.toJson());
    } catch (e) {
      throw 'Something went wrong while saving order';
    }
  }
}
