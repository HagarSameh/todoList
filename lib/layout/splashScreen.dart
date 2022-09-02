import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:aaa/layout/first_page.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen>{
  int splashtime = 3;
  // duration of splash screen on second

  @override
  void initState() {
    Future.delayed(Duration(seconds: splashtime), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(
        //pushReplacement = replacing the route so that
        //splash screen won't show on back button press
        //navigation to Home page.
          builder: (context){
            return first_page();
          }));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
            alignment: Alignment.center,
            child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //vertically align center
                children:<Widget>[
                  Container(
                    child:SizedBox(
                        height:820,width:450,
                       child: Container(
                       decoration: const BoxDecoration(
                       image: DecorationImage(

            image: AssetImage("images/bck.png"),
          fit: BoxFit.cover,
        ),
    ),
                       ),

        ),
                  ),

                ]
            )
        )
    );
  }
}