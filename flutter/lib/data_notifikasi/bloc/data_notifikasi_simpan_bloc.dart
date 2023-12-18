import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi_api.dart';
import 'package:ridikc_crud/data_notifikasi/repo/data_notifikasi_remote.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi.dart';
// import 'package:ridikc_crud/data_notifikasi/repo/DataNotifikasiSimpan_local.dart';
import 'package:ridikc_crud/utils/network_info.dart';

class DataNotifikasiSimpanBloc extends Bloc<DataNotifikasiSimpanEvent, DataNotifikasiSimpanState> {
  DataNotifikasiRemote remoteRepo = DataNotifikasiRemote();
  // DataNotifikasiSimpanLocal localRepo = DataNotifikasiSimpanLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataNotifikasiSimpanBloc() : super(DataNotifikasiSimpanInitial()) {
    on<FetchDataNotifikasiSimpan>(((event, emit) async {
      emit(DataNotifikasiSimpanLoading());
      /* if (!await networkInfo.isConnected) {
        emit(DataNotifikasiSimpanNoInternet());
        return;
      } */
      try {
        await remoteRepo.simpan(event.data);
        emit(DataNotifikasiSimpanLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(
          const DataNotifikasiSimpanLoadFailure(pesan: "Gagal menyimpan, Pastikan hp terhubung ke internet"),
        );
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataNotifikasiSimpanEvent extends Equatable {
  const DataNotifikasiSimpanEvent();

  @override
  List<Object> get props => [];
}

class FetchDataNotifikasiSimpan extends DataNotifikasiSimpanEvent {
  final DataNotifikasi data;

  const FetchDataNotifikasiSimpan(this.data);
}

/*
BLOC STATE
*/
abstract class DataNotifikasiSimpanState extends Equatable {
  const DataNotifikasiSimpanState();

  @override
  List<Object> get props => [];
}

class DataNotifikasiSimpanInitial extends DataNotifikasiSimpanState {}

class DataNotifikasiSimpanLoading extends DataNotifikasiSimpanState {}

class DataNotifikasiSimpanLoadSuccess extends DataNotifikasiSimpanState {
}

class DataNotifikasiSimpanNoInternet extends DataNotifikasiSimpanState {}

class DataNotifikasiSimpanLoadFailure extends DataNotifikasiSimpanState {
  final String pesan;
  const DataNotifikasiSimpanLoadFailure({required this.pesan});
}

