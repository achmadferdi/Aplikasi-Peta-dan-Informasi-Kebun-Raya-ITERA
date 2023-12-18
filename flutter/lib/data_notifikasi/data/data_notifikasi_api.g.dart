// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_notifikasi_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataNotifikasiApi _$DataNotifikasiApiFromJson(Map<String, dynamic> json) =>
    DataNotifikasiApi(
      json['status'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => DataNotifikasiApiData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataNotifikasiApiToJson(DataNotifikasiApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
