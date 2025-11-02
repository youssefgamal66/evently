import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String lang = "en";

  void changeTheme(String mode) {
    if (mode == "light"){
      themeMode = ThemeMode.light;
      notifyListeners();
      saveTheme();
    }
    if (mode == "dark"){
      themeMode = ThemeMode.dark;
      notifyListeners();
      saveTheme();
    }
  }

  Future<void> saveTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("theme", themeMode.name);
  }

  Future<void> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String theme = prefs.getString("theme") ?? "light";
    if (theme == "light") {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
  }

  void changeLang(String? newLang) {
    if (newLang != null) {
      lang = newLang;
      notifyListeners();
      savelanguage();
    } else {
      lang = (lang == "English") ? "Arabic" : "English";
      notifyListeners();
      savelanguage();
    }
  }

  Future<void> savelanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("lang", lang);
  }

  Future<void> getlanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    lang = prefs.getString("lang") ?? "en";
  }
}
