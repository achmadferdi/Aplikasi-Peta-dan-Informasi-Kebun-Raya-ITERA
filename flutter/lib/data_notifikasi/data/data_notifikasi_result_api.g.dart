// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_notifikasi_result_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataNotifikasiResultApi _$DataNotifikasiResultApiFromJson(
        Map<String, dynamic> json) =>
    DataNotifikasiResultApi(
      json['status'] as String,
      DataNotifikasiApiData.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataNotifikasiResultApiToJson(
        DataNotifikasiResultApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
