import 'package:aaa/layout/ThemeModel.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:aaa/layout/Task.dart';
import 'package:sqflite/sqflite.dart';
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

                  _componentsState().insertDatabase2(title: '${model['title']}', time: '${model['time']}', date: '${model['date']}', category: '${model['category']}')
                      .then((value) {_componentsState().getDataFromDatabase2(_componentsState().database2).then((value) {done = value;
                      print(done);
                    });
                  }
                  );
                  int count = await database!.rawDelete(
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
            int count = await database!.rawDelete(
                'DELETE FROM tasks WHERE id=${model['id']}');
          }
      );


}

class _componentsState extends State<components> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();


  }
  var database2;

  @override
  void initState() {
    super.initState();
    createDatabase2();
  }

  void  createDatabase2() async {
    database2 = await openDatabase('done2.db',
      version: 2,
      onCreate: (database2, version) {
        print('database created');
      },
      onOpen: (database2) {
        getDataFromDatabase2(database2).then((value) {
          done = value;
          print(done);
        });
        print('database opened');
        database2.execute(
            'CREATE TABLE done2(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('error occurred when creating table ${error.toString()}');
        });
      },
    );
  }

  Future insertDatabase2({
    required String title,
    required String time,
    required String date,
    required String category,
  }) async {
    return await database2.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO done2(title, date, time, status)VALUES("$title","$date","$time","New")')
          .then((value) {
        print('$value inserted successfully');
        print("Database2 $value");
      }).catchError((error) {
        print('error occurred when inserting in database ${error.toString()}');
      });
      return null;
    });
  }

  Future<List<Map>> getDataFromDatabase2(database2) async {
    return await database2.rawQuery('SELECT * FROM done2');
  }

  void updateData2({
    required String status,
    required int id,
  }) async
  {
    database2.rawUpdate(
      'UPDATE done2 SET status = ? WHERE id = ?',
      ['status', id],
    ).then((value) {
      getDataFromDatabase2(database2);
    });
  }

  void deleteData2({
    required int id,
  }) async
  {
    database2.rawDelete('DELETE FROM done2 WHERE id= ?', [id])
        .then((value) {
      //getDataFromDatabase(database);
      print(value);
    });
  }

}

