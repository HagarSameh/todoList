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

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();

}
class _HomeState extends State<Home> {
  
  List<Widget> screens=[
     newtask(),
     const doneTask(),
     const calender(), //changed this name
  ];
  List<String> titles=[
    'New Tasks',
    'Done Tasks',
    'Calender',
  ];
  late Database database;
  String? gender; //no radio button will be selected

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  int currentIndex=0;
  //for check box
  bool? check1 = false; //true for checked checkbox, false for unchecked one

  bool isBottomSheetShown = false;
  String dropdownValue ="Work";

  late IconData fabIcon=Icons.edit;
  var titleController =TextEditingController();
  var timeController =TextEditingController();
  var dateController =TextEditingController();
  @override
  void initState(){
    super.initState();
    createDatabase();
}
  @override
  Widget build(BuildContext context) {

    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(titles[currentIndex]),
        //what i added
        backgroundColor: const Color(0xFFa48c84),
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
                  color: Colors.brown
                ),
                child: Text('Drawer Header',
                  style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w300),),

              ),
            ),

            ListTile(
              title: const Text('Language',
                  style: TextStyle(fontSize: 20,color: Colors.brown,fontWeight: FontWeight.w300)),
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
                  style: TextStyle(fontSize: 20,color:Colors.brown,fontWeight: FontWeight.w300)),
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
      body: tasks.isEmpty ? const Center(child: CircularProgressIndicator()): screens[currentIndex],

      floatingActionButton: FloatingActionButton(
        onPressed: () //async
        {
          if (isBottomSheetShown)
          {
            if(formKey.currentState!.validate()){
              insertDatabase(
                title: titleController.text,
                date: dateController.text,
                time: timeController.text,
                category: gender.toString(),
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
                            decoration: const InputDecoration(labelText: 'task time ',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.watch_later_outlined,),
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
                          //notification check box
                          CheckboxListTile( //checkbox positioned at left
                            value: check1,
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (bool? value) {
                              setState(() {
                                check1 = value;
                                print(value);
                              });
                            },
                            title: const Text("Do you really want to learn Flutter?"),
                          ),
                          const SizedBox(
                        height: 15,
                      ),
                          const Text("Category"),
                          Center(
                          child: SizedBox(
                              width: 250,
                              child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: dropdownValue,
                                  items: <String>['Work','Entertainment','Shopping','Going out']
                                      .map<DropdownMenuItem<String>>((String value){
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child:Text(value)
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue){
                                    setState(() {
                                      dropdownValue = newValue??dropdownValue;
                                    });
                                  }
                              )
                          )
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
          BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline,),
         label:'Done',
          ),
          //--------------------------------
          //What I changed
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month,),
            label: 'Calender',
          ),
          //------------------------------------

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
  Future insertDatabase({
    required String title,
    required String time,
    required String date,
    required String category,
  }) async{
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
}
// Search Page
class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController(text: 'initial value');

    return Scaffold(
      appBar: AppBar(
        // The search area here
          backgroundColor: const Color(0xFFa48c84),
          elevation: 0.0,
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(

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
              ),
            ),
          )
      ),
    );
  }
}