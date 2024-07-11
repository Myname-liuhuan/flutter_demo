import 'package:flutter/material.dart';

class ImageTileProvider with ChangeNotifier {
  String _imageUrl;
  double _width;
  double _height;

  ImageTileProvider({
    required String imageUrl,
    double width = 100.0,
    double height = 100.0,
  })  : _imageUrl = imageUrl,
        _width = width,
        _height = height;

  String get imageUrl => _imageUrl;
  double get width => _width;
  double get height => _height;

  void updateImageUrl(String newUrl) {
    _imageUrl = newUrl;
    notifyListeners();
  }

  void updateDimensions(double newWidth, double newHeight) {
    _width = newWidth;
    _height = newHeight;
    notifyListeners();
  }
}
