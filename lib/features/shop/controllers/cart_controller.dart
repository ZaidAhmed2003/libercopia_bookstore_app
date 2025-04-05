import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/data/models/book_model.dart';
import 'package:libercopia_bookstore_app/utils/local_storage/storage_utility.dart';
import 'package:libercopia_bookstore_app/utils/popups/loaders.dart';

import '../../../data/models/cart_item_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  // Variables
  final noOfCartItems = 0.obs;
  RxDouble totalAmount = 0.0.obs;
  RxInt bookQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  CartController() {
    /// when CartController created it calls loadCartItems() method for retrieving items from the storage.
    loadCartItems();
  }

  // Add items in the cart
  void addToCart(BookModel book) {
    // Quantity Check
    if (bookQuantityInCart.value < 1) {
      LLoaders.customToast(message: 'Select Quantity');
      return;
    }

    // check the stock of book
    if (book.stock < 1) {
      LLoaders.warningSnackBar(
        message: 'Selected Book is Out of Stock.',
        title: 'Oh Snap!',
      );
      return;
    }

    // convert the book to cartItem
    final selectedCartItem = convertBookToCartItem(
      book,
      bookQuantityInCart.value,
    );

    // check if already added in cart
    int index = cartItems.indexWhere(
      (item) => item.bookId == selectedCartItem.bookId,
    );

    if (index >= 0) {
      cartItems[index].quantity += selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();

    LLoaders.customToast(message: 'Your Book has been added to cart');
  }

  void addOneToCart(CartItemModel cartItem) {
    int index = cartItems.indexWhere((item) => item.bookId == cartItem.bookId);
    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(cartItem);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel cartItem) {
    int index = cartItems.indexWhere((item) => item.bookId == cartItem.bookId);
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        // if quantity == 1 show remove dialog
        removeFromCartDialog(index);
      }
    } else {
      // if item is not found
      LLoaders.customToast(message: 'Item not found in cart.');
    }
    updateCart();
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'remove book',
      middleText: 'Are you sure you want to remove this book?',
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
        LLoaders.customToast(message: 'Book removed from cart');
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }

  /// This Function covert bookModel to a CartItem
  CartItemModel convertBookToCartItem(BookModel book, int quantity) {
    return CartItemModel(
      bookId: book.id,
      title: book.title,
      price: book.price,
      quantity: quantity,
      image: book.imageUrls.first,
      authorId: book.author.id,
    );
  }

  void updateCart() {
    updateCartTotals();
    saveCartItem();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfCartItems = 0;

    for (var item in cartItems) {
      calculatedTotalPrice += item.price * item.quantity.toDouble();
      calculatedNoOfCartItems += item.quantity;
    }
    totalAmount.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfCartItems;
  }

  void saveCartItem() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    LLocalStorage.instance().saveData('cartItems', cartItemStrings);
  }

  void loadCartItems() {
    final cartItemStrings = LLocalStorage.instance().readData<List<dynamic>>(
      'cartItems',
    );
    if (cartItemStrings != null) {
      cartItems.assignAll(
        cartItemStrings
            .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
      updateCartTotals();
    }
  }

  int getBookQuantityInCart(String bookId) {
    final foundItem = cartItems
        .where((item) => item.bookId == bookId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  void clearCart() {
    bookQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}
