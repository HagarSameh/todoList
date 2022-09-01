import 'package:aaa/modules/archived_Tasks/calender.dart';
import 'package:aaa/modules/doneTasks/doneTask.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/constants.dart';
import '../modules/new_Tasks/new_Tasks.dart';
import 'package:sqflite/sqflite.dart';
import 'package:aaa/layout/language.dart';
import 'package:aaa/layout/home.dart';
import 'package:aaa/layout/theme_shared_prefrences.dart';
import 'package:aaa/layout/ThemeModel.dart';

class theme extends StatefulWidget {
  const theme({Key? key}) : super(key: key);
  @override
  State<theme> createState() => _themeState();

}
class _themeState extends State<theme> {

  List<Widget> screens = [
    newtask(),
    const doneTask(),
    const calender(), //changed this name
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Calender',
  ];
  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  int currentIndex = 0;
  bool isBottomSheetShown = false;
  late IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text("theme"),
          backgroundColor: const Color(0xFFa48c84),
          elevation: 0.0,
        ),

        //-------------------------------
        //what I Added
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 90,
                child: const DrawerHeader(
                  decoration: BoxDecoration(
                      color: Colors.brown
                  ),
                  child: Text('Drawer Header',
                    style: TextStyle(fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),),

                ),
              ),

              ListTile(
                title: const Text('Language',
                    style: TextStyle(fontSize: 20,
                        color: Colors.brown,
                        fontWeight: FontWeight.w300)),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const language()),);
                },
              ),
              ListTile(
                title: const Text('Theme',
                    style: TextStyle(fontSize: 20,
                        color: Colors.brown,
                        fontWeight: FontWeight.w300)),
                onTap: () {},
              ),


              ListTile(
                title: const Text('Home',
                    style: TextStyle(fontSize: 20,
                        color: Colors.brown,
                        fontWeight: FontWeight.w300)),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()),);
                },
              ),
            ],
          ),
        ),

        //-------------------------------
        body:
        Container(
          decoration: const BoxDecoration(
          /*  image: DecorationImage(
              image: AssetImage("images/bck.png"),
              fit: BoxFit.cover,
            ),*/
          ),
          child:
        Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 300,
              ),
              Container(
                width: 280,
                height: 45,
                child:
                GestureDetector(
                  onTap: () {themeNotifier.isDark=false;},
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xFFa48c84),
                    ),
                    child: Center(child: Text('Light Theme', style:
                    TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300),)),
                  ),
                )

              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: 280,
                  height: 45,
                  child:
                  GestureDetector(
                    onTap: () {themeNotifier.isDark=true;
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(0xFFa48c84),
                      ),
                      child: Center(child: Text('Dark Theme', style:
                      TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300),)),
                    ),
                  )
              ),
            ],

          ),
        ),
      ),
      );
    });
  }

}
