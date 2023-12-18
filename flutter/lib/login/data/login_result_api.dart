import 'package:json_annotation/json_annotation.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna_api.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna_apidata.dart';

part 'login_result_api.g.dart';

@JsonSerializable()
class LoginResultApi extends DataPenggunaApi {
  LoginResultApi(super.status, super.result);

  factory LoginResultApi.fromJson(Map<String, dynamic> json) =>
      _$LoginResultApiFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginResultApiToJson(this);
}
