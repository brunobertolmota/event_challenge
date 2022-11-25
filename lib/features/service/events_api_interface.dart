import 'package:event_challenge/features/events/model/events_model.dart';

abstract class GetEventsInterface {
  Future<List<EventModel>> getData();
}
