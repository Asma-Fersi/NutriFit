# FitPlan AI - Flutter Fitness & Nutrition Planner

A comprehensive Flutter application for personalized fitness and nutrition planning powered by AI.

## Features

### 🏋️ Comprehensive Fitness Planning
- **User Profile Creation**: Detailed form capturing age, weight, height, gender, activity level, fitness goals, experience, and workout frequency
- **Personalized Training Plans**: Custom workout routines based on user profile
- **Interactive Workout Sessions**: Start workouts with exercise tracking and completion status
- **Built-in Rest Timer**: Customizable rest timers for each exercise with visual feedback

### 🍎 Smart Nutrition Planning
- **Personalized Meal Plans**: Custom nutrition plans with macro breakdowns
- **Daily Nutrition Tracking**: Track calories, protein, carbs, and fats
- **Interactive Meal Planner**: Create custom meals based on available ingredients
- **Meal Suggestions**: AI-powered meal recommendations

### 📊 Progress Tracking
- **Weekly Progress Visualization**: Track workout completion and calorie goals
- **Statistics Dashboard**: View total workouts, calories burned, active days, and personal bests
- **Recent Workout History**: Monitor workout completion status
- **Progress Analytics**: Visual progress indicators and charts

### ⚙️ Advanced Features
- **Settings & Preferences**: Customize notifications, theme, language, and units
- **Data Export**: Export fitness data for external analysis
- **Local Storage**: Offline data persistence using SharedPreferences
- **API Integration**: Ready for backend integration with your Python model

## Technical Architecture

### 📱 Flutter Framework
- **Material Design 3**: Modern UI with custom gradients and animations
- **Responsive Design**: Optimized for mobile, tablet, and web
- **State Management**: Efficient state handling with StatefulWidget
- **Navigation**: Smooth page transitions and modal presentations

### 🎨 UI/UX Design
- **Beautiful Animations**: Smooth transitions using flutter_animate
- **Custom Gradients**: Professional color schemes throughout
- **Interactive Elements**: Hover states, tap feedback, and micro-interactions
- **Accessibility**: Proper contrast ratios and readable fonts

### 🔧 Dependencies
```yaml
dependencies:
  flutter: sdk: flutter
  google_fonts: ^6.1.0        # Beautiful typography
  flutter_animate: ^4.2.0+1   # Smooth animations
  http: ^1.1.0                 # API communication
  shared_preferences: ^2.2.2   # Local data storage
```

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   └── user_profile.dart       # Data models
├── screens/
│   └── home_screen.dart        # Main screen
├── widgets/
│   ├── user_profile_form.dart  # Profile creation form
│   ├── plan_dashboard.dart     # Main dashboard
│   ├── training_plan_widget.dart # Workout plans
│   ├── nutrition_plan_widget.dart # Nutrition plans
│   ├── progress_tracker.dart   # Progress tracking
│   ├── meal_planner.dart       # Custom meal planning
│   ├── workout_timer.dart      # Rest timer
│   ├── workout_detail_screen.dart # Workout sessions
│   └── settings_screen.dart    # App settings
├── services/
│   └── api_service.dart        # Backend communication
├── utils/
│   └── storage_helper.dart     # Local storage utilities
└── data/
    └── mock_data.dart          # Sample data
```

## Integration with Your Python Model

### API Endpoints
The app is designed to integrate with your Python backend through these endpoints:

```
POST /generate-plan          # Generate fitness plan
POST /generate-nutrition     # Generate nutrition plan
POST /save-progress         # Save user progress
GET  /progress/:userId      # Get progress history
POST /generate-meals        # Generate meal suggestions
POST /calculate-calories    # Calculate calorie needs
```

### Data Flow
1. **User Input**: Comprehensive profile form captures user data
2. **API Call**: Send profile data to your Python model
3. **Plan Generation**: Receive personalized fitness and nutrition plans
4. **Display**: Beautiful UI presents the plans to users
5. **Tracking**: Monitor progress and sync with backend

## Getting Started

### Prerequisites
- Flutter SDK (>=3.10.0)
- Dart SDK (>=3.0.0)
- Your Python API backend

### Installation
1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Update API URL in `lib/services/api_service.dart`
4. Run the app:
   ```bash
   flutter run
   ```

### Backend Integration
1. Replace `YOUR_PYTHON_API_URL` in `api_service.dart` with your actual API URL
2. Ensure your Python API accepts the JSON format defined in `UserProfile.toJson()`
3. Update response parsing in API service methods to match your backend response format

## Customization

### Theming
- Modify colors in `main.dart` and individual widgets
- Update gradients throughout the app for brand consistency
- Customize fonts by changing Google Fonts selections

### Features
- Add new workout types in `mock_data.dart`
- Extend user profile fields in `user_profile.dart`
- Create additional tracking metrics in progress tracker

## Performance Optimizations

- **Lazy Loading**: Lists use efficient builders
- **State Management**: Minimal rebuilds with proper state handling
- **Image Optimization**: No embedded images, uses icons and gradients
- **Memory Management**: Proper disposal of controllers and animations

## Future Enhancements

- [ ] Social features and workout sharing
- [ ] Wearable device integration
- [ ] Advanced analytics and insights
- [ ] Offline workout mode
- [ ] Video exercise demonstrations
- [ ] Nutrition barcode scanning

## License

This project is ready for commercial use and can be customized for your specific fitness and nutrition planning needs.