import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi_api.dart';
import 'package:ridikc_crud/data_notifikasi/repo/data_notifikasi_remote.dart';
// import 'package:ridikc_crud/data_notifikasi/repo/DataNotifikasi_local.dart';
import 'package:ridikc_crud/utils/network_info.dart';

class DataNotifikasiBloc
    extends Bloc<DataNotifikasiEvent, DataNotifikasiState> {
  DataNotifikasiRemote remoteRepo = DataNotifikasiRemote();
  // DataNotifikasiLocal localRepo = DataNotifikasiLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataNotifikasiBloc() : super(DataNotifikasiInitial()) {
    on<FetchDataNotifikasi>(
      ((event, emit) async {
        emit(DataNotifikasiLoading());
        if (!await networkInfo.isConnected) {
          emit(DataNotifikasiNoInternet());
          return;
        }
        try {
          final DataNotifikasiApi response =
              await remoteRepo.getData(event.filter);
          emit(
            DataNotifikasiLoadSuccess(data: response),
          );
        } catch (e) {
          debugPrint(e.toString());
          emit(
            const DataNotifikasiLoadFailure(
              pesan:
                  "Tidak dapat mengambil data, Pastikan hp terhubung ke internet",
            ),
          );
        }
      }),
    );
  }
}

/*
BLOC EVENT
*/
abstract class DataNotifikasiEvent extends Equatable {
  const DataNotifikasiEvent();

  @override
  List<Object> get props => [];
}

class FetchDataNotifikasi extends DataNotifikasiEvent {
  final DataFilter filter;

  const FetchDataNotifikasi(this.filter);
}

/*
BLOC STATE
*/
abstract class DataNotifikasiState extends Equatable {
  const DataNotifikasiState();

  @override
  List<Object> get props => [];
}

class DataNotifikasiInitial extends DataNotifikasiState {}

class DataNotifikasiLoading extends DataNotifikasiState {}

class DataNotifikasiLoadSuccess extends DataNotifikasiState {
  final DataNotifikasiApi data;
  const DataNotifikasiLoadSuccess({required this.data});
}

class DataNotifikasiNoInternet extends DataNotifikasiState {}

class DataNotifikasiLoadFailure extends DataNotifikasiState {
  final String pesan;
  const DataNotifikasiLoadFailure({required this.pesan});
}
