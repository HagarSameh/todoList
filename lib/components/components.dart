
import 'package:flutter/material.dart';
bool isChecked = false;

Widget buildTaskItem(Map model)=>
Padding(
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
                Text('${model['title']}',style: const TextStyle(fontSize: 30,fontWeight: FontWeight.w300)),
                Text('${model['date']}', style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w300)),
                Text('${model['time']}',),
              ],
            ),
          ],
        ),
      ),
    )
);
