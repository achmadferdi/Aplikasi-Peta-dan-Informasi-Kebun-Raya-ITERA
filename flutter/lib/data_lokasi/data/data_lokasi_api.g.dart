// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_lokasi_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataLokasiApi _$DataLokasiApiFromJson(Map<String, dynamic> json) =>
    DataLokasiApi(
      json['status'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => DataLokasiApiData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataLokasiApiToJson(DataLokasiApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
