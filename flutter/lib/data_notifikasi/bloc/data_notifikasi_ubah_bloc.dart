import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi_api.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi.dart';
import 'package:ridikc_crud/data_notifikasi/repo/data_notifikasi_remote.dart';
// import 'package:ridikc_crud/data_notifikasi/repo/DataNotifikasiUbah_local.dart';
import 'package:ridikc_crud/utils/network_info.dart';

class DataNotifikasiUbahBloc extends Bloc<DataNotifikasiUbahEvent, DataNotifikasiUbahState> {
  DataNotifikasiRemote remoteRepo = DataNotifikasiRemote();
  // DataNotifikasiUbahLocal localRepo = DataNotifikasiUbahLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataNotifikasiUbahBloc() : super(DataNotifikasiUbahInitial()) {
    on<FetchDataNotifikasiUbah>(((event, emit) async {
      emit(DataNotifikasiUbahLoading());
      if (!await networkInfo.isConnected) {
        emit(DataNotifikasiUbahNoInternet());
        return;
      }
      try {
        await remoteRepo.ubah(event.filter);
        emit(
          DataNotifikasiUbahLoadSuccess(
            data: DataNotifikasiApi("berhasil", []),
          ),
        );
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataNotifikasiUbahLoadFailure(pesan: "Gagal mengubah, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataNotifikasiUbahEvent extends Equatable {
  const DataNotifikasiUbahEvent();

  @override
  List<Object> get props => [];
}

class FetchDataNotifikasiUbah extends DataNotifikasiUbahEvent {
  final DataNotifikasi filter;

  const FetchDataNotifikasiUbah(this.filter);
}

/*
BLOC STATE
*/
abstract class DataNotifikasiUbahState extends Equatable {
  const DataNotifikasiUbahState();

  @override
  List<Object> get props => [];
}

class DataNotifikasiUbahInitial extends DataNotifikasiUbahState {}

class DataNotifikasiUbahLoading extends DataNotifikasiUbahState {}

class DataNotifikasiUbahLoadSuccess extends DataNotifikasiUbahState {
  final DataNotifikasiApi data;
  const DataNotifikasiUbahLoadSuccess({required this.data});
}

class DataNotifikasiUbahNoInternet extends DataNotifikasiUbahState {}

class DataNotifikasiUbahLoadFailure extends DataNotifikasiUbahState {
  final String pesan;
  const DataNotifikasiUbahLoadFailure({required this.pesan});
}

