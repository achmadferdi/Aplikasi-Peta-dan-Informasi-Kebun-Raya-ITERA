// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_notifikasi_apidata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataNotifikasiApiData _$DataNotifikasiApiDataFromJson(
        Map<String, dynamic> json) =>
    DataNotifikasiApiData(
      idNotifikasi: json['id_notifikasi'] as String?,
      notifikasi: json['notifikasi'] as String?,
      nama: json['nama'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$DataNotifikasiApiDataToJson(
        DataNotifikasiApiData instance) =>
    <String, dynamic>{
      'id_notifikasi': instance.idNotifikasi,
      'notifikasi': instance.notifikasi,
      'nama': instance.nama,
      'status': instance.status,
    };
