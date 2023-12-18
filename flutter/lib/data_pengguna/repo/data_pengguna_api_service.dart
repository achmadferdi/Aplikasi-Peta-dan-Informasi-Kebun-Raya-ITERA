import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ridikc_crud/config/config_global.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data/data_hapus.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna_api.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna_apidata.dart';
import 'package:ridikc_crud/data_pengguna/data/data_pengguna_result_api.dart';
import 'package:ridikc_crud/utils/awesome_dio_interceptor.dart';

class DataPenggunaApiService {
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

  Future<DataPenggunaApi> getData(DataFilter filter) async {
    try {
      Response response = await dio.post(
        "app/page/data_pengguna/tampil.php",
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
        return DataPenggunaApi.fromJson(jsonDecode(response.data));
      }
      return DataPenggunaApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataPenggunaApi> detail(DataFilter filter) async {
    try {
      Response response = await dio.post(
        "app/page/data_pengguna/detail.php",
        data: FormData.fromMap({
          'berdasarkan': filter.berdasarkan,
          'isi': filter.isi,
          'limit': filter.limit,
          'hal': filter.hal,
          'dari': filter.dari,
          'sampai': filter.sampai,
          'id_pengguna': filter.idPeserta
        }),
      );
      if (response.data is String) {
        return DataPenggunaApi.fromJson(jsonDecode(response.data));
      }
      return DataPenggunaApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataPenggunaResultApi> prosesSimpan(DataPengguna data) async {
    try {
      Response response = await dio.post(
        "app/page/data_pengguna/proses_simpan.php",
        data: FormData.fromMap({
          'id_pengguna': data.idPengguna,
          'nama': data.nama,
          'alamat': data.alamat,
          'jenis_kelamin': data.jenisKelamin,
          'no_telepon': data.noTelepon,
          'username': data.username,
          'password': data.password,
        }),
      );
      /* if (response.data is String) {
          return DataPenggunaResultApi.fromJson(jsonDecode(response.data));
      }
      return DataPenggunaResultApi.fromJson(response.data); */
      return DataPenggunaResultApi("success", DataPenggunaApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataPenggunaResultApi> prosesUbah(DataPengguna data) async {
    try {
      Response response = await dio.post(
        "app/page/data_pengguna/proses_update.php",
        data: FormData.fromMap({
          'id_pengguna': data.idPengguna,
          'nama': data.nama,
          'alamat': data.alamat,
          'jenis_kelamin': data.jenisKelamin,
          'no_telepon': data.noTelepon,
          'username': data.username,
          'password': data.password,
        }),
      );
      /* if (response.data is String) {
        return DataPenggunaResultApi.fromJson(jsonDecode(response.data));
      }
      return DataPenggunaResultApi.fromJson(response.data); */
      return DataPenggunaResultApi(
        "berhasil",
        DataPenggunaApiData(),
      );
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataPenggunaResultApi> prosesHapus(DataHapus data) async {
    try {
      Response response = await dio.post(
        "app/page/data_pengguna/proses_hapus.php",
        data: FormData.fromMap({
          'proses': data.getIdHapus(),
        }),
      );
      /* if (response.data is String) {
        return DataPenggunaResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataPenggunaResultApi.fromJson(response.data); */
      return DataPenggunaResultApi(
        "berhasil",
        DataPenggunaApiData(),
      ); */
      return DataPenggunaResultApi("success", DataPenggunaApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
