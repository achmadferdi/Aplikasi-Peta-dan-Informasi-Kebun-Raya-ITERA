// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_pengguna_apidata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataPenggunaApiData _$DataPenggunaApiDataFromJson(Map<String, dynamic> json) =>
    DataPenggunaApiData(
      idPengguna: json['id_pengguna'] as String?,
      nama: json['nama'] as String?,
      alamat: json['alamat'] as String?,
      jenisKelamin: json['jenis_kelamin'] as String?,
      noTelepon: json['no_telepon'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$DataPenggunaApiDataToJson(
        DataPenggunaApiData instance) =>
    <String, dynamic>{
      'id_pengguna': instance.idPengguna,
      'nama': instance.nama,
      'alamat': instance.alamat,
      'jenis_kelamin': instance.jenisKelamin,
      'no_telepon': instance.noTelepon,
      'username': instance.username,
      'password': instance.password,
    };
