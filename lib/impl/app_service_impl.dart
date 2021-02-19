import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sam_api_calls/contracts/contracts.dart';
import 'package:sam_api_calls/impl/api_endpoints.dart';
import 'package:sam_api_calls/models/models.dart';

class AppServiceImpl extends AppService {
  final Dio _dio;

  AppServiceImpl({@required Dio dio}) : this._dio = dio;

  @override
  Future<UserAccount> getUserAccountByEmail(String email) async {
    try {
      return await _dio.get(ApiEndpoints.USER, queryParameters: {
        "user_email": email,
        "profile": 2
      }).then((value) => UserAccount.fromJson(value.data["body"]));
    } on DioError catch (_) {
      throw "Failed to get user account by email";
    }
  }

  @override
  Future<UserProfile> postNewUser(UserAccount user) async {
    try {
      final String body = json.encode({
        "user_fname": "${user.userFname}",
        "user_lname": "${user.userLname}",
        "user_email": "${user.userEmail}",
        "user_pwd": "${user.userPassword}",
        "user_phone": ""
      });

      return await _dio
          .post(ApiEndpoints.USER, queryParameters: {"profile": 0}, data: body)
          .then((value) {
        return UserProfile.fromJson(value.data);
      });
    } on DioError catch (_) {
      throw getThrowsMessage("Failed to register new user", _.response.data);
    }
  }

  @override
  Future<bool> putRequestResetPassword(UserAccount account) async {
    try {
      return await _dio.put("${ApiEndpoints.USER}/${account.userId}",
          queryParameters: {"profile": 5}).then((value) => true);
    } on DioError catch (_) {
      throw "Failed to request password reset";
    }
  }

  @override
  Future<bool> putResetPassword(
      UserAccount account, String verificationCode) async {
    try {
      final String body = json.encode({
        "vcode": "$verificationCode",
        "user_newpwd": "${account.userPassword}"
      });

      return await _dio
          .put("${ApiEndpoints.USER}/${account.userId}",
              queryParameters: {"profile": 5}, data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw "Failed to reset password";
    }
  }

  @override
  Future<bool> putVerify(String userId, String verificationCode) async {
    try {
      final String body = json.encode({"vcode": "$verificationCode"});

      return await _dio
          .put("${ApiEndpoints.USER}/$userId",
              queryParameters: {"profile": 3}, data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw "Failed to verify user";
    }
  }

  @override
  String getThrowsMessage(
      String defaultError, Map<String, dynamic> responseData) {
    try {
      ApiError apiError = ApiError.fromJson(responseData);
      defaultError = apiError.desc;
    } catch (e) {}

    return defaultError;
  }
}
