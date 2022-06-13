part of 'product_provider.dart';


class ProductNotifier extends StateNotifier<ProductState> {
  ProductNotifier({
    required IProductRepository productRepository,
  })   : _productRepository = productRepository,
        super(const ProductState.initial()){
    getProducts();
  }

  final IProductRepository _productRepository;

  Future<void> getProducts() async {
    state = const ProductState.loading();
    try {
      final product = await _productRepository.getProducts();
      state = ProductState.data(product: product);
    } catch (_) {
      state = const ProductState.error('Error!');
    }
  }
}