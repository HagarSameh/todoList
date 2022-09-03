import 'package:aaa/layout/Task.dart';
import 'package:flutter/material.dart';
import 'package:aaa/components/components.dart';
import 'package:aaa/layout/database.dart';
import 'package:intl/intl.dart';
import 'package:aaa/layout/database.dart';
class Task extends StatefulWidget {
  //const Task({Key? key}) : super(key: key);
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

  Task({Key? key}) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  var titleController =TextEditingController();
  var timeController =TextEditingController();
  var dateController =TextEditingController();
  Task t=Task();
  String dropdownValue ="Work";
  int currentIndex=0;

  String newCategrory='';
  @override
  void initState(){
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {

    return   Expanded(
      child: Scaffold(
          appBar: AppBar(
            title:const Text("Edit Task"),
            backgroundColor: const Color(0xff458050),
          elevation: 0.0,
      ),
      body:
      Padding(
            padding:  const EdgeInsets.all(10.0),
              child: SizedBox(
               height: 480,
               child:
                 Card(
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(15.0),

                   ),
                   color:  const Color(0xffe4eae4),
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
                              width: 350,
                              child:
                             TextFormField(
                               // onTap: (){
                               //   print('timing taped');
                               // },
                               keyboardType: TextInputType.text,
                               /*validator: ( value) {
                                 if (value == null || value.isEmpty) {
                                   return 'Please enter some text';
                                 }
                                 return null;
                               },*/
                               controller: titleController,
                               decoration:  InputDecoration(labelText:Task.title,
                                 border: OutlineInputBorder(),
                                 prefixIcon: Icon(Icons.title,),

                               ),
                             ),
                   ),
                             const SizedBox(
                               height: 15,
                             ),
                             SizedBox(
                     width: 350,
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
                               decoration:  InputDecoration(labelText: Task.time,
                                 border: OutlineInputBorder(),
                                 prefixIcon: Icon(Icons.watch_later_outlined,),
                               ),
                             ),
                   ),
                             const SizedBox(
                               height: 15,
                             ),
                              SizedBox(
                     width: 350,
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
                               decoration:  InputDecoration(labelText:Task.date ,
                                 border: OutlineInputBorder(),
                                 prefixIcon: Icon(Icons.calendar_today,),
                               ),
                             ),
                   ),
                             const SizedBox(
                               height: 25,
                             ),
                             const Padding(padding:  EdgeInsets.all(10.0),
                             child:
                             Align(
                               alignment: Alignment.centerLeft,
                               child: Text("Category",
                                   style: TextStyle(fontSize: 20,color:Colors.black54,fontWeight: FontWeight.w600)),

                             ),
                             ),
                             SizedBox(
                                     width: 300,
                                     child: DropdownButton<String>(
                                         isExpanded: true,
                                         value: dropdownValue,
                                         items: <String>['Work','Entertainment','Shopping','Going out']
                                             .map<DropdownMenuItem<String>>((String value){
                                           return DropdownMenuItem<String>(
                                               value:value,
                                               child:Text(Task.category)
                                           );
                                         }).toList(),
                                         onChanged: (String? newValue){
                                           setState(() {
                                             dropdownValue = newValue??dropdownValue;
                                           });
                                         }
                                     )
                                 ),
                             const SizedBox(
                               height: 35,
                             ),
                             GestureDetector(
                               onTap: () async {
                                 print("Hi");
                                 updateData(status: 'New', id:0 );
                                 int count = await database.rawUpdate(
                                     'UPDATE tasks SET title = ?, date = ? , time=? WHERE id = ?',
                                     [titleController.text, dateController.text
                                       , timeController.text
                                       ,Task.id]);
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
                                 child: const Center(child: Text('Edit', style:
                                 TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300),)),
                               ),
                             )
                           ],
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
      ),
    );

  }
}
