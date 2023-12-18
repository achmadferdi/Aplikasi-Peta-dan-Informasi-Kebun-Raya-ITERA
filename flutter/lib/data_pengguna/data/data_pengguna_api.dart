import 'package:json_annotation/json_annotation.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna_apidata.dart';

part 'data_pengguna_api.g.dart';

@JsonSerializable()
class DataPenggunaApi {

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final List<DataPenggunaApiData> result;

  DataPenggunaApi(this.status, this.result);


  factory DataPenggunaApi.fromJson(Map<String, dynamic> json) =>
      _$DataPenggunaApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataPenggunaApiToJson(this);
}
