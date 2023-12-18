import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/data/data_hapus.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna_api.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna_result_api.dart';
import 'package:ridikc_crud/data_pengguna/repo/data_pengguna_remote.dart';
// import 'package:ridikc_crud/data_pengguna/repo/DataPenggunaHapus_local.dart';
import 'package:ridikc_crud/utils/network_info.dart';

class DataPenggunaHapusBloc extends Bloc<DataPenggunaHapusEvent, DataPenggunaHapusState> {
  DataPenggunaRemote remoteRepo = DataPenggunaRemote();
  // DataPenggunaHapusLocal localRepo = DataPenggunaHapusLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataPenggunaHapusBloc() : super(DataPenggunaHapusInitial()) {
    on<FetchDataPenggunaHapus>(((event, emit) async {
      emit(DataPenggunaHapusLoading());
      emit(DataPenggunaHapusLoading());
/*
      if (!await networkInfo.isConnected) {
        emit(DataPenggunaHapusNoInternet());
        return;
      }
*/
      try {
        final DataPenggunaResultApi response =
            await remoteRepo.hapus(event.data);
        emit(DataPenggunaHapusLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataPenggunaHapusLoadFailure(pesan: "Gagal dihapus, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataPenggunaHapusEvent extends Equatable {
  const DataPenggunaHapusEvent();

  @override
  List<Object> get props => [];
}

class FetchDataPenggunaHapus extends DataPenggunaHapusEvent {
  final DataHapus data;

  const FetchDataPenggunaHapus({required this.data});
}

/*
BLOC STATE
*/
abstract class DataPenggunaHapusState extends Equatable {
  const DataPenggunaHapusState();

  @override
  List<Object> get props => [];
}

class DataPenggunaHapusInitial extends DataPenggunaHapusState {}

class DataPenggunaHapusLoading extends DataPenggunaHapusState {}

class DataPenggunaHapusLoadSuccess extends DataPenggunaHapusState {
}

class DataPenggunaHapusNoInternet extends DataPenggunaHapusState {}

class DataPenggunaHapusLoadFailure extends DataPenggunaHapusState {
  final String pesan;
  const DataPenggunaHapusLoadFailure({required this.pesan});
}

