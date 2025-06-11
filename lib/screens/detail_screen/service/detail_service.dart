import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:refulgence/core/app_config.dart';
import 'package:refulgence/core/constants.dart';
import 'package:refulgence/screens/detail_screen/model/comments_model.dart';

class DetailService {
  static final Dio dio = Dio();

  static Future<List<CommentsModel>?> getComments() async {
    try {
      Response response = await dio.get('${AppConfig.baseUrl}/comments');

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

        return data.map((item) => CommentsModel.fromJson(item)).toList();
      } else {
        Constants.logger.e('HTTP Error: Status code ${response.statusCode}');
      }
    } catch (e) {
      Constants.logger.e('getComments Error : $e');
    }
    return null;
  }
}
