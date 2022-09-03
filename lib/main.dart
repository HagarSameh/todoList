import 'package:aaa/layout/ThemeModel.dart';
import 'package:aaa/layout/first_page.dart';
import 'package:aaa/modules/Massenger/Massenger.dart';
import 'package:aaa/layout/home.dart';
import 'package:aaa/modules/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'layout/splashScreen.dart';
import 'modules/firsthome/aaa.dart';
import 'package:aaa/layout/language.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeModel(),
    child:Consumer(builder: (context, ThemeModel themeModel ,child) {
      return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeModel.isDark ? ThemeData.dark() : ThemeData.light(),
          home: SplashScreen(),

      );
    })
    );
  }
}
