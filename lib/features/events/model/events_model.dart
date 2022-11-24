import 'package:event_challenge/features/events/model/address_model.dart';

class EventModel {
  final int id;
  final String eventName;
  final String eventDescription;
  final String startTime;
  final String endTime;
  final String thumbnail;
  final String eventUrl;
  final AddressModel address;

  EventModel({
    required this.id,
    required this.eventName,
    required this.eventDescription,
    required this.startTime,
    required this.endTime,
    required this.thumbnail,
    required this.eventUrl,
    required this.address,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json['id'],
        eventName: json['event_name'],
        eventDescription: json['event_description'],
        startTime: json['start_time'],
        endTime: json['end_time'],
        thumbnail: json['thumbnail'],
        eventUrl: json['eventURL'],
        address: AddressModel.fromJson(json['address']),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> event = {};
    event["id"] = id;
    event["event_name"] = eventName;
    event["event_description"] = eventDescription;
    event["start_time"] = startTime;
    event["end_time"] = endTime;
    event["thumbnail"] = thumbnail;
    event["eventURL"] = eventUrl;
    event["address"] = address.toJson();

    return event;
  }
}

