import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_profile.dart';

class ApiService {
  static const String baseUrl = 'YOUR_PYTHON_API_URL'; // Replace with your actual API URL
  
  // Singleton pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  /// Generate personalized fitness plan
  Future<Map<String, dynamic>> generateFitnessPlan(UserProfile userProfile) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/generate-plan'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userProfile.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to generate fitness plan: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  /// Generate personalized nutrition plan
  Future<Map<String, dynamic>> generateNutritionPlan(UserProfile userProfile) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/generate-nutrition'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userProfile.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to generate nutrition plan: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  /// Save user progress
  Future<bool> saveProgress(Map<String, dynamic> progressData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/save-progress'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(progressData),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error saving progress: $e');
      return false;
    }
  }

  /// Get user progress history
  Future<List<Map<String, dynamic>>> getProgressHistory(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/progress/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to get progress history: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  /// Generate custom meal suggestions
  Future<List<Map<String, dynamic>>> generateMealSuggestions(
    List<String> ingredients,
    Map<String, dynamic> nutritionTargets,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/generate-meals'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'ingredients': ingredients,
          'nutrition_targets': nutritionTargets,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to generate meal suggestions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  /// Calculate BMR and daily calorie needs
  Future<Map<String, dynamic>> calculateCalorieNeeds(UserProfile userProfile) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/calculate-calories'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userProfile.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to calculate calorie needs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}