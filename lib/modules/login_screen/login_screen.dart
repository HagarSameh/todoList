import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../layout/data.dart';
import '../../layout/home.dart';

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  late Database database;

  var emailController   = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
      decoration: const BoxDecoration(
      /* image: DecorationImage(
              image: AssetImage("images/bck.png"),
              fit: BoxFit.cover,
            ),*/
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
             children: [
               const Text('Login',style: TextStyle (fontSize: 50, fontWeight: FontWeight.w300),

               ),
               const SizedBox(
                 height: 40,
               ),
               TextFormField(
                 controller: emailController,
                 onFieldSubmitted: (value){
                  print(value);
                 },
                 onChanged: (value)
                 {
                   print(value);
                 },
                 keyboardType: TextInputType.emailAddress,
                 decoration: const InputDecoration(labelText: 'email address',
                 border: const OutlineInputBorder(),
                   prefixIcon: Icon(Icons.email,),

                 ),
               ),
               const SizedBox(
                 height: 15,
               ),
               TextFormField(
                 controller: passwordController,
                 onFieldSubmitted: (value){
                   print(value);
                 },
                 onChanged: (value)
                 {
                   print(value);
                 },
                 keyboardType: TextInputType.visiblePassword,
                 obscureText:true ,
                 decoration: const InputDecoration(labelText: 'Password',
                   border: const OutlineInputBorder(),
                   prefixIcon: Icon(Icons.lock,),
                   suffixIcon: const Icon(Icons.remove_red_eye)
                 ),

               ),
               const SizedBox(
                 height: 20,
               ),
               Container(
                   width: 280,
                   height: 45,
                   child:
                   GestureDetector(
                     onTap: () {
                      print(emailController.text);
                      print(passwordController.text);
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Home()),);
                      createDatabase();
                      insertDatabase(
                        email: emailController.text,
                        password: passwordController.text,
                      ).then((value) {
                        getDataFromDatabase(database).then((value) {
                          Navigator.pop(context);
                          setState((){});
                        });
                      });
                     print( getDataFromDatabase(database));
                      database2.execute('TRUNCATE TABLE done');
                      database.execute('DELETE FROM tasks');

                     },
                     child: Container(
                       width: 200,
                       height: 50,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(50),
                         color: const Color(0xff458050),
                       ),
                       child: const Center(child: Text('Login', style:
                       TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300),)),
                     ),
                   )

               ),
               const SizedBox(
                 height: 15,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   const Text('don`t have an account',
                   style: TextStyle(fontSize: 22 ,fontWeight: FontWeight.w300),),
                   TextButton(onPressed: ()
                   {

                   }, child: const Text('Register Now',style: TextStyle(fontSize: 20, color:Color(0xff458050), fontWeight: FontWeight.w300),),
                   ),
                 ],
               ),
             ],
            ),
          ),
        ),
      ),
      ),
    );
  }

  void createDatabase() async{
    database = await openDatabase('accounts.db',
      version: 1,
      onCreate: (database, version){
        print ('database2 created');
      },
      onOpen: (database){
        getDataFromDatabase(database).then((value) {

        });
        print ('database opened');
        database.execute('CREATE TABLE accounts(id INTEGER PRIMARY KEY, email TEXT, password TEXT, status TEXT)').then((value){
          print('table2 created');
        }).catchError((error){
          print('error occurred when creating table ${error.toString()}');
        });
      },
    );
  }

  Future insertDatabase({
    required String email,
    required String password,

  }) async{
    return await database.transaction((txn) async {
      txn.rawInsert('INSERT INTO accounts(email, password, status)VALUES("$email","$password","New")').then((value) {
        print('$value inserted successfully');
      }).catchError((error){
        print('error occurred when inserting in database ${error.toString()}');
      });
      return null;
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async{
    return  await database.rawQuery('SELECT * FROM accounts');

  }
}
