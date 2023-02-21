import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Mahasiswa.dart';

class DatabaseServices {
  final CollectionReference sampah =
      FirebaseFirestore.instance.collection('sampah');

  DatabaseServices();

  Future<bool> sendRecord(Map sampah, Mahasiswa mahasiswa) async {
    final user =
        FirebaseFirestore.instance.collection('sampah').doc(mahasiswa.nim);
    sampah.forEach((key, item) {
      mahasiswa.sampah.update(key, (value) => value += item);
    });
    Timestamp waktu = Timestamp.fromDate(DateTime.now());
    Map report = {"date": waktu, "sampah": sampah};
    List send = [report];
    try {
      user.update(
          {'sampah': mahasiswa.sampah, "report": FieldValue.arrayUnion(send)});
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> loginUser(String nim) async {
    DocumentSnapshot document = await sampah.doc(nim).get();
    if (document.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future createNewUser(String nim) async {
    Map<String, dynamic> sampah = {
      "makanan": 0,
      "organik": 0,
      "plastik": 0,
      "kertas": 0,
      "bungkus": 0,
      "elektronik": 0,
      "baju": 0,
      "kendaraan": 0,
      "disposable": 0,
      "konsumsi": 0,
      "botol": 0
    };
    List report = [];
    Mahasiswa mahasiswa = new Mahasiswa.Complete(nim, sampah, report);
    return await this.sampah.doc(nim).set(mahasiswa.toJson());
  }
}
