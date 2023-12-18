// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_result_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResultApi _$LoginResultApiFromJson(Map<String, dynamic> json) =>
    LoginResultApi(
      json['status'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => DataPenggunaApiData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LoginResultApiToJson(LoginResultApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
