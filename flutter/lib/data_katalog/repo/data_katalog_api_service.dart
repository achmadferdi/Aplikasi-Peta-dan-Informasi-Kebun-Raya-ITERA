import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ridikc_crud/config/config_global.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data_katalog/data/data_katalog_api.dart';
import 'package:ridikc_crud/utils/awesome_dio_interceptor.dart';

class DataKatalogApiService {
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

  Future<DataKatalogApi> getData(DataFilter filter) async {
    try {
      Response response = await dio.post("app/page/data_lokasi/tampil.php",
          data: FormData.fromMap({
            'berdasarkan': filter.berdasarkan,
            'isi': filter.isi,
            'limit': filter.limit,
            'hal': filter.hal,
            'dari': filter.dari,
            'sampai': filter.sampai
          }));
      if (response.data is String) {
        return DataKatalogApi.fromJson(jsonDecode(response.data));
      }
      return DataKatalogApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
