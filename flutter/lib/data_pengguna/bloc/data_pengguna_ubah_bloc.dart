import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna_api.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna.dart';
import 'package:ridikc_crud/data_pengguna/repo/data_pengguna_remote.dart';
// import 'package:ridikc_crud/data_pengguna/repo/DataPenggunaUbah_local.dart';
import 'package:ridikc_crud/utils/network_info.dart';

class DataPenggunaUbahBloc
    extends Bloc<DataPenggunaUbahEvent, DataPenggunaUbahState> {
  DataPenggunaRemote remoteRepo = DataPenggunaRemote();
  // DataPenggunaUbahLocal localRepo = DataPenggunaUbahLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataPenggunaUbahBloc() : super(DataPenggunaUbahInitial()) {
    on<FetchDataPenggunaUbah>(((event, emit) async {
      emit(DataPenggunaUbahLoading());

      await Future.delayed(const Duration(seconds: 5));

      if (!await networkInfo.isConnected) {
        emit(DataPenggunaUbahNoInternet());
        return;
      }
      try {
        await remoteRepo.ubah(event.filter);
        emit(
          DataPenggunaUbahLoadSuccess(
            data: DataPenggunaApi("berhasil", []),
          ),
        );
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataPenggunaUbahLoadFailure(
            pesan: "Gagal mengubah, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataPenggunaUbahEvent extends Equatable {
  const DataPenggunaUbahEvent();

  @override
  List<Object> get props => [];
}

class FetchDataPenggunaUbah extends DataPenggunaUbahEvent {
  final DataPengguna filter;

  const FetchDataPenggunaUbah(this.filter);
}

/*
BLOC STATE
*/
abstract class DataPenggunaUbahState extends Equatable {
  const DataPenggunaUbahState();

  @override
  List<Object> get props => [];
}

class DataPenggunaUbahInitial extends DataPenggunaUbahState {}

class DataPenggunaUbahLoading extends DataPenggunaUbahState {}

class DataPenggunaUbahLoadSuccess extends DataPenggunaUbahState {
  final DataPenggunaApi data;
  const DataPenggunaUbahLoadSuccess({required this.data});
}

class DataPenggunaUbahNoInternet extends DataPenggunaUbahState {}

class DataPenggunaUbahLoadFailure extends DataPenggunaUbahState {
  final String pesan;
  const DataPenggunaUbahLoadFailure({required this.pesan});
}
