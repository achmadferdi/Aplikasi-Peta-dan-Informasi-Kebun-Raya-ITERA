import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data_pengguna/bloc/data_pengguna_bloc.dart';
import 'package:ridikc_crud/data_pengguna/bloc/data_pengguna_hapus_bloc.dart';
import 'package:ridikc_crud/data_pengguna/bloc/data_pengguna_simpan_bloc.dart';
import 'package:ridikc_crud/data_pengguna/bloc/data_pengguna_ubah_bloc.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna_apidata.dart';
import 'package:ridikc_crud/data_pengguna/data_pengguna_tambah.dart';
import 'package:ridikc_crud/data_pengguna/data_pengguna_tampil.dart';
import 'package:ridikc_crud/data_pengguna/data_pengguna_ubah.dart';
import 'package:ridikc_crud/widgets/loading_widget.dart';
import 'package:ridikc_crud/widgets/tombol.dart';
import 'package:ridikc_crud/config/config_session_manager.dart';
import 'data/data_pengguna.dart';

class DataPenggunaScreen extends StatefulWidget {
  static const routeName = '/data_pengguna';

  const DataPenggunaScreen ({super.key});

  @override
  State<DataPenggunaScreen> createState() => _DataPenggunaScreenState();
}

class _DataPenggunaScreenState extends State<DataPenggunaScreen> {
  DataFilter filter = const DataFilter();
  
  List<Map<String, dynamic>> listPencarian = [
    
    {"key": "id_pengguna", "value": "Id Pengguna"},

    {"key": "nama", "value": "Nama"},

    {"key": "alamat", "value": "Alamat"},

    {"key": "jenis_kelamin", "value": "Jenis Kelamin"},

    {"key": "no_telepon", "value": "No Telepon"},

    {"key": "username", "value": "Username"},

    {"key": "password", "value": "Password"},

  ];

  String valuePencarian = "id_pengguna";

  var pencarianController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Pengguna',
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DataPenggunaHapusBloc,
              DataPenggunaHapusState>(
            listener: (context, state) {
              if (state is DataPenggunaHapusLoadSuccess) {
                fetchData();
              }
            },
          ),
          BlocListener<DataPenggunaUbahBloc, DataPenggunaUbahState>(
            listener: (context, state) {
              if (state is DataPenggunaUbahLoadSuccess) {
                fetchData();
              }
            },
          ),
          BlocListener<DataPenggunaSimpanBloc, DataPenggunaSimpanState>(
            listener: (context, state) {
              if (state is DataPenggunaSimpanLoadSuccess) {
                fetchData();
              }
            },
          ),
        ],
        child: Stack(
          children: [
            ListView(
              children: [
                Image.asset(
                  "assets/background_data.png",
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 10,
              child: Image.asset(
                "assets/avatar.png",
                height: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: const Text(
                        "Silahkan Input Data Pengguna",
                        style: TextStyle(fontSize: 18),
                      ),
                    ), */
                      Row(
                        children: [
                          TombolTambahWidget(
                            onPress: () async {
                              await Navigator.pushNamed(
                                context,
                                DataPenggunaTambahScreen.routeName,
                                arguments: DataPenggunaTambahArguments(
                                  data: DataPengguna(),
                                  judul: "Tambah Data Pengguna",
                                ),
                              );
                              fetchData();
                            },
                          ),
                          const SizedBox(width: 10),
                          TombolRefreshWidget(
                            onPress: () {
                              fetchData();
                            },
                          ),
                          const SizedBox(width: 10),
                          TombolCariWidget(
                            onPress: () {
                              _showPencarianDialog();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Builder(builder: (context) {
                        final stateData =
                            context.watch<DataPenggunaBloc>().state;
                        final stateHapus =
                            context.watch<DataPenggunaHapusBloc>().state;
                        if (stateData is DataPenggunaLoading ||
                            stateHapus is DataPenggunaHapusLoading) {
                          return const LoadingWidget();
                        }
                        if (stateData is DataPenggunaLoadSuccess) {
                          List<DataPenggunaApiData> data =
                              stateData.data.result;
                          if (data.isEmpty) {
                            return NoInternetWidget(
                              pesan: "Maaf, data masih kosong!",
                            );
                          }
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: ((context, index) {
                              return DataPenggunaTampil(
                                data: data[index],
                                onTapHapus: (value) async {
                                  BlocProvider.of<DataPenggunaHapusBloc>(
                                    context,
                                  ).add(
                                    FetchDataPenggunaHapus(
                                      data: value,
                                    ),
                                  );
                                },
                                onTapEdit: (value) async {
                                  var data = DataPengguna(
									idPengguna : value.idPengguna,
									nama : value.nama,
									alamat : value.alamat,
									jenisKelamin : value.jenisKelamin,
									noTelepon : value.noTelepon,
									username : value.username,
									password : value.password,
                                  );
                                  await Navigator.of(context).pushNamed(
                                    DataPenggunaUbahScreen.routeName,
                                    arguments: DataPenggunaUbahArguments(
                                      data: data,
                                      judul: "Edit Data Pengguna",
                                    ),
                                  );
                                  fetchData();
                                },
                              );
                            }),
                          );
                        }
                        if (stateData is DataPenggunaLoadFailure) {
                          return NoInternetWidget(pesan: stateData.pesan);
                        }
                        return NoInternetWidget();
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showPencarianDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text('Pencarian'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  DropdownButtonFormField<String>(
                    value: valuePencarian,
                    decoration: const InputDecoration(
                      isDense: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      filled: true,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        valuePencarian = value!;
                      });
                    },
                    items: listPencarian.map((Map<String, dynamic> item) {
                      return DropdownMenuItem<String>(
                        value: item["key"],
                        child: Text(
                          item["value"],
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: pencarianController,
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'Cari disini',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text('Cari'),
                        onPressed: () {
                          filter = filter.copyWith(
                            berdasarkan: valuePencarian,
                            isi: pencarianController.text,
                          );

                          fetchData();

                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Batal'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void getSession() async {
    var session = await ConfigSessionManager.getInstance().getData();
    if (session == null) {
      return;
    }
    filter = DataFilter(idPeserta: "${session.id}");
    fetchData();
  }

  @override
  void dispose() {
    pencarianController.dispose();
    super.dispose();
  }

  void fetchData() async {
    BlocProvider.of<DataPenggunaBloc>(context).add(
      FetchDataPengguna(filter),
    );
  }
}

