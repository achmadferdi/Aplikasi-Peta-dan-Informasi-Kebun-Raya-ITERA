import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna_api.dart';
import 'package:ridikc_crud/data_pengguna/repo/data_pengguna_remote.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna.dart';
// import 'package:ridikc_crud/data_pengguna/repo/DataPenggunaSimpan_local.dart';
import 'package:ridikc_crud/utils/network_info.dart';

class DataPenggunaSimpanBloc extends Bloc<DataPenggunaSimpanEvent, DataPenggunaSimpanState> {
  DataPenggunaRemote remoteRepo = DataPenggunaRemote();
  // DataPenggunaSimpanLocal localRepo = DataPenggunaSimpanLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataPenggunaSimpanBloc() : super(DataPenggunaSimpanInitial()) {
    on<FetchDataPenggunaSimpan>(((event, emit) async {
      emit(DataPenggunaSimpanLoading());
      /* if (!await networkInfo.isConnected) {
        emit(DataPenggunaSimpanNoInternet());
        return;
      } */
      try {
        await remoteRepo.simpan(event.data);
        emit(DataPenggunaSimpanLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(
          const DataPenggunaSimpanLoadFailure(pesan: "Gagal menyimpan, Pastikan hp terhubung ke internet"),
        );
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataPenggunaSimpanEvent extends Equatable {
  const DataPenggunaSimpanEvent();

  @override
  List<Object> get props => [];
}

class FetchDataPenggunaSimpan extends DataPenggunaSimpanEvent {
  final DataPengguna data;

  const FetchDataPenggunaSimpan(this.data);
}

/*
BLOC STATE
*/
abstract class DataPenggunaSimpanState extends Equatable {
  const DataPenggunaSimpanState();

  @override
  List<Object> get props => [];
}

class DataPenggunaSimpanInitial extends DataPenggunaSimpanState {}

class DataPenggunaSimpanLoading extends DataPenggunaSimpanState {}

class DataPenggunaSimpanLoadSuccess extends DataPenggunaSimpanState {
}

class DataPenggunaSimpanNoInternet extends DataPenggunaSimpanState {}

class DataPenggunaSimpanLoadFailure extends DataPenggunaSimpanState {
  final String pesan;
  const DataPenggunaSimpanLoadFailure({required this.pesan});
}

