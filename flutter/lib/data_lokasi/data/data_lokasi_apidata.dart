import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ridikc_crud/data/data_hapus.dart';

part 'data_lokasi_apidata.g.dart';

@JsonSerializable()
class DataLokasiApiData implements DataHapus {
  DataLokasiApiData({
    this.idLokasi,
    this.nama,
    this.foto1,
    this.foto2,
    this.deskripsi,
    this.lat,
    this.lng,
  });

  @JsonKey(name: "id_lokasi")
  final String? idLokasi;

  @JsonKey(name: "nama")
  final String? nama;

  @JsonKey(name: "foto1")
  final String? foto1;

  @JsonKey(name: "foto2")
  final String? foto2;

  @JsonKey(name: "deskripsi")
  final String? deskripsi;

  @JsonKey(name: "lat")
  final String? lat;

  @JsonKey(name: "lng")
  final String? lng;

  factory DataLokasiApiData.fromJson(Map<String, dynamic> json) =>
      _$DataLokasiApiDataFromJson(json);

  Map<String, dynamic> toJson() => _$DataLokasiApiDataToJson(this);

  @override
  String getIdHapus() {
    return "$idLokasi";
  }

  LatLng? getLatLng() {
    debugPrint("KOORDINAT :: $lat , $lng");
    double? _lat = double.tryParse("$lat");
    double? _lng = double.tryParse("$lng");
    if (_lat != null && _lng != null) {
      return LatLng(_lat, _lng);
    }
    return null;
  }
}
