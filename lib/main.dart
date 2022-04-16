// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Firebase',
      home: AddData(),
    );
  }
}

class AddData extends StatelessWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("geeksforgeeks"),
      ),
      body: Center(
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance
                .collection("data")
                .doc('covams00003')
                .set({
              "firstname": "John",
              "password": "Omoh",
              "surname": "Paul",
              "username": "johnny",
            }).then((value) {
              print("success!");
            });
          },
        ),
      ),
    );
  }
}
