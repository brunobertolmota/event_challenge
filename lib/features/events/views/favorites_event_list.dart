import 'dart:developer';
import 'package:event_challenge/features/events/controller/events_controller.dart';
import 'package:event_challenge/features/events/model/events_model.dart';
import 'package:event_challenge/features/events/views/events_list.dart';
import 'package:event_challenge/shared/core/dependencies.dart';
import 'package:flutter/material.dart';

class FavoriteEventsListPage extends StatelessWidget {
  FavoriteEventsListPage({Key? key}) : super(key: key);

  final EventsController controller = getIt<EventsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<EventModel>>(
            future: controller.getDataController(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'API request',
                      ),
                      ElevatedButton(
                          onPressed: () {
                            log('lista');
                            inspect(controller.eventList);
                          },
                          child: const Text('lista')),
                      ElevatedButton(
                          onPressed: () {
                            log('salvando dados no cache...');
                            controller.saveDataInCache();
                          },
                          child: const Text('salvar no cache')),
                      ElevatedButton(
                          onPressed: () {
                            inspect(controller.offlineList);
                          },
                          child: const Text('inspecionar dados do cache')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EventListPage()));
                          },
                          child: const Text('TELA LISTA')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/homePage');
                            inspect(controller.favoriteList);
                          },
                          child: const Text('veririficar favoritos')),
                    ],
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
