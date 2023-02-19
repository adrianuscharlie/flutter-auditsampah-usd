import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ppkmb/screen/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoggedIn = false;
  String? name = '';
  String? nim = '';
  final nimController = TextEditingController();
  final namaController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? nim = prefs.getString('nim');
    final String? nama = prefs.getString('nama');

    if (nim != null) {
      setState(() {
        isLoggedIn = true;
        this.nim = nim;
        this.name = nama;
      });
      return;
    }
  }

  Future<Null> loginMahasiswa() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nim', nimController.text);
    prefs.setString('nama', namaController.text);
    setState(() {
      nim = nimController.text;
      isLoggedIn = true;
    });

    nimController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn
        ? Scaffold(
            backgroundColor: Colors.grey[50],
            body: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "Login PPKMB",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40.0),
                    ),
                  ),
                  SizedBox(
                    height: 45.0,
                  ),
                  Form(
                      child: Column(
                    children: [
                      TextFormField(
                        controller: nimController,
                        decoration: InputDecoration(
                            hintText: "Masukan NIM Anda",
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.orangeAccent,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            print(nimController.text);
                            autoLogIn();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.orangeAccent),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.fromLTRB(20, 10, 20, 10)),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                                fontFamily: 'Montserrat'),
                          ))
                    ],
                  ))
                ],
              ),
            ),
          )
        : Home();
  }
}
