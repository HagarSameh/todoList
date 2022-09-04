import 'package:aaa/components/components.dart';
import 'package:aaa/layout/Task.dart';
import 'package:aaa/layout/search_task.dart';
import 'package:aaa/layout/settings.dart';
import 'package:aaa/modules/archived_Tasks/calender.dart';
import 'package:aaa/modules/doneTasks/doneTask.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/constants.dart';
import '../modules/new_Tasks/new_Tasks.dart';
import 'package:sqflite/sqflite.dart';
import 'package:aaa/layout/language.dart';
import 'package:aaa/layout/theme.dart';
import 'package:provider/provider.dart';
import 'package:aaa/layout/theme_shared_prefrences.dart';
import 'package:aaa/layout/ThemeModel.dart';
import 'package:aaa/util/notification_service.dart';
import 'package:aaa/layout/database.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();

}
class _HomeState extends State<Home> {
  late final NotificationService notificationService;
  List<Widget> screens=[
     newtask(),
     const calender(), //changed this name
    const settings(),
  ];
  List<String> titles=[
    'New Tasks',
    'Calender',
    'Settings',
  ];

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  }
   var database;
  String? gender; //no radio button will be selected

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  int currentIndex=0;
  //for check box
  bool check1 = false; //true for checked checkbox, false for unchecked one

  bool isBottomSheetShown = false;
  String dropdownValue ="Work";

  late IconData fabIcon=Icons.edit;
  var titleController =TextEditingController();
  var timeController =TextEditingController();
  var dateController =TextEditingController();
  @override
  void initState(){
    super.initState();
    notificationService = NotificationService();
    listenToNotificationStream();
    notificationService.initializePlatformNotifications();
    createDatabase();
}
  void listenToNotificationStream() => notificationService.behaviorSubject.listen((payload) {Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>const calender())
        );});
  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(titles[currentIndex]),
        //what i added
        backgroundColor: const Color(0xff458050),
        elevation: 0.0,
        actions: [
          // Navigate to the Search Screen
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const SearchPage())),
              icon: const Icon(Icons.search))
        ],
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
              child:  const DrawerHeader(
                decoration: BoxDecoration(
                  color:  const Color(0xff458050)
                ),
                child: Text('Drawer Header',
                  style: TextStyle(fontSize: 20,color:Colors.white,fontWeight: FontWeight.w600),),

              ),
            ),

            ListTile(
              title: const Text('Language',
                  style: TextStyle(fontSize: 20,color: const Color(0xff458050),fontWeight: FontWeight.w600)),
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
                  style: TextStyle(fontSize: 20,color:const Color(0xff458050),fontWeight: FontWeight.w600)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const theme()),);
              },
            ),

            ListTile(
              title: const Text('Home',
                  style: TextStyle(fontSize: 20,
                      color: const Color(0xff458050),
                      fontWeight: FontWeight.w600)),
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
      body: tasks.isEmpty ? const Center(child: CircularProgressIndicator()): screens[currentIndex],

      floatingActionButton: FloatingActionButton(
        backgroundColor:  const Color(0xff458050) ,
        onPressed: () //async
        {
          if (isBottomSheetShown)
          {
            if(formKey.currentState!.validate()){
              insertDatabase(
                title: titleController.text,
                date: dateController.text,
                time: timeController.text,

              ).then((value) {
                getDataFromDatabase(database).then((value) {
                  Navigator.pop(context);
                  setState((){
                    isBottomSheetShown=false;
                    fabIcon=Icons.edit;
                  });
                  tasks = value;
                  print(tasks);
                });
              });
            }
          }
          else
          {
//Colors.black26
            scaffoldKey.currentState?.showBottomSheet(
                  (context) => Container(
                    color: themeNotifier.isDark == true ? Colors.black26 : Colors.white,
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            // onTap: (){
                            //   print('timing taped');
                            // },
                            keyboardType: TextInputType.text,
                            validator: ( value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                            }
                            return null;
                          },
                            controller: titleController,
                        decoration: const InputDecoration(labelText: 'task title',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.title,),
                          ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            onTap: (){
                              showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.parse('2022-09-29'),).then((value)
                              {
                                print(DateFormat.yMMMd().format(value!));
                                dateController.text=DateFormat.yMMMd().format(value!);
                              });
                            },
                            keyboardType: TextInputType.datetime,
                            validator: ( value) {
                              if (value == null || value.isEmpty) {
                                return 'date must not be empty ';
                              }
                              return null;
                            },
                            controller: dateController,
                            decoration: const InputDecoration(labelText: 'task date ',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.calendar_today,),
                            ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          TextFormField(
                            onTap: (){
                              showTimePicker(context: context, initialTime: TimeOfDay.now(),).then((value) {
                                setState(() {
                                  timeController.text = value!.format(context);
                                });
                                print(value?.format(context));
                              });
                            },
                            keyboardType: TextInputType.datetime,
                            validator: ( value) {
                              if (value == null || value.isEmpty) {
                                return 'time must not be empty ';
                              }
                              return null;
                            },
                            controller: timeController,
                            decoration: const InputDecoration(labelText: 'Settings ',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.access_time,),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          const SizedBox(
                            height: 15,
                          ),
                          //notification check box
                         Row(
                           children: <Widget>[
                             Checkbox(
                               value: check1,
                               onChanged: (bool? newValue) async {
                                 setState(() {
                                   check1 = newValue!;
                                   print(check1);
                                 });
                                 await notificationService.showScheduledLocalNotification(
                                     id: 1,
                                     title: "Drink Water",
                                     body: "Time to drink some water!",
                                     payload: "You just took water! Huurray!",
                                     seconds: 2);
                               },
                             ),
                             const Text("Send Me a notification",
                                 style: TextStyle(fontSize: 20,color:Colors.black54,fontWeight: FontWeight.w600)),

                           ],
                         ),
                          const SizedBox(
                        height: 15,
                      ),

              ],
            ),
                    ),
                  ),
              elevation: 10.0,
            ).closed.then((value) {
              isBottomSheetShown=false;
              setState(()
              {
                fabIcon=Icons.edit;
              });
            });
            isBottomSheetShown=true;
            setState((){
              fabIcon=Icons.add;
            }
            );
          }
