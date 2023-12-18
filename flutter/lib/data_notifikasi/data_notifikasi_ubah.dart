import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ridikc_crud/config/color.dart';
import 'package:ridikc_crud/enum/enum_widget.dart';
import 'package:ridikc_crud/enum/repo/enum_remote.dart';
import 'package:ridikc_crud/data_notifikasi/bloc/data_notifikasi_bloc.dart';
import 'package:ridikc_crud/data_notifikasi/bloc/data_notifikasi_ubah_bloc.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi.dart';


class DataNotifikasiUbahScreen extends StatefulWidget {
  static const routeName = "data_notifikasi/edit";
  const DataNotifikasiUbahScreen({super.key});

  @override
  State<DataNotifikasiUbahScreen> createState() => _DataNotifikasiUbahScreenState();
}

class _DataNotifikasiUbahScreenState extends State<DataNotifikasiUbahScreen> {
  EnumRemote enumRemote = EnumRemote();
  
  DataNotifikasiUbahArguments? screenArgument;

  DataNotifikasi form = DataNotifikasi();
    
  var idNotifikasiController = TextEditingController();
var notifikasiController = TextEditingController();
var namaController = TextEditingController();
var statusController = TextEditingController();
List<String> status = [];
 
        fetchStatus() async {
            var data = await enumRemote.getData('data_notifikasi', 'status');
            status = data.result;
        }
        


  @override
  void initState() {
    super.initState();

    idNotifikasiController.addListener(() {
        form.idNotifikasi = idNotifikasiController.text;
        });
        
notifikasiController.addListener(() {
        form.notifikasi = notifikasiController.text;
        });
        
namaController.addListener(() {
        form.nama = namaController.text;
        });
        
statusController.addListener(() {
        form.status = statusController.text;
        });
        
fetchStatus();

    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenArgument =
          ModalRoute.of(context)!.settings.arguments as DataNotifikasiUbahArguments;

      if (screenArgument != null) {
    
            idNotifikasiController.text = screenArgument?.data.idNotifikasi ?? "";
    notifikasiController.text = screenArgument?.data.notifikasi ?? "";
    namaController.text = screenArgument?.data.nama ?? "";
    statusController.text = screenArgument?.data.status ?? "";

    
      }

      setState(() {});
      
    });

  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments
        as DataNotifikasiUbahArguments;

    /*
    idProgramHafalanController.text = args.data.idProgramHafalan ?? "";
    tanggalController.text = args.data.tanggal ?? "";
    hapalanController.text = args.data.hapalan ?? "";
    keteranganController.text = args.data.keterangan ?? "";
    */


    return BlocListener(
      bloc: BlocProvider.of<DataNotifikasiUbahBloc>(context),
      listener: ((context, state) {
        if (state is DataNotifikasiUbahLoadSuccess) {
          const snackBar = SnackBar(
            content: Text('Data berhasil diubah'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is DataNotifikasiUbahLoadFailure) {
          const snackBar = SnackBar(
            content: Text('Data gagal diubah'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }),
      child: BlocBuilder<DataNotifikasiUbahBloc, DataNotifikasiUbahState>(
        builder: (context, state) {
          return Scaffold(
          appBar: AppBar(title: Text(screenArgument?.judul ?? "")),
          body: SingleChildScrollView(
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
                        // const LoginDataNotifikasiScreen(),
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
                        labelText: 'Id Notifikasi',
                      ),
                      controller: idNotifikasiController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Notifikasi',
                      ),
                      controller: notifikasiController,
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
          readOnly: true,
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Pilih Status'),
                  content: EnumWidget(
                    items: status,
                    onChange: (String value) {
                      statusController.text = value;
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            );
          },
          controller: statusController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.book),
            suffixIcon: Icon(Icons.keyboard_arrow_down),
            border: OutlineInputBorder(),
            labelText: 'Status',
          ),
        ),
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
                                    BlocProvider.of<DataNotifikasiUbahBloc>(context)
                                        .add(FetchDataNotifikasiUbah(form));
                                  },
                                  child: state is DataNotifikasiUbahLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.save),
                                            SizedBox(width: 5),
                                            Text(
                                              "Ubah",
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
          )
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    idNotifikasiController.dispose();
notifikasiController.dispose();
namaController.dispose();
statusController.dispose();

    super.dispose();
  }

}


class DataNotifikasiUbahArguments {
  final DataNotifikasi data;
  final String judul;

  DataNotifikasiUbahArguments({
    required this.data,
    required this.judul,
  });
}
