import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:sam_api_calls/contracts/contracts.dart';
import 'package:sam_api_calls/models/dashboard/dashboard.dart';

class PublicServiceImpl extends PublicService {
  Dio _dio;

  PublicServiceImpl({List<Interceptor> interceptors}) {
    _dio = Dio();
    if (interceptors != null && interceptors.length > 0) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  // resources/json/sam_iot_widgets.json
  @override
  Future<List<IotWidget>> getWidgetsCollection({String path}) async {
    if (path != null) {
      try {
        return await rootBundle
            .loadString(path).then((value) {
          var list = json.decode(value) as List;
          return list.map((wgt) => IotWidget.fromJson(wgt)).toList();
        });
      } on DioError catch (_) {
        throw "Failed to get widgets collection";
      }
    }

    return [];
  }
}
