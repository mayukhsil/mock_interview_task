part of 'cart_provider.dart';


class CartChangeNotifier with ChangeNotifier {

  List<Product> productList = [];

  //setters
  int _cartTotal = 0;

  //getters
  int get cartTotal => _cartTotal;

  CartChangeNotifier() {
    refresh();
  }

  void refresh() {
    productList = [];
    notifyListeners();
  }

  void addToCart(Product product) {
    if(!productList.contains(product)){
      productList.add(product);
      calculateTotal();
      notifyListeners();
    }
  }

  void removeFromCart(Product product) {
    if (productList.contains(product)) {
      productList.remove(product);
      calculateTotal();
      notifyListeners();
    }
  }

  void calculateTotal() {
    _cartTotal = 0;
    for (var element in productList) {
      _cartTotal += element.price!;
    }
    notifyListeners();
  }

  void clearCart() {
    refresh();
    calculateTotal();
    notifyListeners();
  }

  void checkoutCart(){
    refresh();
    calculateTotal();
    notifyListeners();
  }

}