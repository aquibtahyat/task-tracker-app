import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const dioClient = 'DIOCLIENT';

Dio _createBaseDio() {
  final dio = Dio()
    ..options.baseUrl = 'https://api.todoist.com/api/v1'
    ..options.connectTimeout = const Duration(seconds: 10)
    ..options.receiveTimeout = const Duration(seconds: 20)
    ..options.headers = {
      'Authorization': 'Bearer faed1db3d763f0c31cb196b7289b78bf5f5d3a21',
    };

  return dio;
}

final logger = PrettyDioLogger(requestHeader: true, requestBody: true);

@module
abstract class NetworkModule {
  @singleton
  @Named(dioClient)
  Dio getDio() {
    final dio = _createBaseDio()..interceptors.addAll([logger]);
    return dio;
  }
}
