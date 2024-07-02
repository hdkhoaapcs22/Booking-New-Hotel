import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StorageData {
  static Future<String> get getFilePath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  static Future<File> get getFile async {
    final path = await getFilePath;
    return File('$path/lastSearch.txt');
  }

  static Future<String> readData() async {
    try {
      final file = await getFile;
      String fileContent = await file.readAsString();
      return fileContent;
    } catch (e) {
      return 'Error: $e';
    }
  }

  static void writeData(List<String> data) async {
    final file = await getFile;
    file.writeAsString(data.join(','));
  }
}
