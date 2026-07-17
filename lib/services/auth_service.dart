import 'package:flutter_ces/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _usersFile = 'registration.json';
  static const String _currentUserKey = 'current_user_email';

  static Future<bool> isEmailRegistered(String email) async {
    final users = await StorageService.readJsonList(_usersFile);
    return users.any((u) => u['email'] == email);
  }

  static Future<void> register(String email, String password) async {
    final users = await StorageService.readJsonList(_usersFile);
    users.add({'email': email, 'password': password});
    await StorageService.writeJsonList(_usersFile, users);
  }

  static Future<bool> login(String email, String password) async {
    final users = await StorageService.readJsonList(_usersFile);
    final match = users.any(
      (u) => u['email'] == email && u['password'] == password,
    );
    if (match) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_currentUserKey, email);
    }
    return match;
  }

  static Future<String?> getCurrentUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentUserKey);
  }

  static Future<Map<String, dynamic>?> getUserProfile(String email) async {
    final users = await StorageService.readJsonList(_usersFile);
    final user = users.firstWhere(
      (u) => u['email'] == email,
      orElse: () => null,
    );
    return user?['perfil'] as Map<String, dynamic>?;
  }

  static Future<void> saveUserProfile(
    String email,
    Map<String, dynamic> profile,
  ) async {
    final users = await StorageService.readJsonList(_usersFile);
    final index = users.indexWhere((u) => u['email'] == email);
    if (index != -1) {
      users[index]['perfil'] = profile;
      await StorageService.writeJsonList(_usersFile, users);
    }
  }
}
