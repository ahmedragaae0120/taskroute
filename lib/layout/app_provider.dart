import 'package:flutter/material.dart';

class appProvider extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;
  changeMode() {
    if (mode == ThemeMode.light) {
      mode = ThemeMode.dark;
    } else {
      mode = ThemeMode.light;
    }
    notifyListeners();
  }
}
