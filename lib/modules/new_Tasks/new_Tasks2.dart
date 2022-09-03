import 'package:aaa/components/components2.dart';
import 'package:flutter/material.dart';
import '../../components/constants.dart';
class done_Tasks extends StatelessWidget {
  components2 coom=components2();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) =>coom.buildTaskItem2(done[index]),
        separatorBuilder: (context, index)=> Padding(
          padding: const EdgeInsetsDirectional.only(start: 20,),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        itemCount: done.length);
  }
}
