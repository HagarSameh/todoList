import 'package:aaa/layout/ThemeModel.dart';
import 'package:flutter/material.dart';
import 'package:aaa/layout/Task.dart';
import 'package:aaa/layout/database.dart';
bool check1 = false;
Map model2=Map();
ThemeModel? themeNotifier;

class components2 extends StatefulWidget {
  const components2({Key? key}) : super(key: key);
  Widget buildTaskItem2(Map model2)=>
      Dismissible(
          key: Key(model2['id'].toString()),
          child: Padding(
              padding:  const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: (){
                 /* Get.to(() => Task());
                  Task.title='${model['title']}';
                  Task.date='${model['date']}';
                  Task.time='${model['time']}';
                  Task.category='${model['category']}';
                  Task.id=model['id'];
*/
                  //Get.to(() =>signUp());
                  print("one ");
                },

                child: Container(
                  height: 80,
                  child:
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),

                    ),
                    //color:  const Color(0xffe4eae4),
                    elevation: 0,
                    shadowColor: Colors.transparent,

                    child:Row(
                      children: [

                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${model2['title']}',style: const TextStyle(fontSize: 20,)),
                            Text('${model2['date']}', style: const TextStyle(fontSize: 10)),
                            Text('${model2['time']}',),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ),
          onDismissed: (direction) async {
            // deleteData(id:model['id']);
            //updateData(status: 'New', id: model['id']);
            //int count = await database.rawDelete('DELETE FROM tasks WHERE id=${model['id']}');
          }
      );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }




}