import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data/data_hapus.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi_api.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi_result_api.dart';
import 'package:ridikc_crud/data_lokasi/repo/data_lokasi_api_service.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi.dart';

class DataLokasiRemote {
  final DataLokasiApiService _serviceApi = DataLokasiApiService();


  Future<DataLokasiApi> getData(DataFilter filter) {
    return _serviceApi.getData(filter);
  }

  Future<DataLokasiResultApi> simpan(DataLokasi data) {
    return _serviceApi.prosesSimpan(data);
  }

  Future<DataLokasiResultApi> hapus(DataHapus data) {
    return _serviceApi.prosesHapus(data);
  }

  Future<DataLokasiResultApi> ubah(DataLokasi data) {
    return _serviceApi.prosesUbah(data);
  }
}

