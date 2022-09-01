import 'package:flutter/material.dart';
class login extends StatelessWidget {
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
       image: DecorationImage(
              image: AssetImage("images/bck.png"),
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
               Text('Login',style: TextStyle (fontSize: 30, fontWeight: FontWeight.bold,
               ),

               ),
               SizedBox(
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
                 decoration: InputDecoration(labelText: 'email address',
                 border: OutlineInputBorder(),
                   prefixIcon: Icon(Icons.email,),

                 ),
               ),
               SizedBox(
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
                 decoration: InputDecoration(labelText: 'Password',
                   border: OutlineInputBorder(),
                   prefixIcon: Icon(Icons.lock,),
                   suffixIcon: Icon(Icons.remove_red_eye)
                 ),
               ),
               SizedBox(
                 height: 20,
               ),
               Container(
                 width: double.infinity,
                 color: Colors.blue,
                 child: MaterialButton(onPressed:()
                 {
                  print(emailController.text);
                  print(passwordController.text);
                 },
                   child: Text('LOGIN',style: TextStyle(color: Colors.white),),
                 ),
               ),
               SizedBox(
                 height: 15,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text('don`t have an account',
                   style: TextStyle(fontSize: 22),),
                   TextButton(onPressed: ()
                   {

                   }, child: Text('Register Now',style: TextStyle(fontSize: 20),),
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
}
