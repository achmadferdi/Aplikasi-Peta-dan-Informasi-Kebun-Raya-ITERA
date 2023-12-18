// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_lokasi_apidata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataLokasiApiData _$DataLokasiApiDataFromJson(Map<String, dynamic> json) =>
    DataLokasiApiData(
      idLokasi: json['id_lokasi'] as String?,
      nama: json['nama'] as String?,
      foto1: json['foto1'] as String?,
      foto2: json['foto2'] as String?,
      deskripsi: json['deskripsi'] as String?,
      lat: json['lat'] as String?,
      lng: json['lng'] as String?,
    );

Map<String, dynamic> _$DataLokasiApiDataToJson(DataLokasiApiData instance) =>
    <String, dynamic>{
      'id_lokasi': instance.idLokasi,
      'nama': instance.nama,
      'foto1': instance.foto1,
      'foto2': instance.foto2,
      'deskripsi': instance.deskripsi,
      'lat': instance.lat,
      'lng': instance.lng,
    };
