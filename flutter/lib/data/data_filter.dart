class DataFilter {
  final String berdasarkan;
  final String isi;
  final String limit;
  final String hal;
  final String dari;
  final String sampai;
  final String auth;
  final String idPeserta;

  const DataFilter({
    this.berdasarkan = "",
    this.isi = "",
    this.limit = "",
    this.hal = "",
    this.dari = "",
    this.sampai = "",
    this.auth = "",
    this.idPeserta = "",
  });

  DataFilter copyWith({
    String? berdasarkan,
    String? isi,
    String? limit,
    String? hal,
    String? dari,
    String? sampai,
    String? auth,
    String? idPeserta,
  }) {
    return DataFilter(
      berdasarkan: berdasarkan ?? this.berdasarkan,
      isi: isi ?? this.isi,
      limit: limit ?? this.limit,
      hal: hal ?? this.hal,
      dari: dari ?? this.dari,
      sampai: sampai ?? this.sampai,
      auth: auth ?? this.auth,
      idPeserta: idPeserta ?? this.idPeserta,
    );
  }
}

class DataPencarian extends DataFilter {
  String berdasarkan;
  String isi;
  String limit;
  String hal;
  String dari;
  String sampai;
  String auth;
  String idPeserta;

  DataPencarian(
      {this.berdasarkan = "",
      this.isi = "",
      this.limit = "",
      this.hal = "",
      this.dari = "",
      this.sampai = "",
      this.auth = "",
      this.idPeserta = ""});
}
