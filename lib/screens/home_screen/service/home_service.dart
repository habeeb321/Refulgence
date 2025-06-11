import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:refulgence/core/app_config.dart';
import 'package:refulgence/core/constants.dart';
import 'package:refulgence/screens/home_screen/model/products_model.dart';

class HomeService {
  static final Dio dio = Dio();

  static Future<ProductsModel?> getProducts() async {
    try {
      Response response = await dio.get('${AppConfig.baseUrl}/posts');

      if (response.statusCode == 200 && response.data != null) {
        Constants.logger.i('Success: ${response.data}');
        if (response.data is String) {
          Map<String, dynamic> data = jsonDecode(response.data);
          return ProductsModel.fromJson(data);
        } else if (response.data is Map) {
          Map<String, dynamic> data = response.data;
          return ProductsModel.fromJson(data);
        } else {
          Constants.logger.e('Unexpected response format');
          return null;
        }
      } else {
        Constants.logger.e('HTTP Error: Status code ${response.statusCode}');
      }
    } catch (e) {
      Constants.logger.e('getProducts Error : $e');
    }
    return null;
  }
}
