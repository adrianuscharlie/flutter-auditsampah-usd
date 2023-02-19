import './Reports.dart';

class Mahasiswa {
  String nim = "";
  String nama = "";
  Map<String, dynamic> sampah = {};
  List<Report> report = [];

  Mahasiswa({
    required this.nim,
    required this.nama,
    required this.sampah,
  });
  Mahasiswa.Complete(String nim, String nama, Map<String, dynamic> sampah,
      List<Report> report) {
    this.nim = nim;
    this.nama = nama;
    this.sampah = sampah;
    this.report = report;
  }

  static Mahasiswa fromJson(dynamic json) => Mahasiswa(
        nim: json['nim'],
        nama: json['nama'],
        sampah: json['sampah'],
      );
}
