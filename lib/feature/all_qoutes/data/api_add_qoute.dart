import 'package:dio/dio.dart';
// api_service.dart
class ApiServiceAddQuoteList {
  final Dio dio;

  ApiServiceAddQuoteList({required this.dio});

  Future<void> addQuote(String quote, String author) async {
    try {
      final response = await dio.post(
        'https://dummyjson.com/quotes/add',
        data: {
          'quote': quote,
          'author': author,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      print('Add Quote Response: ${response.data}');

      if (response.statusCode == 201) {
        print('Quote added successfully');
      } else {
        throw Exception("Failed to add quote");
      }
    } catch (e) {
      print('API Error: $e');
      throw Exception("Error: $e");
    }
  }
}


