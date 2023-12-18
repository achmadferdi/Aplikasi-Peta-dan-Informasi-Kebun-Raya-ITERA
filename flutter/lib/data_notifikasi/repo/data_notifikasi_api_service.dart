import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ridikc_crud/config/config_global.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data/data_hapus.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi_api.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi_apidata.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi_result_api.dart';
import 'package:ridikc_crud/utils/awesome_dio_interceptor.dart';

class DataNotifikasiApiService {
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

  Future<DataNotifikasiApi> getData(DataFilter filter) async {
    try {
      Response response = await dio.post(
        "app/page/data_notifikasi/tampil.php",
        data: FormData.fromMap({
          'id_pengguna': filter.idPeserta,
          'berdasarkan': filter.berdasarkan,
          'isi': filter.isi,
          'limit': filter.limit,
          'hal': filter.hal,
          'dari': filter.dari,
          'sampai': filter.sampai
        }),
      );
      if (response.data is String) {
        return DataNotifikasiApi.fromJson(jsonDecode(response.data));
      }
      return DataNotifikasiApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataNotifikasiResultApi> prosesSimpan(DataNotifikasi data) async {
    try {
      Response response = await dio.post(
        "app/page/data_notifikasi/proses_simpan.php",
        data: FormData.fromMap({
          'id_notifikasi': data.idNotifikasi,
          'notifikasi': data.notifikasi,
          'nama': data.nama,
          'status': data.status,
        }),
      );
      /* if (response.data is String) {
          return DataNotifikasiResultApi.fromJson(jsonDecode(response.data));
      }
      return DataNotifikasiResultApi.fromJson(response.data); */
      return DataNotifikasiResultApi("success", DataNotifikasiApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataNotifikasiResultApi> prosesUbah(DataNotifikasi data) async {
    try {
      Response response = await dio.post(
        "app/page/data_notifikasi/proses_update.php",
        data: FormData.fromMap({
          'id_notifikasi': data.idNotifikasi,
          'notifikasi': data.notifikasi,
          'nama': data.nama,
          'status': data.status,
        }),
      );
      /* if (response.data is String) {
        return DataNotifikasiResultApi.fromJson(jsonDecode(response.data));
      }
      return DataNotifikasiResultApi.fromJson(response.data); */
      return DataNotifikasiResultApi(
        "berhasil",
        DataNotifikasiApiData(),
      );
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataNotifikasiResultApi> prosesHapus(DataHapus data) async {
    try {
      Response response = await dio.post(
        "app/page/data_notifikasi/proses_hapus.php",
        data: FormData.fromMap({
          'proses': data.getIdHapus(),
        }),
      );
      /* if (response.data is String) {
        return DataNotifikasiResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataNotifikasiResultApi.fromJson(response.data); */
      return DataNotifikasiResultApi(
        "berhasil",
        DataNotifikasiApiData(),
      ); */
      return DataNotifikasiResultApi("success", DataNotifikasiApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
