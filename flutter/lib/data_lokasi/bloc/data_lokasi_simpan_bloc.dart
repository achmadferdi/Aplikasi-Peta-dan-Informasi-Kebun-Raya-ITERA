import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi_api.dart';
import 'package:ridikc_crud/data_lokasi/repo/data_lokasi_remote.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi.dart';
// import 'package:ridikc_crud/data_lokasi/repo/DataLokasiSimpan_local.dart';
import 'package:ridikc_crud/utils/network_info.dart';

class DataLokasiSimpanBloc extends Bloc<DataLokasiSimpanEvent, DataLokasiSimpanState> {
  DataLokasiRemote remoteRepo = DataLokasiRemote();
  // DataLokasiSimpanLocal localRepo = DataLokasiSimpanLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataLokasiSimpanBloc() : super(DataLokasiSimpanInitial()) {
    on<FetchDataLokasiSimpan>(((event, emit) async {
      emit(DataLokasiSimpanLoading());
      /* if (!await networkInfo.isConnected) {
        emit(DataLokasiSimpanNoInternet());
        return;
      } */
      try {
        await remoteRepo.simpan(event.data);
        emit(DataLokasiSimpanLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(
          const DataLokasiSimpanLoadFailure(pesan: "Gagal menyimpan, Pastikan hp terhubung ke internet"),
        );
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataLokasiSimpanEvent extends Equatable {
  const DataLokasiSimpanEvent();

  @override
  List<Object> get props => [];
}

class FetchDataLokasiSimpan extends DataLokasiSimpanEvent {
  final DataLokasi data;

  const FetchDataLokasiSimpan(this.data);
}

/*
BLOC STATE
*/
abstract class DataLokasiSimpanState extends Equatable {
  const DataLokasiSimpanState();

  @override
  List<Object> get props => [];
}

class DataLokasiSimpanInitial extends DataLokasiSimpanState {}

class DataLokasiSimpanLoading extends DataLokasiSimpanState {}

class DataLokasiSimpanLoadSuccess extends DataLokasiSimpanState {
}

class DataLokasiSimpanNoInternet extends DataLokasiSimpanState {}

class DataLokasiSimpanLoadFailure extends DataLokasiSimpanState {
  final String pesan;
  const DataLokasiSimpanLoadFailure({required this.pesan});
}

