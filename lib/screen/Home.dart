import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ppkmb/models/Mahasiswa.dart';
import 'package:ppkmb/services/Database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map> test = [
    {'nama': 'Makanan', 'icon': 'fastFood'},
    {'nama': 'Organik lain', 'icon': 'shopping_bag_rounded'},
    {'nama': 'Plastik', 'icon': 'shopping_bag_rounded'},
    {'nama': 'Kertas', 'icon': 'shopping_bag_rounded'},
    {'nama': 'Kertas Bungkus Makanan', 'icon': 'shopping_bag_rounded'},
    {'nama': 'Elektronika', 'icon': 'shopping_bag_rounded'},
    {'nama': 'Sisa Baju', 'icon': 'shopping_bag_rounded'},
    {'nama': 'Sisa Kendaraan', 'icon': 'shopping_bag_rounded'},
    {'nama': 'Disposable Sanitary dan Medis', 'icon': 'shopping_bag_rounded'},
    {'nama': 'Sisa Barang Konsumsi', 'icon': 'shopping_bag_rounded'},
    {'nama': 'Botol Air Minum', 'icon': 'shopping_bag_rounded'},
  ];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("sampah")
          .doc('195314174')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("No Data");
        } else {
          Mahasiswa person = Mahasiswa.fromJson(snapshot.data);
          List kategori = person.sampah.keys.toList();
          List value = person.sampah.values.toList();
          return Scaffold(
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
                    Text(
                      "Selamat datang di daftar sampah FCH",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        person.nama,
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      person.nim,
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: kategori.length,
                  itemBuilder: (context, index) {
                    print(person.sampah['kendaraan']);
                    return ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: 1),
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
                  onPressed: () {},
                ),
              ],
            ),
          ));
        }
      },
    );
  }
}
