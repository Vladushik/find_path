import 'dart:developer';

import 'package:dio/dio.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final base = response.requestOptions;
    final headers =
        base.headers.entries.map((e) => '${e.key} ${e.value}').join('\n');
    log('RESPONSE[${response.statusCode}] ${base.method} ${base.uri}\n$headers');
    handler.next(response);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
