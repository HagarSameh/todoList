/*
import 'package:sqflite/sqflite.dart';

import '../components/constants.dart';


 var database2;
void createDatabase2() async{
  database2 = await openDatabase('done.db',
    version: 2,
    onCreate: (database2, version){
      print ('database created');
    },
    onOpen: (database2){
      getDataFromDatabase2(database2).then((value) {
        tasks = value;
        print(tasks);
      });
      print ('database opened');
      database2.execute('CREATE TABLE done(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)').then((value){
        print('table created');
      }).catchError((error){
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
}) async{
  return await database2.transaction((txn) async {
    txn.rawInsert('INSERT INTO done(title, date, time, status)VALUES("$title","$date","$time","New")').then((value) {
      print('$value inserted successfully');
      print("Database2 $value");
    }).catchError((error){
      print('error occurred when inserting in database ${error.toString()}');
    });
    return null;
  });
}

Future<List<Map>> getDataFromDatabase2(database2) async{
  return  await database2.rawQuery('SELECT * FROM done');

}
void updateData2({
  required String status,
  required int id,
}) async
{
  database2.rawUpdate(
    'UPDATE done SET status = ? WHERE id = ?',
    ['status', id],
  ).then((value)
  {
    getDataFromDatabase2(database2);
  });
}

void deleteData2({
  required int id,
}) async
{
  database2.rawDelete('DELETE FROM done WHERE id= ?', [id])
      .then((value)
  {
    //getDataFromDatabase(database);
    print(value);
  });
}
*/
