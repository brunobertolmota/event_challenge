import 'dart:developer';

import 'package:event_challenge/features/events/controller/events_controller.dart';
import 'package:event_challenge/features/events/model/events_model.dart';
import 'package:event_challenge/features/events/widgets/event_card.dart';
import 'package:event_challenge/shared/core/dependencies.dart';
import 'package:event_challenge/shared/utils/app_assets.dart';
import 'package:event_challenge/shared/utils/widgets/buttons_components.dart';
import 'package:event_challenge/shared/utils/widgets/text_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({Key? key}) : super(key: key);

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  final EventsController controller = getIt<EventsController>();
  @override
  void initState() {
    controller.loadDataFromCache();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void handleTap(EventModel model) {
      Navigator.of(context).pushNamed(
        '/eventDetail',
        arguments: model,
      );
    }

    void refresh() {
      setState(() {});
    }

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
                      child: Column(
                        children: [
                          EventCardWidget(
                            model: controller.eventList[index],
                            textLines: 3,
                          ),
                          _saveAndRemoveTextButton(index),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (controller.hasError) {
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      _iconHasError(),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: refresh,
                        child: const Text('Recarregar página'),
                      ),
                    ],
                  ),
                );
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

  Widget _saveAndRemoveTextButton(index) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => !controller.storageFavoriteList
              .any((model) => model == controller.eventList[index])
          ? TextButton(
              onPressed: () {
                controller.savePersonInFavorite(
                  controller.eventList[index],
                );
              },
              child:
                  purpleText(text: 'Adicionar aos Meus Eventos', fontSize: 18))
          : TextButton(
              onPressed: () {
                inspect(controller.eventList[index]);
                controller.removePersonInFavorite(
                  controller.eventList[index],
                );
              },
              child: purpleText(
                text: 'Remover dos Meus Eventos',
                fontSize: 18,
              ),
            ),
    );
  }

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
