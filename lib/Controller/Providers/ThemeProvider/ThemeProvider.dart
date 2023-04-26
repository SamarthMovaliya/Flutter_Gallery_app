import 'package:flutter/cupertino.dart';
import 'package:gallery_viewer_api_app/Modal/Modal_classes/Theme_Modal.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeModal themeModal = ThemeModal(isDark: false);

  void changeTheTheme() {
    themeModal.isDark = !themeModal.isDark;
    notifyListeners();
  }
}
