import 'package:json_annotation/json_annotation.dart';
import 'package:ridikc_crud/data/data_hapus.dart';

part 'data_notifikasi_apidata.g.dart';

@JsonSerializable()
class DataNotifikasiApiData implements DataHapus {
    DataNotifikasiApiData({
                              	this.idNotifikasi,
	this.notifikasi,
	this.nama,
	this.status,

                          });

    	@JsonKey(name: "id_notifikasi")
    final String? idNotifikasi;
	@JsonKey(name: "notifikasi")
    final String? notifikasi;
	@JsonKey(name: "nama")
    final String? nama;
	@JsonKey(name: "status")
    final String? status;


  factory DataNotifikasiApiData.fromJson(Map<String, dynamic> json) =>
      _$DataNotifikasiApiDataFromJson(json);

  Map<String, dynamic> toJson() => _$DataNotifikasiApiDataToJson(this);

  @override
  String getIdHapus() {
    return "$idNotifikasi";
  }
}

