import 'package:flutter/material.dart';
class signUp extends StatelessWidget {
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
                  const Text('Sign Up',style: TextStyle (fontSize: 30, fontWeight: FontWeight.bold,),

                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(

                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'First Name',
                      border: const OutlineInputBorder(),
                      prefixIcon: Icon(Icons.account_box_rounded,),

                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(

                    keyboardType: TextInputType.visiblePassword,
                    obscureText:true ,
                    decoration: const InputDecoration(labelText: 'Last name',
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(Icons.account_box_rounded,),
                    ),

                  ),
                  const SizedBox(
                    height: 20,
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
                        },
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xff458050),
                          ),
                          child: const Center(child: Text('Sign Up', style:
                          TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300),)),
                        ),
                      )

                  ),
                  const SizedBox(
                    height: 15,),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
