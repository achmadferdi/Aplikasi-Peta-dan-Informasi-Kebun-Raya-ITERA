import 'package:json_annotation/json_annotation.dart';
import 'package:ridikc_crud/data/data_hapus.dart';

part 'data_pengguna_apidata.g.dart';

@JsonSerializable()
class DataPenggunaApiData implements DataHapus {
    DataPenggunaApiData({
                              	this.idPengguna,
	this.nama,
	this.alamat,
	this.jenisKelamin,
	this.noTelepon,
	this.username,
	this.password,

                          });

    	@JsonKey(name: "id_pengguna")
    final String? idPengguna;
	@JsonKey(name: "nama")
    final String? nama;
	@JsonKey(name: "alamat")
    final String? alamat;
	@JsonKey(name: "jenis_kelamin")
    final String? jenisKelamin;
	@JsonKey(name: "no_telepon")
    final String? noTelepon;
	@JsonKey(name: "username")
    final String? username;
	@JsonKey(name: "password")
    final String? password;


  factory DataPenggunaApiData.fromJson(Map<String, dynamic> json) =>
      _$DataPenggunaApiDataFromJson(json);

  Map<String, dynamic> toJson() => _$DataPenggunaApiDataToJson(this);

  @override
  String getIdHapus() {
    return "$idPengguna";
  }
}

