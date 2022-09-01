import 'package:aaa/layout/ThemeModel.dart';
import 'package:aaa/modules/Massenger/Massenger.dart';
import 'package:aaa/layout/home.dart';
import 'package:aaa/modules/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeModel.isDark ? ThemeData.dark() : ThemeData.light(),
          home: Home(),
      );
    })
    );
  }
}
