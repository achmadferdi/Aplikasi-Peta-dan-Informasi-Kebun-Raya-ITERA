import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data_notifikasi/bloc/data_notifikasi_bloc.dart';
import 'package:ridikc_crud/data_notifikasi/bloc/data_notifikasi_hapus_bloc.dart';
import 'package:ridikc_crud/data_notifikasi/bloc/data_notifikasi_simpan_bloc.dart';
import 'package:ridikc_crud/data_notifikasi/bloc/data_notifikasi_ubah_bloc.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi_apidata.dart';
import 'package:ridikc_crud/data_notifikasi/data_notifikasi_tambah.dart';
import 'package:ridikc_crud/data_notifikasi/data_notifikasi_tampil.dart';
import 'package:ridikc_crud/data_notifikasi/data_notifikasi_ubah.dart';
import 'package:ridikc_crud/widgets/loading_widget.dart';
import 'package:ridikc_crud/widgets/tombol.dart';
import 'package:ridikc_crud/config/config_session_manager.dart';
import 'data/data_notifikasi.dart';

class DataNotifikasiScreen extends StatefulWidget {
  static const routeName = '/data_notifikasi';

  const DataNotifikasiScreen({super.key});

  @override
  State<DataNotifikasiScreen> createState() => _DataNotifikasiScreenState();
}

class _DataNotifikasiScreenState extends State<DataNotifikasiScreen> {
  DataFilter filter = const DataFilter();

  List<Map<String, dynamic>> listPencarian = [
    {"key": "id_notifikasi", "value": "Id Notifikasi"},
    {"key": "notifikasi", "value": "Notifikasi"},
    {"key": "nama", "value": "Nama"},
    {"key": "status", "value": "Status"},
  ];

  String valuePencarian = "id_notifikasi";

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
          'Data Notifikasi',
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DataNotifikasiHapusBloc, DataNotifikasiHapusState>(
            listener: (context, state) {
              if (state is DataNotifikasiHapusLoadSuccess) {
                fetchData();
              }
            },
          ),
          BlocListener<DataNotifikasiUbahBloc, DataNotifikasiUbahState>(
            listener: (context, state) {
              if (state is DataNotifikasiUbahLoadSuccess) {
                fetchData();
              }
            },
          ),
          BlocListener<DataNotifikasiSimpanBloc, DataNotifikasiSimpanState>(
            listener: (context, state) {
              if (state is DataNotifikasiSimpanLoadSuccess) {
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
                        "Silahkan Input Data Notifikasi",
                        style: TextStyle(fontSize: 18),
                      ),
                    ), */
                      Row(
                        children: [
                          TombolTambahWidget(
                            onPress: () async {
                              await Navigator.pushNamed(
                                context,
                                DataNotifikasiTambahScreen.routeName,
                                arguments: DataNotifikasiTambahArguments(
                                  data: DataNotifikasi(),
                                  judul: "Tambah Data Notifikasi",
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
                            context.watch<DataNotifikasiBloc>().state;
                        final stateHapus =
                            context.watch<DataNotifikasiHapusBloc>().state;
                        if (stateData is DataNotifikasiLoading ||
                            stateHapus is DataNotifikasiHapusLoading) {
                          return const LoadingWidget();
                        }
                        if (stateData is DataNotifikasiLoadSuccess) {
                          List<DataNotifikasiApiData> data =
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
                              return DataNotifikasiTampil(
                                data: data[index],
                                onTapHapus: (value) async {
                                  BlocProvider.of<DataNotifikasiHapusBloc>(
                                    context,
                                  ).add(
                                    FetchDataNotifikasiHapus(
                                      data: value,
                                    ),
                                  );
                                },
                                onTapEdit: (value) async {
                                  var data = DataNotifikasi(
                                    idNotifikasi: value.idNotifikasi,
                                    notifikasi: value.notifikasi,
                                    nama: value.nama,
                                    status: value.status,
                                  );
                                  await Navigator.of(context).pushNamed(
                                    DataNotifikasiUbahScreen.routeName,
                                    arguments: DataNotifikasiUbahArguments(
                                      data: data,
                                      judul: "Edit Data Notifikasi",
                                    ),
                                  );
                                  fetchData();
                                },
                              );
                            }),
                          );
                        }
                        if (stateData is DataNotifikasiLoadFailure) {
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
    BlocProvider.of<DataNotifikasiBloc>(context).add(
      FetchDataNotifikasi(filter),
    );
  }
}
