import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna_api.dart';
import 'package:ridikc_crud/data_pengguna/repo/data_pengguna_remote.dart';
// import 'package:ridikc_crud/data_pengguna/repo/DataPengguna_local.dart';
import 'package:ridikc_crud/utils/network_info.dart';

class DataPenggunaBloc extends Bloc<DataPenggunaEvent, DataPenggunaState> {
  DataPenggunaRemote remoteRepo = DataPenggunaRemote();
  // DataPenggunaLocal localRepo = DataPenggunaLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataPenggunaBloc() : super(DataPenggunaInitial()) {
    on<FetchDataPengguna>(((event, emit) async {
      emit(DataPenggunaLoading());
      if (!await networkInfo.isConnected) {
        emit(DataPenggunaNoInternet());
        return;
      }
      try {
        final DataPenggunaApi response = await remoteRepo.detail(event.filter);
        emit(DataPenggunaLoadSuccess(data: response));
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataPenggunaLoadFailure(pesan: "Tidak dapat mengambil data, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataPenggunaEvent extends Equatable {
  const DataPenggunaEvent();

  @override
  List<Object> get props => [];
}

class FetchDataPengguna extends DataPenggunaEvent {
  final DataFilter filter;

  const FetchDataPengguna(this.filter);
}

/*
BLOC STATE
*/
abstract class DataPenggunaState extends Equatable {
  const DataPenggunaState();

  @override
  List<Object> get props => [];
}

class DataPenggunaInitial extends DataPenggunaState {}

class DataPenggunaLoading extends DataPenggunaState {}

class DataPenggunaLoadSuccess extends DataPenggunaState {
  final DataPenggunaApi data;
  const DataPenggunaLoadSuccess({required this.data});
}

class DataPenggunaNoInternet extends DataPenggunaState {}

class DataPenggunaLoadFailure extends DataPenggunaState {
  final String pesan;
  const DataPenggunaLoadFailure({required this.pesan});
}

