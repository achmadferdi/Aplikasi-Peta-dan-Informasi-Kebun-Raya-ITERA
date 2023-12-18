import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi_api.dart';
import 'package:ridikc_crud/data_lokasi/repo/data_lokasi_remote.dart';
// import 'package:ridikc_crud/data_lokasi/repo/DataLokasi_local.dart';
import 'package:ridikc_crud/utils/network_info.dart';

class DataLokasiBloc extends Bloc<DataLokasiEvent, DataLokasiState> {
  DataLokasiRemote remoteRepo = DataLokasiRemote();
  // DataLokasiLocal localRepo = DataLokasiLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataLokasiBloc() : super(DataLokasiInitial()) {
    on<FetchDataLokasi>(((event, emit) async {
      emit(DataLokasiLoading());
      if (!await networkInfo.isConnected) {
        emit(DataLokasiNoInternet());
        return;
      }
      try {
        final DataLokasiApi response = await remoteRepo.getData(event.filter);
        emit(DataLokasiLoadSuccess(data: response));
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataLokasiLoadFailure(pesan: "Tidak dapat mengambil data, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataLokasiEvent extends Equatable {
  const DataLokasiEvent();

  @override
  List<Object> get props => [];
}

class FetchDataLokasi extends DataLokasiEvent {
  final DataFilter filter;

  const FetchDataLokasi(this.filter);
}

/*
BLOC STATE
*/
abstract class DataLokasiState extends Equatable {
  const DataLokasiState();

  @override
  List<Object> get props => [];
}

class DataLokasiInitial extends DataLokasiState {}

class DataLokasiLoading extends DataLokasiState {}

class DataLokasiLoadSuccess extends DataLokasiState {
  final DataLokasiApi data;
  const DataLokasiLoadSuccess({required this.data});
}

class DataLokasiNoInternet extends DataLokasiState {}

class DataLokasiLoadFailure extends DataLokasiState {
  final String pesan;
  const DataLokasiLoadFailure({required this.pesan});
}

