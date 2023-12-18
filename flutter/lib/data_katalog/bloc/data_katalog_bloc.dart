import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/data_katalog/bloc/data_katalog_event.dart';
import 'package:ridikc_crud/data_katalog/bloc/data_katalog_state.dart';
import 'package:ridikc_crud/data_katalog/data/data_katalog_api.dart';
import 'package:ridikc_crud/data_katalog/repo/data_katalog_remote.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi_api.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi_apidata.dart';
import 'package:ridikc_crud/data_lokasi/repo/data_lokasi_remote.dart';
import 'package:ridikc_crud/utils/network_info.dart';
import 'package:rxdart/rxdart.dart';

class DataKatalogBloc extends Bloc<DataKatalogEvent, DataKatalogState> {
  DataLokasiRemote remoteRepo = DataLokasiRemote();

  // DataKatalogLocal localRepo = DataKatalogLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataKatalogBloc() : super(DataKatalogInitial()) {
    on<FetchDataKatalog>(
      ((event, emit) async {
        emit(DataKatalogLoading());
        // if (!await networkInfo.isConnected) {
        //   emit(DataKatalogNoInternet());
        //   return;
        // }
        try {
          final DataLokasiApi response = await remoteRepo.getData(event.filter);
          emit(DataKatalogLoadSuccess(data: response));
        } catch (e) {
          debugPrint(e.toString());
          await Future.delayed(const Duration(milliseconds: 2500));
          emit(const DataKatalogLoadFailure(
              pesan: "Gagal load data, cek koneksi internet!"));
        }
      }),
      // transformer: debounce(const Duration(milliseconds: 1500)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}

/*
BLOC STATE
*/
