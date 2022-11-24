
import 'dart:developer';

import 'package:event_challenge/features/auth/controller/login_controller.dart';
import 'package:event_challenge/features/events/controller/events_controller.dart';
import 'package:event_challenge/features/events/model/events_model.dart';
import 'package:event_challenge/features/events/widgets/event_card.dart';
import 'package:event_challenge/shared/core/dependencies.dart';
import 'package:event_challenge/shared/utils/widgets/buttons_components.dart';
import 'package:flutter/material.dart';

class EventDetail extends StatelessWidget {
  EventDetail({super.key});
  final EventsController controller = getIt<EventsController>();
  final LoginController loginController = getIt<LoginController>();

  @override
  Widget build(BuildContext context) {
    EventModel model = ModalRoute.of(context)!.settings.arguments as EventModel;
    return Scaffold(
      appBar: AppBar(title: Text(model.eventName)),
      body: Column(
        children: [
          Text(loginController.user.email),
          EventCard(
            model: model,
          ),
          const SizedBox(height: 50),
          SizedBox(
            width: 300,
            child: PurpleButton(
              label: 'Adicionar aos favoritos',
              onPressed: () async {
                log(loginController.email.toString());
                // controller.savePersonInFavorite(model);
              },
            ),
          )
        ],
      ),
    );
  }
}
