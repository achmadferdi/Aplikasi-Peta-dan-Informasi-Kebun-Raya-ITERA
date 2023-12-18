// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_pengguna_result_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataPenggunaResultApi _$DataPenggunaResultApiFromJson(
        Map<String, dynamic> json) =>
    DataPenggunaResultApi(
      json['status'] as String,
      DataPenggunaApiData.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataPenggunaResultApiToJson(
        DataPenggunaResultApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
