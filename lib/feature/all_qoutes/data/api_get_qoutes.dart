
import 'package:dio/dio.dart';

import '../../../core/utits/api_base_url.dart';
import 'model_qoute.dart';
class ApiServiceQouteList {
  final Dio dio = Dio();

  Future<QuoteResponse> getQoutes() async {
    try {
      final response = await dio.get(baseUrl);

      print('API Response: ${response.data}');

      if (response.statusCode == 200) {
        return QuoteResponse.fromJson(response.data);
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print('API Error: $e');
      throw Exception("Error: $e");
    }
  }
}
