import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/data/data_hapus.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi_api.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi_result_api.dart';
import 'package:ridikc_crud/data_notifikasi/repo/data_notifikasi_remote.dart';
// import 'package:ridikc_crud/data_notifikasi/repo/DataNotifikasiHapus_local.dart';
import 'package:ridikc_crud/utils/network_info.dart';

class DataNotifikasiHapusBloc extends Bloc<DataNotifikasiHapusEvent, DataNotifikasiHapusState> {
  DataNotifikasiRemote remoteRepo = DataNotifikasiRemote();
  // DataNotifikasiHapusLocal localRepo = DataNotifikasiHapusLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataNotifikasiHapusBloc() : super(DataNotifikasiHapusInitial()) {
    on<FetchDataNotifikasiHapus>(((event, emit) async {
      emit(DataNotifikasiHapusLoading());
      emit(DataNotifikasiHapusLoading());
/*
      if (!await networkInfo.isConnected) {
        emit(DataNotifikasiHapusNoInternet());
        return;
      }
*/
      try {
        final DataNotifikasiResultApi response =
            await remoteRepo.hapus(event.data);
        emit(DataNotifikasiHapusLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataNotifikasiHapusLoadFailure(pesan: "Gagal dihapus, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataNotifikasiHapusEvent extends Equatable {
  const DataNotifikasiHapusEvent();

  @override
  List<Object> get props => [];
}

class FetchDataNotifikasiHapus extends DataNotifikasiHapusEvent {
  final DataHapus data;

  const FetchDataNotifikasiHapus({required this.data});
}

/*
BLOC STATE
*/
abstract class DataNotifikasiHapusState extends Equatable {
  const DataNotifikasiHapusState();

  @override
  List<Object> get props => [];
}

class DataNotifikasiHapusInitial extends DataNotifikasiHapusState {}

class DataNotifikasiHapusLoading extends DataNotifikasiHapusState {}

class DataNotifikasiHapusLoadSuccess extends DataNotifikasiHapusState {
}

class DataNotifikasiHapusNoInternet extends DataNotifikasiHapusState {}

class DataNotifikasiHapusLoadFailure extends DataNotifikasiHapusState {
  final String pesan;
  const DataNotifikasiHapusLoadFailure({required this.pesan});
}

