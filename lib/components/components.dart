
import 'package:flutter/material.dart';
bool check1 = false;

Widget buildTaskItem(Map model)=>
Padding(
    padding:  const EdgeInsets.all(10.0),
    child: InkWell(
      onTap: (){
        //go to task page
      },
      onDoubleTap: (){
        //delete this task and move it to done tasks
      },
      child: Container(
        height: 80,
        child:
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),

            ),
            color:  const Color(0xffe4eae4),
            elevation: 0,
            shadowColor: Colors.transparent,

            child:Row(
          children: [
            Checkbox(
              value: check1,
              onChanged: (bool? newValue) {
               /* setState(() {
                  check1 = newValue!;
                  print(check1);
                });*/
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${model['title']}',style: const TextStyle(fontSize: 20,)),
                Text('${model['date']}', style: const TextStyle(fontSize: 10)),
                Text('${model['time']}',),
              ],
            ),
          ],
        ),
      ),
      ),
    )
);
