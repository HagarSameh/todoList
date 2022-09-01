import 'package:flutter/material.dart';
class home_page extends StatelessWidget{
  const home_page({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('First App'),
        actions: [
          IconButton( icon:  Icon(Icons.notification_important,),
              onPressed: () {
                print('hello world');
              }
          ),
          IconButton(onPressed: () {print ('hello');
          }, icon: const Icon(Icons.search,),
          ),
        ],
        elevation: 10,
    ),
    body: SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding:  EdgeInsets.all(10),
        child: Stack(
          children: [
               Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                          child: Image(image:NetworkImage ('https://avatars.mds.yandex.net/i?id=84dbd50839c3d640ebfc0de20994c30d-4473719-images-taas-consumers&n=27&h=480&w=480',),
                          width: 190,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                    ),
                ],
              ),

          ],
        ),
      ),

         ),
    );
}
}



