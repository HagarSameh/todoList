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
import 'package:aaa/layout/theme.dart';
import 'package:aaa/layout/ThemeModel.dart';

class language extends StatefulWidget {
  const language({Key? key}) : super(key: key);
  @override
  State<language> createState() => _languageState();

}
class _languageState extends State<language> {

  List<Widget> screens = [
    newtask(),
    const doneTask(),
    const calender(), //changed this name
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
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
          title: const Text("Languges"),
          backgroundColor: const Color(0xff458050),
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
                      color:const Color(0xff458050)
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
                        color: const Color(0xff458050),
                        fontWeight: FontWeight.w300)),
                onTap: () {}
              ),
              ListTile(
                title: const Text('Theme',
                    style: TextStyle(fontSize: 20,
                        color: const Color(0xff458050),
                        fontWeight: FontWeight.w300)),
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const theme()),);

                },
              ),

              ListTile(
                title: const Text('Home',
                    style: TextStyle(fontSize: 20,
                        color: const Color(0xff458050),
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
           /* image: DecorationImage(
              image: AssetImage("images/bck.png"),
              fit: BoxFit.cover,
            ),*/
          ),
          child:  Center(
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
                    onTap: () {},
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(0xff458050),
                      ),
                      child: const Center(child: Text('English',
                        style:
                        TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300),),)
                    ),
                  )
                 /* ElevatedButton(onPressed: () {

                  }, style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.white)
                              )
                          )
                      ), child: const Text("English",
                          style:
                          TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300),
                      )
                  ),*/
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    width: 280,
                    height: 45,
                    child:
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color(0xff458050),
                        ),
                        child: const Center(child: Text('Arabic', style:
                        TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300),)),
                      ),
                    )
                   /* ElevatedButton(onPressed: () {
                    }
                        ,style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.white)
                                )
                            )
                        ),  child: const Text("Arabic",
                            style: TextStyle(fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w300)))*/
                ),

              ],

            ),
          ),
        ),

      );
    });
  }

}

/*
import 'package:flutter/material.dart';
class theme extends StatelessWidget {
  const theme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
      children: <Widget>[
        Container(
      width: 280,
      height: 45,
        child: ElevatedButton(onPressed:()
        {

        }
            , child: const Text("Light Theme" ,
                style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w300))
        ),
      ),
    Container(
    width: 280,
    height: 45,
    child:
        ElevatedButton(onPressed:()
        {

        }
            , child: const Text("Dark Theme" ,
                style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w300)))
    ),
      ],

    ),
        );
  }
}*/
