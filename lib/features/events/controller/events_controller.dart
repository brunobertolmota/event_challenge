import 'dart:convert';
import 'dart:developer';
import 'package:event_challenge/features/events/model/events_model.dart';
import 'package:event_challenge/features/service/events_service.dart';
import 'package:event_challenge/shared/core/client/cache_client.dart';
import 'package:event_challenge/shared/error/errors.dart';
import 'package:flutter/material.dart';


class EventsController extends ChangeNotifier {
  final LocalStorage localStorageService;
  final GetDataRepoService remoteService;

  EventsController({
    required this.localStorageService,
    required this.remoteService,
  });

  final String keyLocalStorage = 'events';

  List<EventModel> eventList = [];

  List<EventModel> offlineList = [];

  List<EventModel> favoriteList = [];

  savePersonInFavorite(EventModel person) {
    if (!favoriteList.contains(person)) {
      favoriteList.add(person);
    }
    notifyListeners();
  }

  removePersonInFavorite(EventModel person) {
    favoriteList.remove(person);
    notifyListeners();
  }

  Future<List<EventModel>> getDataController() async {
    try {
      eventList = await remoteService.getData();
      return eventList;
    } on ForbiddenException {
      //msg de erro
    } on NotFoundException {
      //msg de erro
    } on InternalServerException {
      //msg de erro
    } on UnknownEception {
      //msg de erro
    }
    return [];
  }


  Future<void> saveDataInCache() async {
    final cacheList = eventList.map((e) => jsonEncode(e.toJson())).toList();
    await localStorageService.writeData(
      key: keyLocalStorage,
      list: cacheList,
    );
  }

  Future<List<EventModel>> loadDataFromCache() async {
    final cacheList = await localStorageService.readData(key: keyLocalStorage);
    if (cacheList != null) {
      offlineList =
          List<Map<String, dynamic>>.from(cacheList.map((e) => jsonDecode(e)))
              .map(EventModel.fromJson)
              .toList();
      notifyListeners();
      // fazendo o sort por idade
      // offlineList.sort(((a, b) => a.age!.compareTo(b.age!)));
    }
    return [];
  }

  textFilterName(String value) {
    List<EventModel> listFiltered = offlineList
        .where((e) => e.eventName.toString().contains(value))
        .toList();
    inspect(listFiltered);
  }

  textFilterAge(String value) {
    List<EventModel> listFiltered = offlineList
        .where((e) => e.eventName.toString().contains(value))
        .toList();
    inspect(listFiltered);
  }

  // filtrando por nome e idade
  textFilterNameAndAge(String name, String age) {
    List<EventModel> listFiltered = offlineList
        .where((e) => e.eventName.toString() == age && e.eventName == name)
        .toList();
    inspect(listFiltered);
  }
}
