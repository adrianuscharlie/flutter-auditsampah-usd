import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ppkmb/models/Mahasiswa.dart';
import 'package:ppkmb/services/Database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './Login.dart';

class Home extends StatefulWidget {
  final VoidCallback logoutMahasiswa;
  final nim;
  Home({required this.logoutMahasiswa, required this.nim});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    try {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("sampah")
            .doc(widget.nim)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            try {
              return Scaffold(
                  body: Container(
                color: Colors.blueAccent[100],
                child: SpinKitWave(
                  color: Colors.white,
                  size: 50.0,
                ),
              ));
            } catch (e) {
              return Login();
            }
          } else {
            Mahasiswa person = Mahasiswa.fromJson(snapshot.data);
            List<String> kategori = person.sampah.keys.toList();
            List value = person.sampah.values.toList();
            List<String> sampah = [];
            return Scaffold(
                appBar: AppBar(
                  actions: [
                    TextButton(
                        onPressed: widget
                            .logoutMahasiswa, // Simply put the function name here, DON'T use ()
                        child: Text(
                          "Ganti Nim",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[400],
                        )
                        //color: Colors.green[400],
                        //textColor: Colors.white,
                        //shape: RoundedRectangleBorder(
                        //borderRadius: BorderRadius.circular(25)),
                        ),
                  ],
                  title: Text(
                    "Daftar Sampah FCH",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  backgroundColor: Colors.green[400],
                ),
                body: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(30, 30, 20, 20),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Selamat Datang,",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              person.nim,
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: kategori.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: 1),
                            tileColor: Colors.white,
                            leading: Icon(Icons.shopping_bag_rounded),
                            title: Text(
                              kategori[index],
                              style: TextStyle(fontSize: 15.0),
                            ),
                            trailing: Text(value[index].toString()),
                          );
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        child: Text('Input Sampah'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/form',
                              arguments: {'mahasiswa': person}).then((_) {
                            setState(() {});
                          });
                        },
                      ),
                    ],
                  ),
                ));
          }
        },
      );
    } catch (e) {
      return Login();
    }
  }
}
