import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatefulWidget {
  static final id="Chat";
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  final _auth = FirebaseAuth.instance;
  final _dB =  Firestore.instance;
  FirebaseUser loggedInUser;
  String text;
  bool isLoading = false;

  @override
  void initState() {
    getCurrentUser();
//    getMessages();
    super.initState();
  }

  void getCurrentUser() async{
    try{
      final user = await _auth.currentUser();
      if(user != null){
        loggedInUser = user;
        print(loggedInUser.email);
      }
    }
    catch(e){
      print(e);
    }
  }

//  void getMessages() async{
//    await for ( var snapshot in _dB.collection('messages').snapshots()){
//      for(var messages in snapshot.documents){
//        print(messages.data);
//      }
//    }
//  }

  final TextEditingController _textController = new TextEditingController();

  Widget send(){
    return Container(
      height: 75.0,
      alignment: Alignment.bottomCenter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left:8.0,top: 10.0),
              child: TextField(
                controller: _textController ,
                style: TextStyle(fontSize: 18.0),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Theme.of(context).accentColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Theme.of(context).accentColor, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
                onChanged: (value) {
                  text = value;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: FlatButton(
              onPressed: () async {
                try{
                  if(text != null){
                    setState(() {
                      isLoading = true;
                    });
                    await _dB.collection('messages').add({'text':text,"sender":loggedInUser.email});
                    _textController.clear();
                    setState(() {
                      isLoading =false;
                      text =null;
                    });
                  }else{
                    throw "Empty";
                  }
                }catch(e){
                  print(e);
                }
              },
              child:
              isLoading ?
              CircularProgressIndicator()
                  :
              Text(
                'Send',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    if(document['sender'] == loggedInUser.email){
      return Material(
        color: Colors.blue,
        child: ListTile(
          title: Text(document['text']),
          subtitle: Text(document['sender']),
        ),
      );
    }
    else{
      return ListTile(
        title: Text(document['text']),
        subtitle: Text(document['sender']),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chat"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.exit_to_app,color: Colors.white70,), onPressed: () async{
              try{
                await _auth.signOut();
                print("Sign Out");
                Navigator.pop(context);
              }catch(e){
                print(e);
              }
            }
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                  stream: _dB.collection("messages").snapshots(),
                  builder: (context,snapshot){
                    if(!snapshot.hasData){
                       return Center(
                         child: CircularProgressIndicator(),
                       );
                    }else{
                      return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context,i){
                            print(snapshot.data.documents.length);
                            print(snapshot.data.documents[i].toString());
                            return _buildList(context, snapshot.data.documents[i]);
                          }
                      );
                    }
                  },
              ),
            ),
            Container(
              height: 90.0,
              child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: send(),
              ),
          ),
            )
          ],
        )
      ),
    );
  }
}
