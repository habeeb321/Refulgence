import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:refulgence/core/app_config.dart';
import 'package:refulgence/core/constants.dart';
import 'package:refulgence/screens/home_screen/model/products_model.dart';

class HomeService {
  static final Dio dio = Dio();

  static Future<List<ProductsModel>?> getProducts() async {
    try {
      Response response = await dio.get('${AppConfig.baseUrl}/posts');

      if (response.statusCode == 200 && response.data != null) {
        Constants.logger.i('Success: ${response.data}');

        List<dynamic> data;

        if (response.data is String) {
          data = jsonDecode(response.data);
        } else if (response.data is List) {
          data = response.data;
        } else {
          Constants.logger
              .e('Unexpected response format: ${response.data.runtimeType}');
          return null;
        }

        return data.map((item) => ProductsModel.fromJson(item)).toList();
      } else {
        Constants.logger.e('HTTP Error: Status code ${response.statusCode}');
      }
    } catch (e) {
      Constants.logger.e('getProducts Error : $e');
    }
    return null;
  }
}
