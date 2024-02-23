import 'dart:convert';

//import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../models/course.dart';

class ProductRepository {
  Future<Course> findByName(String name) async {
    try {
      // final response =
      //     await http.get(Uri.parse('http://localhost:8080/products?name=$name'));

      final response = await Dio().get('http://localhost:8080/products',
          queryParameters: {'name': name});

      // if (response.statusCode != 200) {
      //   throw Exception();
      // }

      //final data = jsonDecode(response.body) as List;
      if (response.data.isEmpty) {
        throw Exception('Not exists');
      }

      return Course.fromMap(response.data.first);
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }
}
