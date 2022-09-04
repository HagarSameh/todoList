import 'package:sqflite/sqflite.dart';

import '../components/constants.dart';


var database;
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
  return await database!.transaction((txn) async {
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
void updateData({
  required String status,
  required int id,
}) async
{
  database!.rawUpdate(
    'UPDATE tasks SET status = ? WHERE id = ?',
    ['status', id],
  ).then((value)
  {
    getDataFromDatabase(database);
  });
}

void deleteData({
  required int id,
}) async
{
  database!.rawDelete('DELETE FROM tasks WHERE id= ?', [id])
      .then((value)
  {
    //getDataFromDatabase(database);
    print(value);
  });
}