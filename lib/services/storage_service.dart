import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class StorageService {
  static const _seedAssets = {
    'registration.json': 'assets/seed_users.json',
  };

  static Future<File> _localFile(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$filename');
  }

  static Future<List<dynamic>> readJsonList(String filename) async {
    try {
      final file = await _localFile(filename);
      if (!await file.exists()) {
        await _seedIfAvailable(filename, file);
      }
      if (!await file.exists()) return [];
      final contents = await file.readAsString();
      if (contents.isEmpty) return [];
      return json.decode(contents) as List<dynamic>;
    } catch (_) {
      return [];
    }
  }

  static Future<void> _seedIfAvailable(String filename, File file) async {
    final assetPath = _seedAssets[filename];
    if (assetPath == null) return;
    try {
      final data = await rootBundle.loadString(assetPath);
      await file.create(recursive: true);
      await file.writeAsString(data);
    } catch (_) {}
  }

  static Future<void> writeJsonList(String filename, List<dynamic> data) async {
    final file = await _localFile(filename);
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    await file.writeAsString(json.encode(data));
  }
}
