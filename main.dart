//05_AprintanDwi

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp()); //main tempat start di running

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(// mengatur tema dan navigasu
      title: 'Form Tambah Data Barang',
      home: Scaffold( // kerangka susunan
        appBar: AppBar( //head//judul
          title: Text('Form Tambah Data Barang'), //isi tsb
        ),
        body: MyForm(), //form
      ),
    );
  }
}

class MyForm extends StatefulWidget { //class form
  @override //menurunkan
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //medefinisikan variabel
  String kodeBarang = '';
  String namaBarang = '';
  String jenisBarang = '';
  String hargaBarang = '';
  String stokBarang = '';
  DateTime? tanggalMasuk;
  String tanggalButton = 'Pilih Tanggal Masuk';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (tanggalMasuk == null) {
        // Tampilkan notifikasi jika tanggal belum dipilih
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tanggal masuk barang belum terisi'),
            duration: Duration(seconds: 2),
          ),
        );
        return; // Berhenti eksekusi jika tanggal belum dipilih
      }

      // Debug nilai
      print('Kode Barang: $kodeBarang');
      print('Nama Barang: $namaBarang');
      print('Jenis Barang: $jenisBarang');
      print('Harga Barang: $hargaBarang');
      print('Stok Barang: $stokBarang');
      print('Tanggal Masuk: $tanggalMasuk');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RekapTambahDataBarang(
            kodeBarang: kodeBarang,
            namaBarang: namaBarang,
            jenisBarang: jenisBarang,
            hargaBarang: hargaBarang,
            stokBarang: stokBarang,
            tanggalMasuk: tanggalMasuk!,
          ),
        ),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      kodeBarang = '';
      namaBarang = '';
      jenisBarang = '';
      hargaBarang = '';
      stokBarang = '';
      tanggalMasuk = null;
      tanggalButton = 'Pilih Tanggal Masuk'; // Reset teks pada tombol tanggal
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( //fungsi untuk scroll
      child: Padding(
        padding: const EdgeInsets.all(20.0), //jarak konten dengan layar hp
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, //rata kiri
            children: <Widget>[
              Text(
                'Kode Barang',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField( //input
                decoration: InputDecoration(
                  filled: false,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
                onSaved: (value) => kodeBarang = value!, // Penempatan onSaved seharusnya di dalam TextFormField
              ),
              SizedBox(height: 10.0),
              Text(
                'Nama Barang',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: false,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
                onSaved: (value) => namaBarang = value!,
              ),
              SizedBox(height: 10.0),
              Text(
                'Jenis Barang',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        RadioListTile(
                          title: Text('Sembako'),
                          value: 'Sembako',
                          groupValue: jenisBarang,
                          onChanged: (value) => setState(() => jenisBarang = value.toString()),
                        ),
                        RadioListTile(
                          title: Text('Makanan\nMinuman'),
                          value: 'Makanan & Minuman',
                          groupValue: jenisBarang,
                          onChanged: (value) => setState(() => jenisBarang = value.toString()),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        RadioListTile(
                          title: Text('Sabun'),
                          value: 'Sabun',
                          groupValue: jenisBarang,
                          onChanged: (value) => setState(() => jenisBarang = value.toString()),
                        ),
                        RadioListTile(
                          title: Text('Lainnya'),
                          value: 'Lainnya',
                          groupValue: jenisBarang,
                          onChanged: (value) => setState(() => jenisBarang = value.toString()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),

              Text(
                'Harga Barang/item',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: false,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
                keyboardType: TextInputType.number, // Mengatur keyboard hanya untuk angka
                inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Memfilter input agar hanya angka
                onSaved: (value) => hargaBarang = value!,
              ),
              SizedBox(height: 10.0),
              Text(
                'Stok Barang',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: false,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
                keyboardType: TextInputType.number, // Mengatur keyboard hanya untuk angka
                inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Memfilter input agar hanya angka
                onSaved: (value) => stokBarang = value!,
              ),
              SizedBox(height: 10.0),
              Text(
                'Tanggal Masuk Barang',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity, // Lebar container mengikuti lebar layar
                decoration: BoxDecoration(
                  color: Colors.grey[100], // Warna latar belakang
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      useRootNavigator: true,
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          tanggalMasuk = value;
                          tanggalButton = 'Tanggal Masuk: ${tanggalMasuk!.day}/${tanggalMasuk!.month}/${tanggalMasuk!.year}';
                        });
                      }
                    });
                  },

                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(tanggalButton),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Simpan'),
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: _resetForm,
                    child: Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class RekapTambahDataBarang extends StatelessWidget {
  final String kodeBarang;
  final String namaBarang;
  final String jenisBarang;
  final String hargaBarang;
  final String stokBarang;
  final DateTime tanggalMasuk;

  RekapTambahDataBarang({
    required this.kodeBarang,
    required this.namaBarang,
    required this.jenisBarang,
    required this.hargaBarang,
    required this.stokBarang,
    required this.tanggalMasuk,
  });


  //izin saya buat list tampilannya bu, jadi kebawah bukan ke samping
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rekap Tambah Data Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text('Kode Barang'),
              subtitle: Text(kodeBarang),
            ),
            ListTile(
              title: Text('Nama Barang'),
              subtitle: Text(namaBarang),
            ),
            ListTile(
              title: Text('Jenis Barang'),
              subtitle: Text(jenisBarang),
            ),
            ListTile(
              title: Text('Harga Barang'),
              subtitle: Text(hargaBarang),
            ),
            ListTile(
              title: Text('Stok Barang'),
              subtitle: Text(stokBarang),
            ),
            ListTile(
              title: Text('Tanggal Masuk Barang'),
              subtitle: Text(tanggalMasuk.toLocal().toString()),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
