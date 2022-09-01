import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  //const Task({Key? key}) : super(key: key);

  String title, date;
  Task(this.title , this.date, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:  const EdgeInsets.all(20.0),
        child: InkWell(
          onTap: (){
            //go to task page
          },
          onDoubleTap: (){
            //delete this task and move it to done tasks
          },
          child: Container(
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.w300)),

                  ],
                ),
              ],
            ),
          ),
        )
    );

  }
}
