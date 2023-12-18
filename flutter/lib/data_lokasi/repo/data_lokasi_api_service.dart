import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ridikc_crud/config/config_global.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data/data_hapus.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi_api.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi_apidata.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi_result_api.dart';
import 'package:ridikc_crud/utils/awesome_dio_interceptor.dart';

class DataLokasiApiService {
  Dio get dio => _dio();
  Dio _dio() {
    final options = BaseOptions(
      baseUrl: '${ConfigGlobal.baseUrl}/api/',
      connectTimeout: 5000,
      receiveTimeout: 3000,
      contentType: "application/json;charset=utf-8",
    );

    var dio = Dio(options);

    dio.interceptors.add(AwesomeDioInterceptor(
      logRequestTimeout: false,
      logRequestHeaders: false,
      logResponseHeaders: false,

      // Optional, defaults to the 'log' function in the 'dart:developer' package.
      logger: debugPrint,
    ));

    return dio;
  }

  Future<DataLokasiApi> getData(DataFilter filter) async {
    try {
      Response response = await dio.post(
        "app/page/data_lokasi/tampil.php",
        data: FormData.fromMap({
          'berdasarkan': filter.berdasarkan,
          'isi': filter.isi,
          'limit': filter.limit,
          'hal': filter.hal,
          'dari': filter.dari,
          'sampai': filter.sampai
        }),
      );
      if (response.data is String) {
        return DataLokasiApi.fromJson(jsonDecode(response.data));
      }
      return DataLokasiApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataLokasiResultApi> prosesSimpan(DataLokasi data) async {
    try {
      Response response = await dio.post(
        "app/page/data_lokasi/proses_simpan.php",
        data: FormData.fromMap({
        'id_lokasi' : data.idLokasi,
'nama' : data.nama,
'foto1' : data.foto1,
'foto2' : data.foto2,
'deskripsi' : data.deskripsi,

        }),
      );
      /* if (response.data is String) {
          return DataLokasiResultApi.fromJson(jsonDecode(response.data));
      }
      return DataLokasiResultApi.fromJson(response.data); */
      return DataLokasiResultApi("success", DataLokasiApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataLokasiResultApi> prosesUbah(DataLokasi data) async {
    try {
      Response response = await dio.post(
        "app/page/data_lokasi/proses_update.php",
        data: FormData.fromMap({
        'id_lokasi' : data.idLokasi,
'nama' : data.nama,
'foto1' : data.foto1,
'foto2' : data.foto2,
'deskripsi' : data.deskripsi,

        }),
      );
      /* if (response.data is String) {
        return DataLokasiResultApi.fromJson(jsonDecode(response.data));
      }
      return DataLokasiResultApi.fromJson(response.data); */
      return DataLokasiResultApi(
        "berhasil",
        DataLokasiApiData(),
      );
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataLokasiResultApi> prosesHapus(DataHapus data) async {
    try {
      Response response = await dio.post(
        "app/page/data_lokasi/proses_hapus.php",
        data: FormData.fromMap({
          'proses': data.getIdHapus(),
        }),
      );
      /* if (response.data is String) {
        return DataLokasiResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataLokasiResultApi.fromJson(response.data); */
      return DataLokasiResultApi(
        "berhasil",
        DataLokasiApiData(),
      ); */
      return DataLokasiResultApi("success", DataLokasiApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}

