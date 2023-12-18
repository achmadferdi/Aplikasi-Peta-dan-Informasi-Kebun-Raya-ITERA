import 'package:json_annotation/json_annotation.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi_apidata.dart';

part 'data_notifikasi_api.g.dart';

@JsonSerializable()
class DataNotifikasiApi {

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final List<DataNotifikasiApiData> result;

  DataNotifikasiApi(this.status, this.result);


  factory DataNotifikasiApi.fromJson(Map<String, dynamic> json) =>
      _$DataNotifikasiApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataNotifikasiApiToJson(this);
}
