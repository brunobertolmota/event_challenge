import 'package:dio/dio.dart' as dio;
import 'package:event_challenge/shared/core/client/client.dart';
import 'package:event_challenge/shared/core/client/dio/response.dart';
import 'package:event_challenge/shared/error/errors.dart';

class DioClientImpl extends ApiClient {
  final dio.Dio client;

  DioClientImpl({
    required this.client,
  });

  @override
  Future<Response> get({required String path}) async {
    try {
      final response = await client.get(path);
      return Response.fromDioResponse(response);
    } on dio.DioError catch (e) {
      if (e.type == dio.DioErrorType.connectTimeout ||
          e.type == dio.DioErrorType.receiveTimeout) {
        throw NoInternetConnection();
      } else if (e.type == dio.DioErrorType.other) {
        throw NoInternetConnection();
      } else {
        throw UnknownEception();
      }
    }
  }
}
