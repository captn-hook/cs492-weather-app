import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _darkMode = false;
  SharedPreferences? prefs;

  bool get darkMode => _darkMode;

  ThemeData _darkTheme = ThemeData.dark();
  ThemeData _lightTheme = ThemeData.light();

  ThemeData get darkTheme => _darkTheme;
  ThemeData get lightTheme => _lightTheme;

  ThemeMode get themeMode => _darkMode ? ThemeMode.dark : ThemeMode.light;


  void setColorScheme(Color color) {
    if (_darkMode) {
      _darkTheme = ThemeData(primaryColor: color);
    } else {
      _lightTheme = ThemeData(primaryColor: color);
    }
    prefs!.setInt('color', color.value);
    notifyListeners();
  }

  void toggleMode() {
    _darkMode = !_darkMode;
    if (prefs != null) {
      prefs!.setBool('darkMode', _darkMode);
    }

    notifyListeners();
  }

  SettingsProvider() {
    initPreferences();
  }

  void initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      _darkMode = prefs!.getBool('darkMode') ?? false;
      int color = prefs!.getInt('color') ?? Colors.blue.value;
      _darkTheme = ThemeData(primaryColor: Color(color));
      _lightTheme = ThemeData(primaryColor: Color(color));
    }
    notifyListeners();
  }
}