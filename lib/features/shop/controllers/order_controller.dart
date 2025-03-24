import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/data/models/order_model.dart';
import 'package:libercopia_bookstore_app/utils/popups/loaders.dart';

import '../../../data/repositories/order/order_respository.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final _orderRepository = Get.put(OrderRepository());
  final RxList<OrderModel> allOrders = <OrderModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserOrders();
  }

  /// Fetch User Orders
  Future<void> fetchUserOrders() async {
    try {
      isLoading.value = true;
      _orderRepository.getUserOrders().listen((orders) {
        allOrders.assignAll(orders);
      });
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Create Order
  Future<void> createOrder(OrderModel order) async {
    try {
      await _orderRepository.createOrder(order);
      LLoaders.successSnackBar(title: 'Order Placed!');
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Order Failed', message: e.toString());
    }
  }

  /// Cancel Order
  Future<void> cancelOrder(String orderId) async {
    try {
      await _orderRepository.cancelOrder(orderId);
      LLoaders.successSnackBar(title: 'Order Cancelled');
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
