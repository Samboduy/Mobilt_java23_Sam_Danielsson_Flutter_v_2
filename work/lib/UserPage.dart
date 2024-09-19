

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyUserPage extends StatefulWidget {
  const MyUserPage({super.key, required this.title});

  final String title;

  @override
  State<MyUserPage> createState() => _MyHomePageState();
}

 Future<void> stuff() async {
   FirebaseFirestore db = FirebaseFirestore.instance;
   await db.collection("users").get().then((event) {
     for (var doc in event.docs) {
       debugPrint("${doc.id} => ${doc.data()}");
     }
   });
 }

class _MyHomePageState extends State<MyUserPage> {



  void change(){}

  @override
  Widget build(BuildContext context) {
    Color? pink = Colors.pink[50];
    FirebaseFirestore db;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child:
                  Row(
            children: [
              Column(
                    children: <Widget>[
                      Container(
                        width: 300,
                        height:50,
                        color: pink,
                        margin: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                        child:TextFormField(
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(5)
                            )
                        ),
                      ),
                      Container(
                        width: 300,
                        height:50,
                        color: pink,
                        margin: const EdgeInsets.fromLTRB(40,5, 0, 0),
                        child:TextFormField(
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(5)
                            )
                        ),
                      ),
                      Container(
                        width: 300,
                        height:50,
                        color: pink,
                        margin: const EdgeInsets.fromLTRB(40,5, 0, 0),
                        child:TextFormField(
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(5)
                            )
                        ),
                      ),
                      Container(
                        width: 300,
                        height:50,
                        //color: Colors.greenAccent[100],
                        margin: const EdgeInsets.fromLTRB(40,5, 0, 0),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.pink),
                            left: BorderSide(color: Colors.pink),
                            right: BorderSide(color: Colors.pink),
                            bottom: BorderSide(color: Colors.pink),
                          ),
                          color: Colors.white
                        ),
                        child:TextButton(onPressed:() async =>{
                            db = FirebaseFirestore.instance,
                            await db.collection("users").get().then((event) {
                          for (var doc in event.docs) {
                            debugPrint("${doc.id} => ${doc.data()}");
                          }
                        }),
                         // print("Sam"),
                         // stuff(),
                        },
                            child: const Text("Change")),
                      ),
                    ],
                  ),
            ],
        )
                ,
            )
          ],
        ),
      ),
    );
  }
}