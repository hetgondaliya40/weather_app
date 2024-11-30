import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../Controllers/weather_controller.dart';
import '../routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
      designSize: Size(width, height),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => WeatherController(),
          ),
        ],
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: Routes.myRoutes,
          );
        },
      ),
    );
  }
}
