import 'package:aaa/layout/ThemeModel.dart';
import 'package:aaa/layout/search_Task.dart';
import 'package:flutter/material.dart';
import 'package:aaa/components/components.dart';
import 'package:aaa/layout/database.dart';
import 'package:intl/intl.dart';
import 'package:aaa/layout/database.dart';
import 'package:sqflite/sqflite.dart';
class search_Task extends StatefulWidget {
  //const search_Task({Key? key}) : super(key: key);
  static  String title='' ;
  static  String time='' ;
  static  String date='' ;
  static  String category='' ;
  static int id=0;

  //,date,time,category;

  /*String title=data2().title;
  String date=data2().date;
  String time=data2().time;
  String category=data2().category;*/

  search_Task({Key? key}) : super(key: key);

  @override
  State<search_Task> createState() => _search_TaskState();
}

class _search_TaskState extends State<search_Task> {
  var titleController =TextEditingController();
  var timeController =TextEditingController();
  var dateController =TextEditingController();
  search_Task t=search_Task();
  String dropdownValue ="Work";
  int currentIndex=0;
  ThemeModel? themeNotifier;


  String newCategrory='';
  @override
  void initState(){
    super.initState();
    createDatabase();
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(

        appBar: AppBar(
          title:const Text("Search"),
          backgroundColor: const Color(0xff458050),
          elevation: 0.0,
        ),
        body:
        Padding(

          padding:  const EdgeInsets.all(5.0),
          child: SizedBox(
            height: 380,
            child:
            Expanded(
              child: Card(

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),

                ),
                color: themeNotifier?.isDark == true ? Colors.black26 :const Color(0xffe4eae4),
                elevation: 0,
                shadowColor: Colors.transparent,


                child:
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: 300,
                      child:
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: titleController,
                        decoration:  InputDecoration(labelText:'task1',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.title,),

                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 300,
                      child:
                      TextFormField(
                        onTap: (){ showTimePicker(context: context, initialTime: TimeOfDay.now(),).then((value) {
                          setState(() {
                            timeController.text = value!.format(context);
                          });
                          print(value?.format(context));
                        });},
                        keyboardType: TextInputType.datetime,
                        validator: ( value) {
                          if (value == null || value.isEmpty) {
                            return 'time must not be empty ';
                          }
                          return null;
                        },
                        controller: timeController,
                        decoration:  InputDecoration(labelText: '11:49 AM',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.watch_later_outlined,),
                        ),
                      ),
                    ),
                   
                    SizedBox(
                      width: 300,
                      child:
                      TextFormField(
                        onTap: (){ showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.parse('2022-09-29'),).then((value)
                        {
                          print(DateFormat.yMMMd().format(value!));
                          dateController.text=DateFormat.yMMMd().format(value!);
                        });},
                        keyboardType: TextInputType.datetime,
                        /* validator: ( value) {
                                   if (value == null || value.isEmpty) {
                                     return 'date must not be empty ';
                                   }
                                   return null;
                                 },*/
                        controller: dateController,
                        decoration:  InputDecoration(labelText:'sep 6 ,2022' ,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today,),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 35,
                    ),
                    GestureDetector(
                      onTap: () async {
                        print("Hi");
                        /*updateData(status: 'New', id:0 );
                        int count = await database!.rawUpdate(
                            'UPDATE search_Tasks SET title = ?, date = ? , time=? WHERE id = ?',
                            [titleController.text, dateController.text
                              , timeController.text
                              ,search_Task.id]);*/
                        Navigator.pop(context);
                        //setState(() { AppBuilder.of(context).rebuild();});
                      },
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color(0xff458050),
                        ),
                        child: const Center(child: Text('Save', style:
                        TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300),)),
                      ),
                    )
                  ],
                ),

              ),
            ),
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
              label: 'tasks',

            ),
            //What I changed
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month,),
              label: 'Calender',
            ),
            //------------------------------------

            BottomNavigationBarItem(icon: Icon(Icons.settings,),
              label:'settings',
            ),
            //--------------------------------

          ],
        ),
      );
    

  }
}
