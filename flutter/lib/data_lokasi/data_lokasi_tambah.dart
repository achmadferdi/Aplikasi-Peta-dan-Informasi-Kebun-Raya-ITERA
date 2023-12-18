import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ridikc_crud/config/color.dart';
import 'package:ridikc_crud/enum/enum_widget.dart';
import 'package:ridikc_crud/enum/repo/enum_remote.dart';
import 'package:ridikc_crud/data_lokasi/bloc/data_lokasi_simpan_bloc.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi.dart';

class DataLokasiTambahScreen extends StatefulWidget {
  static const routeName = "data_lokasi/tambah";
  const DataLokasiTambahScreen({super.key});

  @override
  State<DataLokasiTambahScreen> createState() => _DataLokasiTambahScreenState();
}

class _DataLokasiTambahScreenState extends State<DataLokasiTambahScreen> {
  EnumRemote enumRemote = EnumRemote();
  
  DataLokasiTambahArguments? screenArgument;

  DataLokasi form = DataLokasi();
    
  var idLokasiController = TextEditingController();
var namaController = TextEditingController();
var foto1Controller = TextEditingController();
var foto2Controller = TextEditingController();
var deskripsiController = TextEditingController();


  @override
  void initState() {
    super.initState();

    idLokasiController.addListener(() {
        form.idLokasi = idLokasiController.text;
        });
        
namaController.addListener(() {
        form.nama = namaController.text;
        });
        
foto1Controller.addListener(() {
        form.foto1 = foto1Controller.text;
        });
        
foto2Controller.addListener(() {
        form.foto2 = foto2Controller.text;
        });
        
deskripsiController.addListener(() {
        form.deskripsi = deskripsiController.text;
        });
        


    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenArgument =
          ModalRoute.of(context)!.settings.arguments as DataLokasiTambahArguments;

      if (screenArgument != null) {
        
      }

      setState(() {});
      
    });
    
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener(
      bloc: BlocProvider.of<DataLokasiSimpanBloc>(context),
      listener: ((context, state) {
        if (state is DataLokasiSimpanLoadSuccess) {
          const snackBar = SnackBar(
            content: Text('Data berhasil disimpan'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pop();
        }
        if (state is DataLokasiSimpanLoadFailure) {
          const snackBar = SnackBar(
            content: Text('Data gagal disimpan'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }),
      child: BlocBuilder<DataLokasiSimpanBloc, DataLokasiSimpanState>(
        builder: (context, state) {
          return 
             Scaffold(
          appBar: AppBar(title: Text(screenArgument?.judul ?? "")),
          body:  SingleChildScrollView(
                  child: Form(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white70, width: 3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: Column(
                          children: [
                            // const LoginDataLokasiScreen(),
                            /* const Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 5),
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'Selamat datang',
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ), */
                            
                            const SizedBox(height: 15),
                            const SizedBox(
                              width: double.infinity,
                              child: Text(
                                'Silahkan lengkapi form',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            const SizedBox(height: 15),
                            
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Id Lokasi',
                      ),
                      controller: idLokasiController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Nama',
                      ),
                      controller: namaController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Foto1',
                      ),
                      controller: foto1Controller,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Foto2',
                      ),
                      controller: foto2Controller,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Deskripsi',
                      ),
                      controller: deskripsiController,
                    ),
                    const SizedBox(height: 15),
        


                            const SizedBox(height: 15),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: 
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    primary: Style.buttonBackgroundColor,
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<DataLokasiSimpanBloc>(context)
                                        .add(FetchDataLokasiSimpan(form));
                                  },
                                  child: state is DataLokasiSimpanLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.save),
                                            SizedBox(width: 5),
                                            Text(
                                              "Simpan",
                                              style:
                                                  TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  ),
              );
            },
        ),
    );
  }

  @override
  void dispose() {
    idLokasiController.dispose();
namaController.dispose();
foto1Controller.dispose();
foto2Controller.dispose();
deskripsiController.dispose();

    super.dispose();
  }

}


class DataLokasiTambahArguments {
  final DataLokasi data;
  final String judul;

  DataLokasiTambahArguments({
    required this.data,
    required this.judul,
  });
}
