import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data/data_hapus.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi_api.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi_result_api.dart';
import 'package:ridikc_crud/data_notifikasi/repo/data_notifikasi_api_service.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi.dart';

class DataNotifikasiRemote {
  final DataNotifikasiApiService _serviceApi = DataNotifikasiApiService();


  Future<DataNotifikasiApi> getData(DataFilter filter) {
    return _serviceApi.getData(filter);
  }

  Future<DataNotifikasiResultApi> simpan(DataNotifikasi data) {
    return _serviceApi.prosesSimpan(data);
  }

  Future<DataNotifikasiResultApi> hapus(DataHapus data) {
    return _serviceApi.prosesHapus(data);
  }

  Future<DataNotifikasiResultApi> ubah(DataNotifikasi data) {
    return _serviceApi.prosesUbah(data);
  }
}

