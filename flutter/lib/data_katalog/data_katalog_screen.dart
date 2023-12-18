import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ridikc_crud/config/config_session_manager.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data_katalog/bloc/data_katalog_bloc.dart';
import 'package:ridikc_crud/data_katalog/bloc/data_katalog_event.dart';
import 'package:ridikc_crud/data_katalog/bloc/data_katalog_state.dart';
import 'package:ridikc_crud/data_katalog/data/data_katalog_apidata.dart';
import 'package:ridikc_crud/data_katalog/data_katalog_tampil.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi_apidata.dart';
import 'package:ridikc_crud/login/data/login_apidata.dart';
import 'package:ridikc_crud/widgets/loading_widget.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ridikc_crud/config/color.dart';

class DataKatalogScreen extends StatefulWidget {
  static const routeName = "data_katalog";

  const DataKatalogScreen({super.key});

  @override
  State<DataKatalogScreen> createState() => _DataKatalogScreenState();
}

class _DataKatalogScreenState extends State<DataKatalogScreen> {
  var pencarianController = TextEditingController();
  var filter = DataPencarian(berdasarkan: "nama_pelatihan");
  final stream = BehaviorSubject<String>();
  LoginApiData? user;

  Future<void> getData() async {
    var data = await ConfigSessionManager.getInstance().getData();
    if (mounted) {
      if (data == null) {
        Navigator.of(context).pop();
        return;
      }
      /* BlocProvider.of<DataTransaksiPelatihanBloc>(context).add(
        FetchDataTransaksiPelatihan(
          DataFilter(berdasarkan: "id_peserta", isi: data.id!),
        ),
      ); */
      user = data;
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DataKatalogBloc>(context).add(FetchDataKatalog(filter));

    getData();

    pencarianController.addListener(() {
      stream.add(pencarianController.text);
    });

    stream
        .debounceTime(const Duration(milliseconds: 700))
        .where((event) => event.length >= 3)
        .listen((value) {
      filter.isi = value;
      BlocProvider.of<DataKatalogBloc>(context).add(FetchDataKatalog(filter));
    });
  }

  @override
  void dispose() {
    stream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<DataKatalogBloc>(context)
                  .add(FetchDataKatalog(filter));
              if (user != null) {
                /* BlocProvider.of<DataTransaksiPelatihanBloc>(context).add(
                  FetchDataTransaksiPelatihan(
                    DataFilter(
                        berdasarkan: "id_peserta", isi: user!.id ?? "*******"),
                  ),
                ); */
              }
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: pencarianController,
                            onFieldSubmitted: (value) {
                              filter.isi = value;
                              BlocProvider.of<DataKatalogBloc>(context).add(
                                FetchDataKatalog(filter),
                              );
                            },
                            textInputAction: TextInputAction.search,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.search_rounded),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(90)),
                                  borderSide: BorderSide(color: Colors.white)),
                              hintText: 'Pencarian',
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 20.0,
                              ),
                            ),
                          ),
                        ),
                        /* BlocListener(
                          bloc: BlocProvider.of<DataTransaksiPelatihanBloc>(
                              context),
                          listener: (context, state) {},
                          child: BlocBuilder<DataTransaksiPelatihanBloc,
                              DataTransaksiPelatihanState>(
                            builder: ((context, state) {
                              int total = 0;
                              if (state is DataTransaksiPelatihanLoadSuccess) {
                                List<DataTransaksiPelatihanApiData> data =
                                    state.data.result;
                                total = data
                                    .where(DataTransaksiHelper.belumDimulai)
                                    .length;
                              }
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    DataTransaksiPelatihanScreen.routeName,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(9),
                                  child: Badge(
                                    badgeContent: Text(total.toString()),
                                    child: const Icon(Icons.receipt_long),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ), */
                      ],
                    ),
                    const SizedBox(height: 10),
                    BlocListener(
                      bloc: BlocProvider.of<DataKatalogBloc>(context),
                      listener: (context, state) {},
                      child: BlocBuilder<DataKatalogBloc, DataKatalogState>(
                        builder: ((context, state) {
                          if (state is DataKatalogLoading) {
                            return const LoadingWidget();
                          }
                          if (state is DataKatalogLoadSuccess) {
                            List<DataLokasiApiData> data = state.data.result;
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: ((context, index) {
                                return DataKatalogTampil(data: data[index]);
                              }),
                            );
                          }
                          // if (state is DataKatalogLoadFailure) {
                          //   return Text('Error ${state.pesan}');
                          // }
                          // if (state is DataKatalogNoInternet) {
                          //   return const NoInternetWidget();
                          // }
                          // return const Text('Preparing');
                          return NoInternetWidget();
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
