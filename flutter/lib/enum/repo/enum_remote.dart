import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/enum/data/enum_api.dart';
import 'package:ridikc_crud/enum/repo/enum_api_service.dart';

class EnumRemote {
  final EnumApiService _serviceApi = EnumApiService();

  Future<EnumApi> getData(String tabel, String field) {
    return _serviceApi.getData(tabel, field);
  }
}
