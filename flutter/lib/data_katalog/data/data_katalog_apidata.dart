import 'package:json_annotation/json_annotation.dart';

part 'data_katalog_apidata.g.dart';

@JsonSerializable()
class DataKatalogApiData {
  DataKatalogApiData({
    this.nama,
    this.harga,
    this.kategori,
    this.terjual,
    this.deskripsi,
    this.foto,
  });

  @JsonKey(name: 'foto')
  final String? foto;

  @JsonKey(name: 'harga')
  final String? harga;

  @JsonKey(name: 'nama')
  final String? nama;

  @JsonKey(name: 'kategori')
  final String? kategori;

  @JsonKey(name: 'terjual')
  final String? terjual;

  @JsonKey(name: 'deskripsi')
  final String? deskripsi;

  factory DataKatalogApiData.fromJson(Map<String, dynamic> json) =>
      _$DataKatalogApiDataFromJson(json);

  Map<String, dynamic> toJson() => _$DataKatalogApiDataToJson(this);
}
