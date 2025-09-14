import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';

class StorageHelper {
  static const String _userProfileKey = 'user_profile';
  static const String _progressDataKey = 'progress_data';
  static const String _settingsKey = 'app_settings';

  // Singleton pattern
  static final StorageHelper _instance = StorageHelper._internal();
  factory StorageHelper() => _instance;
  StorageHelper._internal();

  /// Save user profile
  Future<bool> saveUserProfile(UserProfile profile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final profileJson = jsonEncode(profile.toJson());
      return await prefs.setString(_userProfileKey, profileJson);
    } catch (e) {
      print('Error saving user profile: $e');
      return false;
    }
  }

  /// Get user profile
  Future<UserProfile?> getUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final profileJson = prefs.getString(_userProfileKey);
      
      if (profileJson != null) {
        final profileData = jsonDecode(profileJson);
        return UserProfile(
          age: profileData['age'],
          weight: profileData['weight'].toDouble(),
          height: profileData['height'].toDouble(),
          gender: profileData['gender'],
          activityLevel: profileData['activityLevel'],
          fitnessGoal: profileData['fitnessGoal'],
          experience: profileData['experience'],
          workoutsPerWeek: profileData['workoutsPerWeek'],
        );
      }
      return null;
    } catch (e) {
      print('Error getting user profile: $e');
      return null;
    }
  }

  /// Save progress data
  Future<bool> saveProgressData(Map<String, dynamic> progressData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final existingData = await getProgressData();
      existingData.add(progressData);
      
      final progressJson = jsonEncode(existingData);
      return await prefs.setString(_progressDataKey, progressJson);
    } catch (e) {
      print('Error saving progress data: $e');
      return false;
    }
  }

  /// Get progress data
  Future<List<Map<String, dynamic>>> getProgressData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final progressJson = prefs.getString(_progressDataKey);
      
      if (progressJson != null) {
        final List<dynamic> data = jsonDecode(progressJson);
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      print('Error getting progress data: $e');
      return [];
    }
  }

  /// Save app settings
  Future<bool> saveSettings(Map<String, dynamic> settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final settingsJson = jsonEncode(settings);
      return await prefs.setString(_settingsKey, settingsJson);
    } catch (e) {
      print('Error saving settings: $e');
      return false;
    }
  }

  /// Get app settings
  Future<Map<String, dynamic>> getSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final settingsJson = prefs.getString(_settingsKey);
      
      if (settingsJson != null) {
        return jsonDecode(settingsJson);
      }
      return {
        'notifications_enabled': true,
        'dark_mode_enabled': false,
        'selected_language': 'English',
        'selected_units': 'Metric',
      };
    } catch (e) {
      print('Error getting settings: $e');
      return {};
    }
  }

  /// Clear all data
  Future<bool> clearAllData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.clear();
    } catch (e) {
      print('Error clearing data: $e');
      return false;
    }
  }

  /// Check if user profile exists
  Future<bool> hasUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userProfileKey);
  }
}