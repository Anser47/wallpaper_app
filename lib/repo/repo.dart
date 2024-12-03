import 'dart:developer';

import 'package:wallpaper_app/models/photo_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class PhotoRepo {
  Future<List<UnsplashPhoto>> fetchPhotos(
      {required int page, required int perPage}) async {
    final response = await http.get(
      Uri.parse(
          'https://api.unsplash.com/photos/?client_id=Xq2ECd-hdDq8E6pW8C6g7VmNbOJwmVbutih9niMl2VM&page=$page&per_page=$perPage'),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => UnsplashPhoto.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
