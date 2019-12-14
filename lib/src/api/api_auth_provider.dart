import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sample_oauth/src/model/diagnostic/diagnostic.dart';
import 'package:flutter_sample_oauth/src/model/login/login_body.dart';
import 'package:flutter_sample_oauth/src/model/refreshtoken/refresh_token_body.dart';
import 'package:flutter_sample_oauth/src/model/register/register.dart';
import 'package:flutter_sample_oauth/src/model/token/token.dart';
import 'package:flutter_sample_oauth/src/model/user/user.dart';
import 'package:flutter_sample_oauth/src/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:flutter_sample_oauth/src/utils/dio_logging_interceptors.dart';

class ApiAuthProvider {
  SharedPreferencesManager _sharedPreferencesManager;
  final Dio _dio = new Dio();
  final String _baseUrl = 'http://bengkelrobot.net:8002/';
  final String clientId = 'bengkel-robot-client';
  final String clientSecret = 'bengkel-robot-secret';

  ApiAuthProvider() {
    _initSharedPreferencesManager();
  }

  Future _initSharedPreferencesManager() async {
    if (_sharedPreferencesManager == null) {
      _sharedPreferencesManager = await SharedPreferencesManager.getInstance();
    }
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future<Diagnostic> registerUser(Register register) async {
    try {
      final response = await _dio.post(
        'register/user',
        data: register.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return Diagnostic.fromJson(response.data);
    } catch (error, stacktrace) {
      _printError(error, stacktrace);
      return Diagnostic.withError('$error');
    }
  }

  Future<Token> loginUser(LoginBody loginBody) async {
    try {
      final response = await _dio.post(
        'oauth/token',
        data: FormData.fromMap(loginBody.toJson()),
        options: Options(
          headers: {
            'Authorization': 'Basic ${base64Encode(
              utf8.encode('$clientId:$clientSecret'),
            )}',
          },
        ),
      );
      return Token.fromJson(response.data);
    } catch (error, stacktrace) {
      _printError(error, stacktrace);
      return Token.withError('$error');
    }
  }

  Future<Token> refreshAuth(RefreshTokenBody refreshTokenBody) async {
    try {
      final response = await _dio.post(
        'oauth/token',
        data: FormData.fromMap(refreshTokenBody.toJson()),
        options: Options(
          headers: {
            'Authorization': 'Basic ${base64Encode(
              utf8.encode('$clientId:$clientSecret'),
            )}',
          },
        ),
      );
      return Token.fromJson(response.data);
    } catch (error, stacktrace) {
      _printError(error, stacktrace);
      return Token.withError('$error');
    }
  }

  Future<User> getAllUsers() async {
    try {
      print('getAllUsers');
      final response = await _dio.get(
        'users/user',
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return User.fromJson(response.data);
    } catch (error, stacktrace) {
      _printError(error, stacktrace);
      return User.withError('$error');
    }
  }

  void _printError(error, StackTrace stacktrace) {
    debugPrint('error: $error & stacktrace: $stacktrace');
  }
}
