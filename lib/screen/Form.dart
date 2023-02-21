import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ppkmb/services/Database.dart';
import '../components/FormInput.dart';
import '../models/Mahasiswa.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  bool success = true;
  List<String> test = [
    "Sampah makanan (makanan yang tersisa di piring, makanan yang tidak disukai, dsb)",
    "Sampah organik lain (sisa tebang pohon, bersih – bersih kebun, dsb)",
    "Sampah plastik aneka bungkus (bungkus snack, makanan, kantong plastik, dsb)",
    "Sampah kertas (sisa coret – coret, koran, kalender, kotak rokok, dsb)",
    "Sampah kertas bungkus makanan (bungkus makanan, kotak makanan)",
    "Sampah elektronika (piranti elektronika yang sudah tidak digunakan)",
    "Sampah sisa baju (baju bekas, sepatu bekas)",
    "Sampah sisa kendaraan (ban kendaraan, oli, dsb)",
    "Sampah disposable sanitary dan medis (pampers, pembalut, perban, obat – obatan, dsb)",
    "Sampah sisa barang konsumsi (tempat sampo, tempat sabun, pasta gigi, dsb)",
    "Sampah botol air minum",
  ];

  Map sampah = {
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
  List<String> kategori = [
    "makanan",
    "organik",
    "plastik",
    "bungkus",
    "kertas",
    "elektronik",
    "baju",
    "kendaraan",
    "disposable",
    "konsumsi",
    "botol"
  ];

  incrementItem(int index) {
    print(index);
    setState(() {
      this.sampah[kategori[index]] += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    Mahasiswa mahasiswa = data['mahasiswa'];
    return Scaffold(
        appBar: AppBar(
          title: Text("Form Input Sampah FCH"),
          backgroundColor: Colors.green[400],
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: test.length,
                    itemBuilder: ((context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(test[index]),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              sampah[kategori[index]] != 0
                                  ? IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () => setState(
                                          () => sampah[kategori[index]]--),
                                    )
                                  : Container(),
                              Text(sampah[kategori[index]].toString()),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () =>
                                    setState(() => sampah[kategori[index]]++),
                              )
                            ],
                          ),
                        ),
                      );
                    })),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: success ? null : Text("Gagal Submit Data"),
                ),
                ElevatedButton(
                    child: Text('Input Sampah'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    onPressed: () async {
                      bool status = await DatabaseServices()
                          .sendRecord(sampah, mahasiswa);
                      if (status) {
                        setState(() {});
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          success = false;
                        });
                      }
                    }),
              ],
            )));
  }
}
