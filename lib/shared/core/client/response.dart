import 'package:dio/dio.dart' as dio;

class Response {
  final int? statusCode;
  final dynamic data;

  const Response({required this.statusCode, required this.data});

  factory Response.fromDioResponse(dio.Response response) {
    return Response(data: response.data, statusCode: response.statusCode);
  }
}
