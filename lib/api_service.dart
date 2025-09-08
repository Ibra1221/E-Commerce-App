import 'package:dio/dio.dart';
import 'models/product_model.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
      validateStatus: (status) {
        return status != null && status >= 200 && status < 600;
      },
    ),
  );

  Future<Response> fetchProducts(String path) async {
    try {
      final response = await _dio.get(path);
      if (response.statusCode == 200) {
        print('Successfully retrieved data!');
      } else {
        print("${response.statusCode} occurred!");
      }
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to fetch products: ${e.message}');
    }
  }

  Future<List<ProductModel>> loadProducts() async {
    
      final response = await fetchProducts('/products');
      if(response.statusCode == 200){
      final rawList = response.data['products'] as List;
      final list = rawList.map((e) => ProductModel.fromJson(e)).toList();
      return list;
  }
     else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<ProductModel>> loadPopularProducts() async {
   final response = await fetchProducts('/products?sortBy=rating&order=desc');
      if(response.statusCode == 200){
      final rawList = response.data['products'] as List;
      final list = rawList.map((e) => ProductModel.fromJson(e)).toList();
      return list;
  }
     else {
      throw Exception('Failed to load products');
    }
  }
  }


