
import 'package:event_challenge/features/events/model/events_model.dart';
import 'package:event_challenge/shared/config/app_configs.dart';
import 'package:event_challenge/shared/core/client/client.dart';
import 'package:event_challenge/shared/error/errors.dart';

class GetDataRepoService {
  final ApiClient client;

  GetDataRepoService({required this.client});

  Future<List<EventModel>> getData() async {
    final response = await client.get(path: AppConfigurations.url);
    switch (response.statusCode) {
      case 200:
        return List.from(response.data)
            .map((e) => EventModel.fromJson(e))
            .toList();
      case 403:
        throw ForbiddenException();
      case 404:
        throw NotFoundException();
      case 500:
        throw InternalServerException();
      default:
        throw UnknownEception();
    }
  }

  Future<List<EventModel>> postData({body}) async {
    final response = await client.post(path: AppConfigurations.url, body: body);
    switch (response.statusCode) {
      case 403:
        throw ForbiddenException();
      case 404:
        throw NotFoundException();
      case 500:
        throw InternalServerException();
      default:
        throw UnknownEception();
    }
  }
}
