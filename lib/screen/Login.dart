import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ppkmb/screen/Home.dart';
import 'package:ppkmb/services/Database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoggedIn = false;
  String nim = '';
  String warning = "Masukan Nim Anda Dengan Sesuai";
  final _formKey = new GlobalKey<FormState>();
  final nimController = TextEditingController();
  final namaController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? nim = prefs.getString('nim');

    if (nim != "") {
      setState(() {
        isLoggedIn = true;
        this.nim = nim ?? '';
      });
      return;
    }
  }

  Future<Null> loginMahasiswa() async {
    try {
      bool login = await DatabaseServices().loginUser(nimController.text);
      if (!login) {
        DatabaseServices().createNewUser(nimController.text);
        print("Masuk Baru");
      }
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('nim', nimController.text);
      setState(() {
        this.nim = nimController.text;
        isLoggedIn = true;
        nimController.clear();
      });
    } catch (e) {
      setState(() {
        warning = "Tidak ada koneksi internet/gagal login";
      });
    }
  }

  Future<Null> logoutMahasiswa() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nim', "");
    setState(() {
      nim = "";
      isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isLoggedIn
        ? Scaffold(
            backgroundColor: Colors.grey[200],
            body: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "Login FCH",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0),
                    ),
                  ),
                  SizedBox(
                    height: 45.0,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty || value.length != 9) {
                                return warning;
                              }
                            },
                            controller: nimController,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                hoverColor: Colors.white,
                                focusColor: Colors.white,
                                hintText: "Masukan NIM Anda",
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.green[400],
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  loginMahasiswa();
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green),
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
        : Home(
            logoutMahasiswa: logoutMahasiswa,
            nim: this.nim,
          );
  }
}
