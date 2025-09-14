import '../models/user_profile.dart';

class MockData {
  static final List<WorkoutDay> workouts = [
    WorkoutDay(
      day: "Monday",
      focus: "Upper Body Strength",
      duration: "60 min",
      exercises: [
        Exercise(
          name: "Push-ups",
          sets: 3,
          reps: "12-15",
          restTime: "90s",
        ),
        Exercise(
          name: "Dumbbell Rows",
          sets: 3,
          reps: "10-12",
          weight: "15-20kg",
          restTime: "90s",
        ),
        Exercise(
          name: "Shoulder Press",
          sets: 3,
          reps: "8-10",
          weight: "12-15kg",
          restTime: "90s",
        ),
        Exercise(
          name: "Bicep Curls",
          sets: 3,
          reps: "12-15",
          weight: "8-12kg",
          restTime: "60s",
        ),
      ],
    ),
    WorkoutDay(
      day: "Tuesday",
      focus: "Lower Body Power",
      duration: "55 min",
      exercises: [
        Exercise(
          name: "Squats",
          sets: 4,
          reps: "10-12",
          weight: "Body weight",
          restTime: "2 min",
        ),
        Exercise(
          name: "Lunges",
          sets: 3,
          reps: "12 each leg",
          restTime: "90s",
        ),
        Exercise(
          name: "Deadlifts",
          sets: 3,
          reps: "8-10",
          weight: "20-25kg",
          restTime: "2 min",
        ),
        Exercise(
          name: "Calf Raises",
          sets: 3,
          reps: "15-20",
          restTime: "60s",
        ),
      ],
    ),
    WorkoutDay(
      day: "Wednesday",
      focus: "Cardio & Core",
      duration: "45 min",
      exercises: [
        Exercise(
          name: "Running",
          sets: 1,
          reps: "20 min",
          restTime: "N/A",
        ),
        Exercise(
          name: "Plank",
          sets: 3,
          reps: "45-60s",
          restTime: "90s",
        ),
        Exercise(
          name: "Mountain Climbers",
          sets: 3,
          reps: "30s",
          restTime: "60s",
        ),
        Exercise(
          name: "Russian Twists",
          sets: 3,
          reps: "20 each side",
          restTime: "60s",
        ),
      ],
    ),
    WorkoutDay(
      day: "Friday",
      focus: "Full Body Circuit",
      duration: "50 min",
      exercises: [
        Exercise(
          name: "Burpees",
          sets: 3,
          reps: "8-10",
          restTime: "90s",
        ),
        Exercise(
          name: "Kettlebell Swings",
          sets: 3,
          reps: "15-20",
          weight: "12-16kg",
          restTime: "90s",
        ),
        Exercise(
          name: "Pull-ups",
          sets: 3,
          reps: "5-8",
          restTime: "2 min",
        ),
        Exercise(
          name: "Jump Squats",
          sets: 3,
          reps: "12-15",
          restTime: "90s",
        ),
      ],
    ),
  ];

  static final List<Meal> meals = [
    Meal(
      name: "Breakfast",
      time: "7:00 AM",
      calories: 450,
      protein: 25,
      carbs: 45,
      fats: 18,
      foods: ["Oatmeal with berries", "Greek yogurt", "Almonds", "Banana"],
    ),
    Meal(
      name: "Mid-Morning Snack",
      time: "10:00 AM",
      calories: 200,
      protein: 15,
      carbs: 20,
      fats: 8,
      foods: ["Protein shake", "Apple"],
    ),
    Meal(
      name: "Lunch",
      time: "1:00 PM",
      calories: 550,
      protein: 35,
      carbs: 50,
      fats: 20,
      foods: ["Grilled chicken breast", "Brown rice", "Mixed vegetables", "Olive oil"],
    ),
    Meal(
      name: "Afternoon Snack",
      time: "4:00 PM",
      calories: 180,
      protein: 12,
      carbs: 15,
      fats: 8,
      foods: ["Cottage cheese", "Cucumber", "Whole grain crackers"],
    ),
    Meal(
      name: "Dinner",
      time: "7:00 PM",
      calories: 520,
      protein: 30,
      carbs: 40,
      fats: 22,
      foods: ["Salmon fillet", "Sweet potato", "Asparagus", "Avocado"],
    ),
    Meal(
      name: "Evening Snack",
      time: "9:30 PM",
      calories: 150,
      protein: 20,
      carbs: 8,
      fats: 6,
      foods: ["Casein protein", "Mixed nuts"],
    ),
  ];

  static final DailyTargets dailyTargets = DailyTargets(
    calories: 2050,
    protein: 137,
    carbs: 178,
    fats: 82,
  );
}