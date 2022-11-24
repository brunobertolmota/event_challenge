import 'dart:convert';
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

  bool hasError = false;

  List<EventModel> eventList = [];

  List<EventModel> storageFavoriteList = [];

  savePersonInFavorite(EventModel person) {
    if (!storageFavoriteList.contains(person)) {
      storageFavoriteList.add(person);
    }
    notifyListeners();
  }

  removePersonInFavorite(EventModel person) {
    storageFavoriteList.remove(person);
    notifyListeners();
  }

  Future<List<EventModel>> getDataController() async {
    try {
      eventList = await remoteService.getData();
      return eventList;
    } on ForbiddenException {
      hasError = true;
    } on NotFoundException {
      hasError = true;
    } on InternalServerException {
      hasError = true;
    } on UnknownEception {
      hasError = true;
    } on NoInternetConnection {
      hasError = true;
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
      storageFavoriteList =
          List<Map<String, dynamic>>.from(cacheList.map((e) => jsonDecode(e)))
              .map(EventModel.fromJson)
              .toList();
      notifyListeners();
    }
    return [];
  }
}
