import 'package:flutter/material.dart';
import 'package:freechoice_music/repository/local/storage_keys.dart';
import 'package:get_storage/get_storage.dart';

class StorageHelper {
  StorageHelper._privateConstructor();

  static final StorageHelper _instance = StorageHelper._privateConstructor();

  static StorageHelper get instance => _instance;

  GetStorage? storage;

  getStorage({String? storageName}) {
    storage = GetStorage(storageName ?? SKeys.userSettings);
  }

  T? readValue<T>({required String key}) {
    try {
      if (storage == null) {
        getStorage();
      }
      var val = storage!.read<T>(key);
      return val;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  writeValue({required String key, required value}) {
    if (storage == null) {
      getStorage();
    }
    storage!.write(key, value);
  }

  deleteKey({required String key}) {
    if (storage == null) {
      getStorage();
    }
    storage!.remove(key);
  }
}
