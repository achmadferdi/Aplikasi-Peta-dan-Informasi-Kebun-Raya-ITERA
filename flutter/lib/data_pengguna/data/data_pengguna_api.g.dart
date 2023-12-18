// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_pengguna_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataPenggunaApi _$DataPenggunaApiFromJson(Map<String, dynamic> json) =>
    DataPenggunaApi(
      json['status'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => DataPenggunaApiData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataPenggunaApiToJson(DataPenggunaApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
