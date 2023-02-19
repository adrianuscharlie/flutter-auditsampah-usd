import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Mahasiswa.dart';

class DatabaseServices {
  final CollectionReference sampah =
      FirebaseFirestore.instance.collection('sampah');

  DatabaseServices();

  Future createUser({required String name}) async {
    final user = FirebaseFirestore.instance.collection('sampah').doc('bubu');

    final json = {'nama': 'Charlie', 'usia': '10'};
    await user.set(json);
  }
}
