
import 'package:event_challenge/shared/core/client/response.dart';

abstract class ApiClient {
  Future<Response> get({required String path});
  Future<Response> post({required String path, Map<String, dynamic>? body});
}
