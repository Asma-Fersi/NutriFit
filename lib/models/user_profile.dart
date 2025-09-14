class UserProfile {
  final int age;
  final double weight;
  final double height;
  final String gender;
  final String activityLevel;
  final String fitnessGoal;
  final String experience;
  final int workoutsPerWeek;

  UserProfile({
    required this.age,
    required this.weight,
    required this.height,
    required this.gender,
    required this.activityLevel,
    required this.fitnessGoal,
    required this.experience,
    required this.workoutsPerWeek,
  });

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'weight': weight,
      'height': height,
      'gender': gender,
      'activityLevel': activityLevel,
      'fitnessGoal': fitnessGoal,
      'experience': experience,
      'workoutsPerWeek': workoutsPerWeek,
    };
  }
}

class Exercise {
  final String name;
  final int sets;
  final String reps;
  final String? weight;
  final String restTime;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    this.weight,
    required this.restTime,
  });
}

class WorkoutDay {
  final String day;
  final String focus;
  final String duration;
  final List<Exercise> exercises;

  WorkoutDay({
    required this.day,
    required this.focus,
    required this.duration,
    required this.exercises,
  });
}

class Meal {
  final String name;
  final String time;
  final int calories;
  final int protein;
  final int carbs;
  final int fats;
  final List<String> foods;

  Meal({
    required this.name,
    required this.time,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.foods,
  });
}

class DailyTargets {
  final int calories;
  final int protein;
  final int carbs;
  final int fats;

  DailyTargets({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
  });
}