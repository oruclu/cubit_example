import 'package:dio/dio.dart';

const _baseUrl = 'https://jsonplaceholder.typicode.com';

final refDio = Dio()
  ..options = BaseOptions(
    baseUrl: _baseUrl,
    contentType: 'application/json',
  )
  ..interceptors.add(DioInterceptor());

class DioInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {}
    handler.next(err);
  }
}
