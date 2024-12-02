import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:wallpaper_app/models/photo_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
// final dio = Dio();

// class ImageRepo {
//   final Dio _dio = Dio(BaseOptions(
//     baseUrl: 'https://api.example.com',
//     connectTimeout: const Duration(seconds: 5),
//     receiveTimeout: const Duration(seconds: 3),
//   ));

//   Future<Either<String, List<UnsplashPhoto>>> getProducts() async {
//     try {
//       final response = await _dio.get('/products');
//       return (response.data as List)
//           .map((json) => UnsplashPhoto.fromJson(json))
//           .toList();
//     } catch (e) {
//       throw _handleError(e);
//     }
//   }
// }
class PhotoRepo {
  Future<List<UnsplashPhoto>> fetchPhotos(
      {required int page, required int perPage}) async {
    log('api requested');
    final response = await http.get(
      Uri.parse(
          'https://api.unsplash.com/photos/?client_id=Xq2ECd-hdDq8E6pW8C6g7VmNbOJwmVbutih9niMl2VM&page=$page&per_page=$perPage'),
    );

    if (response.statusCode == 200) {
      log('200');
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => UnsplashPhoto.fromJson(data)).toList();
    } else {
      log('faild api call');
      throw Exception('Failed to load photos');
    }
  }
}
