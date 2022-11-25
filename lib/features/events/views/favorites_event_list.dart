import 'package:event_challenge/features/events/controller/events_controller.dart';
import 'package:event_challenge/features/events/model/events_model.dart';
import 'package:event_challenge/features/events/widgets/event_card.dart';
import 'package:event_challenge/shared/core/dependencies.dart';
import 'package:event_challenge/shared/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoriteEventsListPage extends StatelessWidget {
  FavoriteEventsListPage({Key? key}) : super(key: key);

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
          future: controller.loadDataFromCache(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (controller.storageFavoriteList.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.storageFavoriteList.length,
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () => handleTap(controller.eventList[index]),
                    child: Card(
                      elevation: 10,
                      child: EventCardWidget(
                        model: controller.storageFavoriteList[index],
                        textLines: 3,
                      ),
                    ),
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
          const Text('Não há nenhum evento salvo')
        ],
      ),
    );
  }
}
