import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ridikc_crud/login/data/data_login.dart';
import 'package:ridikc_crud/login/data/data_register.dart';
import 'package:ridikc_crud/login/data/login_api.dart';
import 'package:ridikc_crud/login/data/login_result_api.dart';
import 'package:ridikc_crud/login/data/register_api.dart';
import 'package:ridikc_crud/utils/awesome_dio_interceptor.dart';
import 'package:ridikc_crud/config/config_global.dart';

class LoginApiService {
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

  Future<LoginApi> login(DataLogin data) async {
    try {
      Response response = await dio.post(
        "login/login.php",
        data: FormData.fromMap({
          'username': data.username,
          'password': data.password,
          'login_sebagai': data.login_sebagai
        }),
      );
      if (response.data is String) {
        return LoginApi.fromJson(jsonDecode(response.data));
      }
      return LoginApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<RegisterApi> register(DataRegister data) async {
    try {
      Response response = await dio.post(
        "app/page/data_peserta/proses_register.php",
        data: FormData.fromMap({
          // 'username': data.username,
          // 'password': data.password,
        }),
      );
      if (response.data is String) {
        return RegisterApi.fromJson(jsonDecode(response.data));
      }
      return RegisterApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<LoginResultApi> proseRegister(DataRegister data) async {
    try {
      Response response = await dio.post(
        "app/page/data_peserta/proses_simpan.php",
        data: FormData.fromMap({
          // 'username': data.username,
          // 'password': data.password,
        }),
      );
      if (response.data is String) {
        return LoginResultApi.fromJson(jsonDecode(response.data));
      }
      return LoginResultApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
