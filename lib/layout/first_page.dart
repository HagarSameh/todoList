import 'package:aaa/layout/signUp.dart';
import 'package:aaa/modules/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'notification_service.dart';
class first_page extends StatelessWidget {
  var emailController   = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff458050),
        elevation: 0.0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/first.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  const Text('TO DO List',style: TextStyle (color:Color(0xff458050),fontSize: 30, fontWeight: FontWeight.bold,),

                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                      width: 280,
                      height: 45,
                      child:
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => login()),);

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
                    height: 20,
                  ),
                  Container(
                      width: 280,
                      height: 45,
                      child:
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => signUp()),);
                          },
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xff458050),
                          ),
                          child: const Center(child: const Text('Sign Up', style:
                          TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300),)),
                        ),
                      )

                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
