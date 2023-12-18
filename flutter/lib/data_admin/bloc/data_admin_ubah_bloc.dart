import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data_admin/data/data_admin_api.dart';
import 'package:ridikc_crud/data_admin/data/data_admin.dart';
import 'package:ridikc_crud/data_admin/repo/data_admin_remote.dart';
// import 'package:ridikc_crud/data_admin/repo/DataAdminUbah_local.dart';
import 'package:ridikc_crud/utils/network_info.dart';

class DataAdminUbahBloc extends Bloc<DataAdminUbahEvent, DataAdminUbahState> {
  DataAdminRemote remoteRepo = DataAdminRemote();
  // DataAdminUbahLocal localRepo = DataAdminUbahLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataAdminUbahBloc() : super(DataAdminUbahInitial()) {
    on<FetchDataAdminUbah>(((event, emit) async {
      emit(DataAdminUbahLoading());
      if (!await networkInfo.isConnected) {
        emit(DataAdminUbahNoInternet());
        return;
      }
      try {
        await remoteRepo.ubah(event.filter);
        emit(
          DataAdminUbahLoadSuccess(
            data: DataAdminApi("berhasil", []),
          ),
        );
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataAdminUbahLoadFailure(pesan: "Gagal mengubah, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataAdminUbahEvent extends Equatable {
  const DataAdminUbahEvent();

  @override
  List<Object> get props => [];
}

class FetchDataAdminUbah extends DataAdminUbahEvent {
  final DataAdmin filter;

  const FetchDataAdminUbah(this.filter);
}

/*
BLOC STATE
*/
abstract class DataAdminUbahState extends Equatable {
  const DataAdminUbahState();

  @override
  List<Object> get props => [];
}

class DataAdminUbahInitial extends DataAdminUbahState {}

class DataAdminUbahLoading extends DataAdminUbahState {}

class DataAdminUbahLoadSuccess extends DataAdminUbahState {
  final DataAdminApi data;
  const DataAdminUbahLoadSuccess({required this.data});
}

class DataAdminUbahNoInternet extends DataAdminUbahState {}

class DataAdminUbahLoadFailure extends DataAdminUbahState {
  final String pesan;
  const DataAdminUbahLoadFailure({required this.pesan});
}

