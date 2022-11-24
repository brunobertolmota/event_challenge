import 'dart:developer';

import 'package:event_challenge/features/events/controller/events_controller.dart';
import 'package:event_challenge/features/events/model/events_model.dart';
import 'package:event_challenge/features/events/widgets/event_card.dart';
import 'package:event_challenge/shared/core/dependencies.dart';
import 'package:event_challenge/shared/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              if (controller.eventList.isNotEmpty) {
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
              } else if (controller.hasError) {
                return _iconHasError();
              } else {
                return _iconEmptylist();
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    ));
  }

  // _iconHasError
  Widget _iconEmptylist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: const BoxConstraints(
              minHeight: 200,
              minWidth: 200,
            ),
            child: SvgPicture.asset(
              AppImages.iconNoEvent,
              alignment: Alignment.center,
            ),
          ),
          const Text('No momento não há eventos')
        ],
      ),
    );
  }

  Widget _iconHasError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: const BoxConstraints(
              minHeight: 200,
              minWidth: 200,
            ),
            child: SvgPicture.asset(
              AppImages.iconError,
              alignment: Alignment.center,
            ),
          ),
          const Text('Ocorreu um erro ao carregar os eventos')
        ],
      ),
    );
  }
}
