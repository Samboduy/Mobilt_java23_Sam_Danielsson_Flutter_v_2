import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyUserPage extends StatefulWidget {
  const MyUserPage({super.key, required this.title});

  final String title;

  @override
  State<MyUserPage> createState() => _MyHomePageState();
}

FirebaseFirestore db = FirebaseFirestore.instance;

final TextEditingController newEmailController = TextEditingController();
final TextEditingController newNameController = TextEditingController();
final TextEditingController newLastNameController = TextEditingController();

Future<void> getUserData() async {
  final docRef = db.collection("users").doc("jhgjugyhkj");
  docRef.get().then(
    (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      newEmailController.text = data["email"];
      newNameController.text = data["name"];
      newLastNameController.text = data["lname"];
      print(data["lname"]);
      // ...
    },
    onError: (e) => print("Error getting document: $e"),
  );
  print("after");
}

void change(context) {
  if (newEmailController.text.trim().isEmpty ||
      newNameController.text.trim().isEmpty ||
      newLastNameController.text.trim().isEmpty) {
    const empty = SnackBar(
      content:
          Text('Make sure all fields are input correctly and are not empty'),
    );
    ScaffoldMessenger.of(context).showSnackBar(empty);
  } else {
    final user = <String, String>{
      "name": newNameController.text.trim(),
      "lname": newLastNameController.text.trim(),
      "email": newEmailController.text.trim(),
    };
    db
        .collection("users")
        .doc("jhgjugyhkj")
        .set(user)
        .onError((e, _) => print("Error writing document: $e"));
    const success = SnackBar(
      content:
      Text('Change Successful!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(success);

  }
}

class _MyHomePageState extends State<MyUserPage> {
  @override
  Widget build(BuildContext context) {
    Color? pink = Colors.pink[50];

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
              child: Row(
                children: [
                  Column(
                    children: <Widget>[
                      Container(
                        width: 300,
                        height: 50,
                        color: pink,
                        margin: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                        child: TextFormField(
                            controller: newEmailController,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(5))),
                      ),
                      Container(
                        width: 300,
                        height: 50,
                        color: pink,
                        margin: const EdgeInsets.fromLTRB(40, 5, 0, 0),
                        child: TextFormField(
                            controller: newNameController,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(5))),
                      ),
                      Container(
                        width: 300,
                        height: 50,
                        color: pink,
                        margin: const EdgeInsets.fromLTRB(40, 5, 0, 0),
                        child: TextFormField(
                            controller: newLastNameController,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(5))),
                      ),
                      Container(
                        width: 300,
                        height: 50,
                        //color: Colors.greenAccent[100],
                        margin: const EdgeInsets.fromLTRB(40, 5, 0, 0),
                        decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.pink),
                              left: BorderSide(color: Colors.pink),
                              right: BorderSide(color: Colors.pink),
                              bottom: BorderSide(color: Colors.pink),
                            ),
                            color: Colors.white),
                        child: TextButton(
                            onPressed: () async => {change(context)},
                            child: const Text("Change")),
                      ),
                      Container(
                        width: 300,
                        height: 50,
                        //color: Colors.greenAccent[100],
                        margin: const EdgeInsets.fromLTRB(40, 5, 0, 0),
                        decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.pink),
                              left: BorderSide(color: Colors.pink),
                              right: BorderSide(color: Colors.pink),
                              bottom: BorderSide(color: Colors.pink),
                            ),
                            color: Colors.white),
                        child: TextButton(
                            onPressed: () async => {getUserData()},
                            child: const Text("Get Profile")),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
