
import 'package:event_challenge/shared/core/client/dio/response.dart';

abstract class ApiClient {
  Future<Response> get({required String path});
}
