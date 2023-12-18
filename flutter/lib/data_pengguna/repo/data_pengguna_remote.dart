import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data/data_hapus.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna_api.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna_result_api.dart';
import 'package:ridikc_crud/data_pengguna/repo/data_pengguna_api_service.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna.dart';

class DataPenggunaRemote {
  final DataPenggunaApiService _serviceApi = DataPenggunaApiService();

  Future<DataPenggunaApi> getData(DataFilter filter) {
    return _serviceApi.getData(filter);
  }

  Future<DataPenggunaApi> detail(DataFilter filter) {
    return _serviceApi.detail(filter);
  }

  Future<DataPenggunaResultApi> simpan(DataPengguna data) {
    return _serviceApi.prosesSimpan(data);
  }

  Future<DataPenggunaResultApi> hapus(DataHapus data) {
    return _serviceApi.prosesHapus(data);
  }

  Future<DataPenggunaResultApi> ubah(DataPengguna data) {
    return _serviceApi.prosesUbah(data);
  }
}
