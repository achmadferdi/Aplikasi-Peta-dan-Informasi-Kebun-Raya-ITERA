import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/data/data_hapus.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi_api.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi_result_api.dart';
import 'package:ridikc_crud/data_lokasi/repo/data_lokasi_remote.dart';
// import 'package:ridikc_crud/data_lokasi/repo/DataLokasiHapus_local.dart';
import 'package:ridikc_crud/utils/network_info.dart';

class DataLokasiHapusBloc extends Bloc<DataLokasiHapusEvent, DataLokasiHapusState> {
  DataLokasiRemote remoteRepo = DataLokasiRemote();
  // DataLokasiHapusLocal localRepo = DataLokasiHapusLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataLokasiHapusBloc() : super(DataLokasiHapusInitial()) {
    on<FetchDataLokasiHapus>(((event, emit) async {
      emit(DataLokasiHapusLoading());
      emit(DataLokasiHapusLoading());
/*
      if (!await networkInfo.isConnected) {
        emit(DataLokasiHapusNoInternet());
        return;
      }
*/
      try {
        final DataLokasiResultApi response =
            await remoteRepo.hapus(event.data);
        emit(DataLokasiHapusLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataLokasiHapusLoadFailure(pesan: "Gagal dihapus, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataLokasiHapusEvent extends Equatable {
  const DataLokasiHapusEvent();

  @override
  List<Object> get props => [];
}

class FetchDataLokasiHapus extends DataLokasiHapusEvent {
  final DataHapus data;

  const FetchDataLokasiHapus({required this.data});
}

/*
BLOC STATE
*/
abstract class DataLokasiHapusState extends Equatable {
  const DataLokasiHapusState();

  @override
  List<Object> get props => [];
}

class DataLokasiHapusInitial extends DataLokasiHapusState {}

class DataLokasiHapusLoading extends DataLokasiHapusState {}

class DataLokasiHapusLoadSuccess extends DataLokasiHapusState {
}

class DataLokasiHapusNoInternet extends DataLokasiHapusState {}

class DataLokasiHapusLoadFailure extends DataLokasiHapusState {
  final String pesan;
  const DataLokasiHapusLoadFailure({required this.pesan});
}

