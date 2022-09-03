import 'package:aaa/layout/ThemeModel.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:aaa/layout/Task.dart';
import '../layout/data.dart';
import '../modules/archived_Tasks/calender.dart';
import 'package:aaa/layout/database.dart';
import '../../components/constants.dart';

bool check1 = false;
Map model=Map();
ThemeModel? themeNotifier;
class components extends StatefulWidget {
  const components({Key? key}) : super(key: key);
  @override
  State<components> createState() => _componentsState();
  Widget buildTaskItem(Map model) =>
      Dismissible(
          key: Key(model['id'].toString()),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  Get.to(() => Task());
                  Task.title = '${model['title']}';
                  Task.date = '${model['date']}';
                  Task.time = '${model['time']}';
                  Task.category = '${model['category']}';
                  Task.id = model['id'];

                  //Get.to(() =>signUp());
                  print("one ");
                },
                onDoubleTap: () async {
                  insertDatabase2(
                      title: '${model['title']}',
                      time: '${model['time']}',
                      date: '${model['date']}',
                      category: '${model['category']}')
                      .then((value) {
                    getDataFromDatabase(database).then((value) {
                      done = value;
                      print(done);
                    });
                  }
                  );
                  int count = await database.rawDelete(
                      'DELETE FROM tasks WHERE id=${model['id']}');
                },


                child: Container(
                  height: 80,
                  child:
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),

                    ),
                    elevation: 0,
                    shadowColor: Colors.transparent,

                    child: Row(
                      children: [
                        Checkbox(
                          value: check1,
                          onChanged: (bool? newValue) {

                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${model['title']}',
                                style: const TextStyle(fontSize: 20,)),
                            Text('${model['date']}',
                                style: const TextStyle(fontSize: 10)),
                            Text('${model['time']}',),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ),
          onDismissed: (direction) async {
            int count = await database.rawDelete(
                'DELETE FROM tasks WHERE id=${model['id']}');
          }
      );


}class _componentsState extends State<components> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();


  }




}

