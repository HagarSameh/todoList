import 'package:flutter/material.dart';

class massenger extends StatelessWidget {
  const massenger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: const [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg'),
            ),
            SizedBox(
              width: 15,
            ),
            Text('Chats',
            style: TextStyle(color: Colors.black),),
          ],
        ),
        actions: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.blue,
            child: IconButton(onPressed: (){},
              icon: const Icon(Icons.camera_alt,
            size: 18,
            color: Colors.white,
            ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.blue,
            child: IconButton(onPressed: (){}, icon: Icon(Icons.edit,
              size: 18,
              color: Colors.white,
            ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}
