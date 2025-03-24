import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/data/models/cart_model.dart';
import 'package:libercopia_bookstore_app/data/repositories/cart/cart_repository.dart';
import 'package:libercopia_bookstore_app/utils/popups/loaders.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  final _cartRepository = Get.put(CartRepository());
  final Rx<CartModel> cart = CartModel.empty().obs;
  final RxDouble totalAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _cartRepository.getCartStream().listen((updatedCart) {
      cart.value = updatedCart;
      calculateTotal();
    });
  }

  /// Calculate Cart Total
  void calculateTotal() {
    totalAmount.value = cart.value.items.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  /// Add to Cart
  Future<void> addToCart(String bookId, int quantity) async {
    try {
      await _cartRepository.addToCart(bookId, quantity);
      LLoaders.successSnackBar(title: 'Added to Cart');
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  /// Remove from Cart
  Future<void> removeFromCart(String bookId) async {
    try {
      await _cartRepository.removeFromCart(bookId);
      LLoaders.successSnackBar(title: 'Removed from Cart');
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
