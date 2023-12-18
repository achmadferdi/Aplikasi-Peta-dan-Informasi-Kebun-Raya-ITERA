import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ridikc_crud/config/color.dart';
import 'package:ridikc_crud/enum/enum_widget.dart';
import 'package:ridikc_crud/enum/repo/enum_remote.dart';
import 'package:ridikc_crud/data_admin/bloc/data_admin_bloc.dart';
import 'package:ridikc_crud/data_admin/bloc/data_admin_ubah_bloc.dart';
import 'package:ridikc_crud/data_admin/data/data_admin.dart';


class DataAdminUbahScreen extends StatefulWidget {
  static const routeName = "data_admin/edit";
  const DataAdminUbahScreen({super.key});

  @override
  State<DataAdminUbahScreen> createState() => _DataAdminUbahScreenState();
}

class _DataAdminUbahScreenState extends State<DataAdminUbahScreen> {
  EnumRemote enumRemote = EnumRemote();
  
  DataAdminUbahArguments? screenArgument;

  DataAdmin form = DataAdmin();
    
  var idAdminController = TextEditingController();
var namaController = TextEditingController();
var usernameController = TextEditingController();
var passwordController = TextEditingController();


  @override
  void initState() {
    super.initState();

    idAdminController.addListener(() {
        form.idAdmin = idAdminController.text;
        });
        
namaController.addListener(() {
        form.nama = namaController.text;
        });
        
usernameController.addListener(() {
        form.username = usernameController.text;
        });
        
passwordController.addListener(() {
        form.password = passwordController.text;
        });
        

    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenArgument =
          ModalRoute.of(context)!.settings.arguments as DataAdminUbahArguments;

      if (screenArgument != null) {
    
            idAdminController.text = screenArgument?.data.idAdmin ?? "";
    namaController.text = screenArgument?.data.nama ?? "";
    usernameController.text = screenArgument?.data.username ?? "";
    passwordController.text = screenArgument?.data.password ?? "";

    
      }

      setState(() {});
      
    });

  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments
        as DataAdminUbahArguments;

    /*
    idProgramHafalanController.text = args.data.idProgramHafalan ?? "";
    tanggalController.text = args.data.tanggal ?? "";
    hapalanController.text = args.data.hapalan ?? "";
    keteranganController.text = args.data.keterangan ?? "";
    */


    return BlocListener(
      bloc: BlocProvider.of<DataAdminUbahBloc>(context),
      listener: ((context, state) {
        if (state is DataAdminUbahLoadSuccess) {
          const snackBar = SnackBar(
            content: Text('Data berhasil diubah'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is DataAdminUbahLoadFailure) {
          const snackBar = SnackBar(
            content: Text('Data gagal diubah'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }),
      child: BlocBuilder<DataAdminUbahBloc, DataAdminUbahState>(
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
                        // const LoginDataAdminScreen(),
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
                        labelText: 'Id Admin',
                      ),
                      controller: idAdminController,
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
                        labelText: 'Username',
                      ),
                      controller: usernameController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      controller: passwordController,
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
                                    BlocProvider.of<DataAdminUbahBloc>(context)
                                        .add(FetchDataAdminUbah(form));
                                  },
                                  child: state is DataAdminUbahLoading
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
    idAdminController.dispose();
namaController.dispose();
usernameController.dispose();
passwordController.dispose();

    super.dispose();
  }

}


class DataAdminUbahArguments {
  final DataAdmin data;
  final String judul;

  DataAdminUbahArguments({
    required this.data,
    required this.judul,
  });
}
