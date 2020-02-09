import 'package:flutter/material.dart';
import 'Login.dart';
import 'Regester.dart';

class Welcome extends StatefulWidget {
  static final id = "Welcome";
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  // Buttons
  Widget welcomeBtn(String text,String routerName){
   return Builder(
     builder:(context)=> Padding(
       padding: const EdgeInsets.all(10.0),
       child: Material(
         color: Colors.blue,
         borderRadius: BorderRadius.all(Radius.circular(30.0)),
         child: MaterialButton(
             minWidth: 300.0,
             height: 50.0,
             color: Colors.blue,
             child: Text(text,style: TextStyle(fontSize: 24.0)),
             onPressed: (){
               Navigator.pushNamed(context, routerName);
             }
         ),
       ),
     ),
   );
 }
 // Image
 Widget imageIcon(){
    return Column(
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SizedBox(
              height: 150.0,
              child: Image.asset("Assets/img1.png",),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom:15.0),
          child: Text("Messager",style: TextStyle(fontSize: 38.0),),
        )
      ],
    );
 }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    imageIcon(),
                    welcomeBtn("Login",Login.id ),
                    welcomeBtn("Register",Regester.id)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
