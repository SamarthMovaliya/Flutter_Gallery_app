import 'package:flutter/material.dart';

class ApiModal {
  final String image;

  ApiModal({
    required this.image,
  });

  factory ApiModal.fromMaptoImageObject({required Map data}) {
    return ApiModal(image: data['largeImageURL']);
  }
}
