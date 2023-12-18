import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/config/color.dart';
import 'package:ridikc_crud/enum/enum_widget.dart';
import 'package:ridikc_crud/enum/repo/enum_remote.dart';
import 'package:ridikc_crud/login/bloc/login_form_bloc.dart';
import 'package:ridikc_crud/login/bloc/login_form_event.dart';
import 'package:intl/intl.dart';
import 'package:ridikc_crud/login/bloc/register_bloc.dart';
import 'package:ridikc_crud/login/bloc/register_event.dart';
import 'package:ridikc_crud/login/bloc/register_state.dart';
import 'package:ridikc_crud/login/data/data_register.dart';
import 'package:intl/intl.dart';
import 'package:ridikc_crud/config/color.dart';
import 'package:ridikc_crud/enum/enum_widget.dart';
import 'package:ridikc_crud/enum/repo/enum_remote.dart';
import 'package:ridikc_crud/data_pengguna/bloc/data_pengguna_simpan_bloc.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  EnumRemote enumRemote = EnumRemote();

  DataRegister form = DataRegister();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<RegisterBloc>(context),
      listener: ((context, state) {
        if (state is RegisterSuccess) {
          // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          BlocProvider.of<LoginFormBloc>(context).add(ShowLogin());
          const snackBar = SnackBar(
            content: Text('Registrasi berhasil, silahkan login!'),
          );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const LoginRegisterWidget(),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 5),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Selamat datang',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Silahkan lengkapi form pendaftaran',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),
                const FormRegister(),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FormRegister extends StatefulWidget {
  static const routeName = "data_pengguna/tambah";
  const FormRegister({super.key});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  EnumRemote enumRemote = EnumRemote();

  DataPenggunaTambahArguments? screenArgument;

  DataPengguna form = DataPengguna();

  var idPenggunaController = TextEditingController();
  var namaController = TextEditingController();
  var alamatController = TextEditingController();
  var jenisKelaminController = TextEditingController();
  var noTeleponController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  List<String> jenisKelamin = [];

  fetchJenisKelamin() async {
    try {
      var data = await enumRemote.getData('data_pengguna', 'jenis_kelamin');
      jenisKelamin = data.result;
    } catch (e) {
      debugPrint("register :: tidak bisa mengakses url enum");
    }
  }

  @override
  void initState() {
    super.initState();

    idPenggunaController.addListener(() {
      form.idPengguna = idPenggunaController.text;
    });

    namaController.addListener(() {
      form.nama = namaController.text;
    });

    alamatController.addListener(() {
      form.alamat = alamatController.text;
    });

    jenisKelaminController.addListener(() {
      form.jenisKelamin = jenisKelaminController.text;
    });

    noTeleponController.addListener(() {
      form.noTelepon = noTeleponController.text;
    });

    usernameController.addListener(() {
      form.username = usernameController.text;
    });

    passwordController.addListener(() {
      form.password = passwordController.text;
    });

    fetchJenisKelamin();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   screenArgument = ModalRoute.of(context)!.settings.arguments
    //       as DataPenggunaTambahArguments?;

    //   if (screenArgument != null) {}

    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<DataPenggunaSimpanBloc>(context),
      listener: ((context, state) {
        if (state is DataPenggunaSimpanLoadSuccess) {
          const snackBar = SnackBar(
            content: Text(
              'Registrasi berhasil, silahkan login',
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          BlocProvider.of<LoginFormBloc>(context).add(ShowLogin());
          // Navigator.of(context).pop();
        }
        if (state is DataPenggunaSimpanLoadFailure) {
          const snackBar = SnackBar(
            content: Text(
              'Registrasi gagal, cek kembali koneksi internet anda',
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }),
      child: BlocBuilder<DataPenggunaSimpanBloc, DataPenggunaSimpanState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white70, width: 3),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    children: [
                      // const LoginDataPenggunaScreen(),
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
                      // TextFormField(
                      //   decoration: const InputDecoration(
                      //     prefixIcon: Icon(Icons.book),
                      //     border: OutlineInputBorder(),
                      //     labelText: 'Id Pengguna',
                      //   ),
                      //   controller: idPenggunaController,
                      // ),
                      // const SizedBox(height: 15),

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
                          labelText: 'Alamat',
                        ),
                        controller: alamatController,
                      ),
                      const SizedBox(height: 15),

                      TextFormField(
                        readOnly: true,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Pilih Jenis Kelamin'),
                                content: EnumWidget(
                                  items: jenisKelamin,
                                  onChange: (String value) {
                                    jenisKelaminController.text = value;
                                    Navigator.of(context).pop();
                                  },
                                ),
                              );
                            },
                          );
                        },
                        controller: jenisKelaminController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.book),
                          suffixIcon: Icon(Icons.keyboard_arrow_down),
                          border: OutlineInputBorder(),
                          labelText: 'Jenis Kelamin',
                        ),
                      ),
                      const SizedBox(height: 15),

                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.book),
                          border: OutlineInputBorder(),
                          labelText: 'No Telepon',
                        ),
                        controller: noTeleponController,
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

                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            primary: Style.buttonBackgroundColor,
                          ),
                          onPressed: () {
                            BlocProvider.of<DataPenggunaSimpanBloc>(context)
                                .add(FetchDataPenggunaSimpan(form));
                          },
                          child: state is DataPenggunaSimpanLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.save),
                                    SizedBox(width: 5),
                                    Text(
                                      "DAFTAR",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Sudah memiliki akun, "),
                          InkWell(
                            onTap: () {
                              BlocProvider.of<LoginFormBloc>(context)
                                  .add(ShowLogin());
                            },
                            child: const Text(
                              "login disini",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
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
    idPenggunaController.dispose();
    namaController.dispose();
    alamatController.dispose();
    jenisKelaminController.dispose();
    noTeleponController.dispose();
    usernameController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}

class DataPenggunaTambahArguments {
  final DataPengguna data;
  final String judul;

  DataPenggunaTambahArguments({
    required this.data,
    required this.judul,
  });
}