//           try{
//             var name = await getName();
//             print(name);
//             print('ahmed');
//             throw('error occurred');
//           }catch{
// print('error ${error.toString()}');
// //           }
//           getName().then((value) {
//             print(value);
//             print('ahmed');
//             // throw('error occurred');
//           }).catchError((error){
//            print('error is ${error.toString()}');
//           }
//           );
        },
        child :  Icon(
          fabIcon,
         ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor:const Color(0xff458050),
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index){
          setState((){
            currentIndex=index;
          });


        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu
          ),
            label: 'Task',
          ),

          //What I changed
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month,),
            label: 'Calender',
          ),
          //------------------------------------
          BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline,),
            label:'Settings',
          ),
          //--------------------------------
        ],
      ),
    );
    });
  }

  // Future <String> getName() async{
  //   return 'Ahmed Samy';
  // }

  void createDatabase() async{
    database = await openDatabase('todo.db',
      version: 1,
      onCreate: (database, version){
        print ('database created');
      },
      onOpen: (database){
        getDataFromDatabase(database).then((value) {
          tasks = value;
          print(tasks);
        });
        print ('database opened');
        database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)').then((value){
          print('table created');
        }).catchError((error){
          print('error occurred when creating table ${error.toString()}');
        });
      },
    );
  }

  Future insertDatabase({required String title, required String time, required String date}) async{
    return await database.transaction((txn) async {
      txn.rawInsert('INSERT INTO tasks(title, date, time, status)VALUES("$title","$date","$time","New")').then((value) {
        print('$value inserted successfully');
      }).catchError((error){
        print('error occurred when inserting in database ${error.toString()}');
      });
      return null;
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async{
    return  await database.rawQuery('SELECT * FROM tasks');

  }

  void updateData({required String status, required int id,}) async {
    database!.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value)
    {
      getDataFromDatabase(database);
    });
  }

  void deleteData({required int id,}) async {
    database!.rawDelete('DELETE FROM tasks WHERE id=', [id])
        .then((value)
    {
      getDataFromDatabase(database);
    });
  }
}
// Search Page
class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        // The search area here
          backgroundColor: const Color(0xff458050),
          elevation: 0.0,
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        /* Clear the search field */
                      },
                    ),
                    hintText: 'Search...',
                    hintStyle: const TextStyle(color: Colors.black45),
                    border: InputBorder.none),
                onSubmitted: ( value) {
                  Get.to(() => search_Task());
                  Task.title = _controller.text;
                  Task.time="4:43AM";
                  Task.date="Sep 6,2022";



                }
              ),

            ),

          )
      ),
    );
  }

}