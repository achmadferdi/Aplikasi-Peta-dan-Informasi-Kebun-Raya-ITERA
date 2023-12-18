import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ridikc_crud/config/color.dart';
import 'package:ridikc_crud/config/config_session_manager.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data_admin/bloc/data_admin_ubah_bloc.dart';
import 'package:ridikc_crud/data_pengguna/bloc/data_pengguna_bloc.dart';
import 'package:ridikc_crud/data_pengguna/bloc/data_pengguna_hapus_bloc.dart';
import 'package:ridikc_crud/data_pengguna/bloc/data_pengguna_simpan_bloc.dart';
import 'package:ridikc_crud/data_pengguna/bloc/data_pengguna_ubah_bloc.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna_api.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna_apidata.dart';
import 'package:ridikc_crud/enum/enum_widget.dart';
import 'package:ridikc_crud/enum/repo/enum_remote.dart';
import 'package:ridikc_crud/login/data/login_apidata.dart';
import 'package:ridikc_crud/login/login_screen.dart';
import 'package:ridikc_crud/widgets/loading_widget.dart';
import 'package:shimmer/shimmer.dart';

class ProfilScreen extends StatefulWidget {
  static const routeName = "profil";

  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  LoginApiData? data;
  EnumRemote enumRemote = EnumRemote();

  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    var data = await ConfigSessionManager.getInstance().getData();
    if (data != null) {
      setState(() {
        this.data = data;
      });
      return;
    }
    await ConfigSessionManager.getInstance().setSudahLogin(false);
    if (mounted) {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        actions: [
          // IconButton(onPressed: () {}, icon: const Icon(Icons.save)),
          IconButton(
            onPressed: () async {
              await ConfigSessionManager.getInstance().logout();
              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginScreen.routeName,
                  (Route<dynamic> route) => false,
                );
              }
            },
            icon: const Icon(Icons.logout_rounded),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Image.asset(
                  'assets/background_login.png',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          Image.asset("assets/logo_depan.png", height: 80),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              "${_viewNama(data)}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          const SizedBox(height: 9),
                        ],
                      ),
                    ),
                  ),
                ),
                if (data != null) FormProfil(dataLogin: data!),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _viewNama(LoginApiData? data) {
    if (data == null) {
      return "-";
    }
    return data.namaPegawai;
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class FormProfil extends StatefulWidget {
  final LoginApiData dataLogin;
  const FormProfil({super.key, required this.dataLogin});

  @override
  State<FormProfil> createState() => _FormProfilState();
}

class _FormProfilState extends State<FormProfil> {
  EnumRemote enumRemote = EnumRemote();

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
    var data = await enumRemote.getData('data_pengguna', 'jenis_kelamin');
    jenisKelamin = data.result;
  }

  DataFilter filter = const DataFilter();

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

    filter = DataFilter(idPeserta: "${widget.dataLogin.id}");

    fetchData();
  }

  void fetchData() async {
    BlocProvider.of<DataPenggunaBloc>(context).add(
      FetchDataPengguna(filter),
    );
  }

  @override
  Widget build(BuildContext context) {
    final stateData = context.watch<DataPenggunaBloc>().state;
    return MultiBlocListener(
      listeners: [
        BlocListener<DataPenggunaUbahBloc, DataPenggunaUbahState>(
          listener: (context, state) {
            if (state is DataPenggunaUbahLoadSuccess) {
              const snackBar = SnackBar(
                content: Text('Data berhasil disimpan'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (state is DataPenggunaUbahLoadFailure) {
              const snackBar = SnackBar(
                content: Text('Data gagal disimpan'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
        ),
        BlocListener<DataPenggunaBloc, DataPenggunaState>(
          listener: (context, state) {
            if (state is DataPenggunaLoadSuccess) {
              if (state.data.result.isNotEmpty) {
                DataPenggunaApiData data = state.data.result.first;
                idPenggunaController.text = "${data.idPengguna}";
                namaController.text = "${data.nama}";
                alamatController.text = "${data.alamat}";
                jenisKelaminController.text = "${data.jenisKelamin}";
                noTeleponController.text = "${data.noTelepon}";
                usernameController.text = "${data.username}";
              }
            }
          },
        ),
      ],
      child: BlocBuilder<DataPenggunaUbahBloc, DataPenggunaUbahState>(
        builder: (context, state) {
          if (stateData is DataPenggunaLoadSuccess) {
            return Form(
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
                        readOnly: state is DataPenggunaUbahLoading,
                        controller: namaController,
                      ),
                      const SizedBox(height: 15),

                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.book),
                          border: OutlineInputBorder(),
                          labelText: 'Alamat',
                        ),
                        readOnly: state is DataPenggunaUbahLoading,
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
                        readOnly: state is DataPenggunaUbahLoading,
                        controller: noTeleponController,
                      ),
                      const SizedBox(height: 15),

                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.book),
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                        ),
                        readOnly: state is DataPenggunaUbahLoading,
                        controller: usernameController,
                      ),
                      const SizedBox(height: 15),

                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.book),
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        readOnly: state is DataPenggunaUbahLoading,
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
                            BlocProvider.of<DataPenggunaUbahBloc>(context)
                                .add(FetchDataPenggunaUbah(form));
                          },
                          child: state is DataPenggunaUbahLoading
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.grey[350]!,
            period: const Duration(milliseconds: 1000),
            child: ShimmerLayout(),
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

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width;
    double containerHeight = 30;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: containerHeight,
            width: containerWidth,
            color: Colors.grey,
          ),
          SizedBox(height: 12),
          Container(
            height: containerHeight,
            width: containerWidth,
            color: Colors.grey,
          ),
          SizedBox(height: 12),
          Container(
            height: containerHeight,
            width: containerWidth,
            color: Colors.grey,
          ),
          SizedBox(height: 12),
          Container(
            height: containerHeight,
            width: containerWidth,
            color: Colors.grey,
          ),
          SizedBox(height: 12),
          Container(
            height: containerHeight,
            width: containerWidth,
            color: Colors.grey,
          ),
          SizedBox(height: 12),
          Container(
            height: containerHeight,
            width: containerWidth,
            color: Colors.grey,
          ),
          SizedBox(height: 12),
          Container(
            height: containerHeight,
            width: containerWidth,
            color: Colors.grey,
          ),
          SizedBox(height: 12),
          Container(
            height: containerHeight,
            width: containerWidth,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
