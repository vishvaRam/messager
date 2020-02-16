import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Chat.dart';

class Regester extends StatefulWidget {
  static final id = "Regester";
  @override
  _RegesterState createState() => _RegesterState();
}

class _RegesterState extends State<Regester> {

  bool isLoging =false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  // Image Icon
  Widget imageIcon() {
    return Column(
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Hero(
              tag: "logo",
              child: SizedBox(
                height: 150.0,
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
      child: CircularProgressIndicator(backgroundColor: Colors.black45,),
    );
  }

  final TextEditingController _maileController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();

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
                controller: _maileController,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.0),
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
                        //Loading to true
                        setState(() {
                          isLoging = true;
                        });
                        final User = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                        if(User != null){
                          Navigator.pushNamed(context, Chat.id );
                        }
                        // Clearing the text
                        _maileController.clear();
                        _passController.clear();

                      }catch (e){
                        print(e);
                      }
                      // Loading to false
                      setState(() {
                        isLoging = false;
                      });
                  },
                  minWidth: 300.0,
                  height: 50.0,
                  child: isLoging ? loading(): Text("Register",style:  TextStyle(fontSize: 24.0),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
