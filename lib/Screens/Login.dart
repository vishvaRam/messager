import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Chat.dart';


class Login extends StatefulWidget {
  static final id = "Login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{

  String email,password;
  bool isLoading = false;
  final _auth = FirebaseAuth.instance;

  // Icon Image
  Widget imageIcon() {
    return Column(
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Hero(
              tag: "logo",
              child: SizedBox(
                height:150.0,
                child: Image.asset(
                  "Assets/img1.png",
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Text(
            "Messager",
            style: TextStyle(fontSize: 38.0),
          ),
        )
      ],
    );
  }

  Widget loading(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  final TextEditingController _passController= new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              imageIcon(),
              SizedBox(
                height: 24.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.0),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                  border: OutlineInputBorder(
//                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor, width: 1.0),
//                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor, width: 2.0),
//                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              TextField(
                controller: _passController,
                textAlign: TextAlign.center,
                obscureText: true,
                style: TextStyle(fontSize: 22.0),
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                  border: OutlineInputBorder(
//                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Theme.of(context).accentColor, width: 1.0),
//                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Theme.of(context).accentColor, width: 2.0),
//                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Material(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 4.0,
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () async{
                    try{
                      setState(() {
                        isLoading = true;
                      });
                      final user =await _auth.signInWithEmailAndPassword(email: email, password: password);
                      if(user != null ){
                        Navigator.pushNamed(context, Chat.id);
                      }
                      _passController.clear();
                    }catch(e){
                      print(e);
                    }
                    setState(() {
                      isLoading=false;
                    });
                  },
                  minWidth: 300.0,
                  height: 50.0,
                  child: isLoading ? loading() :Text("Login",style:  TextStyle(fontSize: 24.0),)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
