import 'package:flutter/material.dart';

import '../Views/HomePage/home_page.dart';
import '../Views/SplashScreen/splash_screen.dart';

class Routes {
  static String splashScreen = "/";
  static String homePage = "home_page";
  static String detailPage = "detail_page";

  static Map<String, WidgetBuilder> myRoutes = {
    splashScreen: (context) => const SplashScreen(),
    homePage: (context) => const HomePage(),
  };
}
