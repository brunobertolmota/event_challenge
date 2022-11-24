import 'dart:developer';

import 'package:event_challenge/features/events/controller/events_controller.dart';
import 'package:event_challenge/features/events/model/events_model.dart';
import 'package:event_challenge/features/events/widgets/event_card.dart';
import 'package:event_challenge/shared/core/dependencies.dart';
import 'package:flutter/material.dart';

class EventListPage extends StatelessWidget {
  EventListPage({Key? key}) : super(key: key);

  final EventsController controller = getIt<EventsController>();

  @override
  Widget build(BuildContext context) {
    void handleTap(EventModel model) {
      Navigator.of(context).pushNamed(
        '/eventDetail',
        arguments: model,
      );
    }

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<EventModel>>(
            future: controller.getDataController(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                log(snapshot.hasError.toString());
                log(ConnectionState.values.toString());
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.eventList.length,
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () => handleTap(controller.eventList[index]),
                    child: Card(
                      elevation: 10,
                      child: EventCard(
                        model: controller.eventList[index],
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    ));
  }
}
