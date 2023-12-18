import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data_katalog/data/data_katalog_api.dart';
import 'package:ridikc_crud/data_katalog/repo/data_katalog_api_service.dart';

class DataKatalogRemote {
  final DataKatalogApiService _serviceApi = DataKatalogApiService();


  Future<DataKatalogApi> getData(DataFilter filter) {
    return _serviceApi.getData(filter);
  }
}
