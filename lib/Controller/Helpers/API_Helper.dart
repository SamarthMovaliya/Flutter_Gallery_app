import 'dart:convert';

import 'package:gallery_viewer_api_app/Modal/Modal_classes/Api_modal_class.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();

  fetchImagesFromApi({required String s}) async {
    http.Response response = await http.get(
      Uri.parse(
        'https://pixabay.com/api/?key=35722369-0ff268194d7105d16de321576&q=$s&image_type=photo&pretty=true',
      ),
    );

    if (response.statusCode == 200) {
      dynamic decodedData = jsonDecode(response.body);
      List imageList = decodedData['hits'];
      List<ApiModal> data = imageList
          .map(
            (e) => ApiModal.fromMaptoImageObject(data: e),
          )
          .toList();
      return data;
    }
  }
}
