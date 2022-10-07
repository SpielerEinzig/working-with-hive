import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  final storage = Hive.box("storage");

  writeData({required String value}) {
    storage.put("data", value);
  }

  readData() {
    String? data = storage.get("data");
    return data;
  }

  deleteData() async {
    await storage.delete("data");
  }
}
