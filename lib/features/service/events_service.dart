import 'package:event_challenge/features/events/model/events_model.dart';
import 'package:event_challenge/features/service/events_api_interface.dart';
import 'package:event_challenge/shared/config/app_configs.dart';
import 'package:event_challenge/shared/core/client/client.dart';
import 'package:event_challenge/shared/error/errors.dart';

class GetDataRepoService implements GetEventsInterface {
  final ApiClient client;

  GetDataRepoService({
    required this.client,
  });

  @override
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
}
