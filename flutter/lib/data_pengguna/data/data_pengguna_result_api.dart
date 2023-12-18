import 'package:json_annotation/json_annotation.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna_apidata.dart';

part 'data_pengguna_result_api.g.dart';

@JsonSerializable()
class DataPenggunaResultApi {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final DataPenggunaApiData result;

  DataPenggunaResultApi(this.status, this.result);

  factory DataPenggunaResultApi.fromJson(Map<String, dynamic> json) =>
      _$DataPenggunaResultApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataPenggunaResultApiToJson(this);
}

