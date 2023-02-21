import './Reports.dart';

class Mahasiswa {
  String nim = "";
  Map<String, dynamic> sampah = {};
  List report = [];

  Mahasiswa({
    required this.nim,
    required this.sampah,
  });
  Mahasiswa.Complete(String nim, Map<String, dynamic> sampah, List report) {
    this.nim = nim;
    this.sampah = sampah;
    this.report = report;
  }

  static Mahasiswa fromJson(dynamic json) => Mahasiswa(
        nim: json['nim'],
        sampah: json['sampah'],
      );
  Map<String, dynamic> toJson() {
    return {"nim": this.nim, "sampah": this.sampah, "report": this.report};
  }
}
