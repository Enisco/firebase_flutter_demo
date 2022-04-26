// ignore_for_file: avoid_print, unrelated_type_equality_checks

import 'package:firebase_flutter_demo/my_spacers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

TextEditingController idController = TextEditingController();
TextEditingController passwordController = TextEditingController();
String errorMessage = '';

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
      title: 'Firebase Demo',
      // home: AddDetails(),
      home: AddData(),
    );
  }
}

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Firebase demo"),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer4(),

            SizedBox(
              width: size.width,
              height: size.height / 18,
              child: TextField(
                controller: idController,
                cursorColor: Colors.blueGrey,
                style: const TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  labelText: 'ID',
                  labelStyle: const TextStyle(
                    fontFamily: 'Poppins',
                  ),
                  hintText: "Enter the ID",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      borderSide: BorderSide(color: Colors.blueGrey)),
                  hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            //---------------------------------------------------------------------------------------------------------

            const Spacer2(),
            //---------------------------------------------------------------------------------------------------------

            SizedBox(
              width: size.width,
              height: size.height / 18,
              child: TextField(
                controller: passwordController,
                cursorColor: Colors.blueGrey,
                style: const TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    fontFamily: 'Poppins',
                  ),
                  hintText: "Enter the Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      borderSide: BorderSide(color: Colors.blueGrey)),
                  hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            //---------------------------------------------------------------------------------------------------------

            const Spacer2(),
            //---------------------------------------------------------------------------------------------------------

            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: size.height / 10, maxWidth: size.width / 1.5),
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red, fontSize: size.width / 40),
              ),
            ),
            //---------------------------------------------------------------------------------------------------------

            const Spacer2(),
            //---------------------------------------------------------------------------------------------------------

            FloatingActionButton(
                backgroundColor: Colors.green,
                child: const Icon(Icons.add),
                onPressed: () async {
                  if (idController.text == '' ||
                      passwordController.text == '') {
                    print('Enter both username and password');
                    setState(() {
                      errorMessage = 'Enter both username and password';
                    });
                  } else {
                    /*
                    // FirebaseFirestore.instance //add new doc to the data store
                    //     .collection("covamsdata")
                    //     .doc('covams00002')
                    //     .set({
                    //   "first name": "John Awe",
                    //   "password": "Omoh",
                    //   "surname": "Paul",
                    //   "username": "johnny",
                    // }).then((value) {
                    //   print("success!");
                    // });

                    // FirebaseFirestore.instance //Update an attribute in a doc
                    //     .collection("data")
                    //     .doc('covams00002')
                    //     .update({"password": 'Olayemi'}).then((_) {
                    //   print("success!");
                    // });

                    // FirebaseFirestore.instance     //Get all documents in the data
                    //     .collection("covamsdata")
                    //     .get()
                    //     .then((querySnapshot) {
                    //   for (var result in querySnapshot.docs) {
                    //     print(result.data());
                    //   }
                    // });

                    //   String password = passwordController.text;
                    //   String readPassword;

                    //   FirebaseFirestore.instance
                    //       .collection("covamsdata")
                    //       .doc(idController.text)
                    //       .get()
                    //       .then((value) {
                    //     readPassword = value.data()!["Password"].toString();
                    //     print(readPassword);

                    //     if (readPassword == password) {
                    //       print('Password matches: ${value.data()!["Password"]}');
                    //     } else {
                    //       print(
                    //           'Password doesn\'t  match: ${value.data()!["Password"]}');
                    //     }

                    //     if (value.data() == null) {
                    //       print('User not found');
                    //     }
                    //   });
*/

                    checkPasswordCorrect();
                  }
                }),
          ],
        ),
      ),
    );
  }
//covams00001 covams1

  void checkPasswordCorrect() async {
    String password = passwordController.text;
    String readPassword;

    final docSnapShot = await FirebaseFirestore.instance
        .collection("covamsdata")
        .doc(idController.text)
        .get();
    if (docSnapShot.exists) {
      readPassword = docSnapShot.data()!["Password"].toString();
      print(readPassword);

      if (readPassword == password) {
        print('Password matches: ${docSnapShot.data()!["Password"]}');

        setState(() {
          errorMessage = 'Access granted';
        });
      } else {
        print('Password doesn\'t  match: ${docSnapShot.data()!["Password"]}');
        print('Username or password Incorrect');
        setState(() {
          errorMessage = 'Username or password Incorrect';
        });
      }

      if (docSnapShot.data() == null) {
        print('User not found');
        print('Username or password Incorrect');
        setState(() {
          errorMessage = 'Username or password Incorrect';
        });
      }
    } else {
      print('Username or password Incorrect');
      setState(() {
        errorMessage = 'Username or password Incorrect';
      });
    }
  }
}
