import 'package:flutter/cupertino.dart';
import 'package:gallery_viewer_api_app/Modal/Modal_classes/Category_Modal_class.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryIndex index = CategoryIndex(i: 0);

  changeCategory({required int indexValue}) {
    index.i = indexValue;
    return index;
    notifyListeners();
  }
}
