import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi_api.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi.dart';
import 'package:ridikc_crud/data_lokasi/repo/data_lokasi_remote.dart';
// import 'package:ridikc_crud/data_lokasi/repo/DataLokasiUbah_local.dart';
import 'package:ridikc_crud/utils/network_info.dart';

class DataLokasiUbahBloc extends Bloc<DataLokasiUbahEvent, DataLokasiUbahState> {
  DataLokasiRemote remoteRepo = DataLokasiRemote();
  // DataLokasiUbahLocal localRepo = DataLokasiUbahLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataLokasiUbahBloc() : super(DataLokasiUbahInitial()) {
    on<FetchDataLokasiUbah>(((event, emit) async {
      emit(DataLokasiUbahLoading());
      if (!await networkInfo.isConnected) {
        emit(DataLokasiUbahNoInternet());
        return;
      }
      try {
        await remoteRepo.ubah(event.filter);
        emit(
          DataLokasiUbahLoadSuccess(
            data: DataLokasiApi("berhasil", []),
          ),
        );
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataLokasiUbahLoadFailure(pesan: "Gagal mengubah, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataLokasiUbahEvent extends Equatable {
  const DataLokasiUbahEvent();

  @override
  List<Object> get props => [];
}

class FetchDataLokasiUbah extends DataLokasiUbahEvent {
  final DataLokasi filter;

  const FetchDataLokasiUbah(this.filter);
}

/*
BLOC STATE
*/
abstract class DataLokasiUbahState extends Equatable {
  const DataLokasiUbahState();

  @override
  List<Object> get props => [];
}

class DataLokasiUbahInitial extends DataLokasiUbahState {}

class DataLokasiUbahLoading extends DataLokasiUbahState {}

class DataLokasiUbahLoadSuccess extends DataLokasiUbahState {
  final DataLokasiApi data;
  const DataLokasiUbahLoadSuccess({required this.data});
}

class DataLokasiUbahNoInternet extends DataLokasiUbahState {}

class DataLokasiUbahLoadFailure extends DataLokasiUbahState {
  final String pesan;
  const DataLokasiUbahLoadFailure({required this.pesan});
}

