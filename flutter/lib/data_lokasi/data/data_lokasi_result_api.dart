import 'package:json_annotation/json_annotation.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi_apidata.dart';

part 'data_lokasi_result_api.g.dart';

@JsonSerializable()
class DataLokasiResultApi {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final DataLokasiApiData result;

  DataLokasiResultApi(this.status, this.result);

  factory DataLokasiResultApi.fromJson(Map<String, dynamic> json) =>
      _$DataLokasiResultApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataLokasiResultApiToJson(this);
}

