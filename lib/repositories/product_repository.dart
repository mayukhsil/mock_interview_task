import 'package:mock_interview_task/models/product_model.dart';
import 'package:mock_interview_task/services/api_services.dart';

abstract class IProductRepository{
  Future<ProductModel> getProducts();
}

class ProductRepository implements IProductRepository{

  static const String _fetchProductURL = '/products';
  final APIService _apiService = APIService.instance;

  @override
  Future<ProductModel> getProducts() async {
    var result = await _apiService.getData(_fetchProductURL);
    print(result);
    return ProductModel.fromJson(result);
  }

}