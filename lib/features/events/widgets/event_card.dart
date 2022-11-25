import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:event_challenge/features/connectivity/controller/connectivity_controller.dart';
import 'package:event_challenge/features/events/model/events_model.dart';
import 'package:event_challenge/shared/core/dependencies.dart';
import 'package:event_challenge/shared/utils/app_assets.dart';
import 'package:event_challenge/shared/utils/widgets/text_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class EventCardWidget extends StatelessWidget {
  final EventModel model;
  final int textLines;
  EventCardWidget({
    Key? key,
    required this.model,
    required this.textLines,
  }) : super(key: key);
  final ConnectivityController connectivityController =
      getIt<ConnectivityController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          connectivityController.connectionStatus != ConnectivityResult.none
              ? Container(
                  constraints: const BoxConstraints(
                    minHeight: 130,
                    minWidth: 200,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(model.thumbnail),
                        fit: BoxFit.cover),
                  ),
                )
              : Container(
                  constraints: const BoxConstraints(
                    minHeight: 130,
                    minWidth: 200,
                  ),
                  child: SvgPicture.asset(
                    AppImages.balloonsLogo,
                    alignment: Alignment.center,
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 8),
            child: darkTitle(text: model.eventName, fontSize: 20),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 350, minWidth: 280),
              child: Text(model.eventDescription, maxLines: textLines),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              constraints: const BoxConstraints(
                  minWidth: 250, maxWidth: double.infinity),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  darkTitle(
                      text:
                          'Data: ${DateFormat('dd/MM/yy').format(DateTime.parse(model.endTime))}',
                      fontSize: 16),
                  darkTitle(
                    text:
                        'Horário: ${DateFormat('kk:mm').format(DateTime.parse(model.startTime))}'
                        ' - ${DateFormat('kk:mm').format(DateTime.parse(model.endTime))}',
                    fontSize: 16,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                constraints: const BoxConstraints(minWidth: 250, maxWidth: 270),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: darkTitle(
                        text: 'Local',
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${model.address.street}, ${model.address.number},'
                      '${model.address.neighborhood},\n${model.address.city}',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
