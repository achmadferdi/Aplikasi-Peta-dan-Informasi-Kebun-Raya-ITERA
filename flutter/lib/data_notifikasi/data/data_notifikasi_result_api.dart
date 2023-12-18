import 'package:json_annotation/json_annotation.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi_apidata.dart';

part 'data_notifikasi_result_api.g.dart';

@JsonSerializable()
class DataNotifikasiResultApi {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final DataNotifikasiApiData result;

  DataNotifikasiResultApi(this.status, this.result);

  factory DataNotifikasiResultApi.fromJson(Map<String, dynamic> json) =>
      _$DataNotifikasiResultApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataNotifikasiResultApiToJson(this);
}

