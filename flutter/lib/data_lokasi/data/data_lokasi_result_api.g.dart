// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_lokasi_result_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataLokasiResultApi _$DataLokasiResultApiFromJson(Map<String, dynamic> json) =>
    DataLokasiResultApi(
      json['status'] as String,
      DataLokasiApiData.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataLokasiResultApiToJson(
        DataLokasiResultApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
