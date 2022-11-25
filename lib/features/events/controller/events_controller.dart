import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:event_challenge/features/events/model/events_model.dart';
import 'package:event_challenge/features/service/events_service.dart';
import 'package:event_challenge/shared/core/client/cache_client.dart';
import 'package:event_challenge/shared/error/errors.dart';
import 'package:flutter/material.dart';

class EventsController extends ChangeNotifier {
  final LocalStorage localStorageService;
  final GetDataRepoService remoteService;
  final Connectivity connectivity;
  EventsController(
      {required this.localStorageService,
      required this.remoteService,
      required this.connectivity});

  final String keyLocalStorage = 'favoriteEvents';

  bool hasError = false;

  List<EventModel> eventList = [];

  List<EventModel> storageFavoriteList = [];

  savePersonInFavorite(EventModel event) {
    if (!storageFavoriteList.contains(event)) {
      storageFavoriteList.add(event);
    }
    saveDataInCache();
    notifyListeners();
  }

  removePersonInFavorite(EventModel event) {
    if (storageFavoriteList.any((element) => element == event)) {
      storageFavoriteList.remove(event);
    }
    saveDataInCache();
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
    await localStorageService.writeData(
      key: keyLocalStorage,
      data: storageFavoriteList.map((e) => jsonEncode(e.toJson())).toList(),
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
