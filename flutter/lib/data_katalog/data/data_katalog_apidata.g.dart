// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_katalog_apidata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataKatalogApiData _$DataKatalogApiDataFromJson(Map<String, dynamic> json) =>
    DataKatalogApiData(
      nama: json['nama'] as String?,
      harga: json['harga'] as String?,
      kategori: json['kategori'] as String?,
      terjual: json['terjual'] as String?,
      deskripsi: json['deskripsi'] as String?,
      foto: json['foto'] as String?,
    );

Map<String, dynamic> _$DataKatalogApiDataToJson(DataKatalogApiData instance) =>
    <String, dynamic>{
      'foto': instance.foto,
      'harga': instance.harga,
      'nama': instance.nama,
      'kategori': instance.kategori,
      'terjual': instance.terjual,
      'deskripsi': instance.deskripsi,
    };
