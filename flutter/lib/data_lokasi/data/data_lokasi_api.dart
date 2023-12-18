import 'package:json_annotation/json_annotation.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi_apidata.dart';

part 'data_lokasi_api.g.dart';

@JsonSerializable()
class DataLokasiApi {

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final List<DataLokasiApiData> result;

  DataLokasiApi(this.status, this.result);


  factory DataLokasiApi.fromJson(Map<String, dynamic> json) =>
      _$DataLokasiApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataLokasiApiToJson(this);
}
