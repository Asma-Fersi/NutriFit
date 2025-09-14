import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/user_profile.dart';
import 'workout_timer.dart';
import 'workout_detail_screen.dart';

class TrainingPlanWidget extends StatelessWidget {
  final List<WorkoutDay> workouts;

  const TrainingPlanWidget({super.key, required this.workouts});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          ...workouts.asMap().entries.map((entry) {
            final index = entry.key;
            final workout = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildWorkoutCard(context, workout)
                  .animate(delay: Duration(milliseconds: 200 * index))
                  .slideX(begin: index.isEven ? -0.2 : 0.2)
                  .fadeIn(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF10B981), Color(0xFF2563EB)],
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.fitness_center,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Your Training Plan',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Customized workout routine based on your profile',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF6B7280),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildWorkoutCard(BuildContext context, WorkoutDay workout) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  workout.day,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _startWorkout(context, workout),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Start Workout'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: Color(0xFF10B981),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        workout.duration,
                        style: const TextStyle(
                          color: Color(0xFF10B981),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF10B981).withOpacity(0.1),
                        const Color(0xFF2563EB).withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.track_changes,
                        color: Color(0xFF10B981),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        workout.focus,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...workout.exercises.map((exercise) => _buildExerciseItem(exercise)),
          ],
        ),
      ),
    );
  }

  void _startWorkout(BuildContext context, WorkoutDay workout) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutDetailScreen(workout: workout),
      ),
    );
  }

  Widget _buildExerciseItem(Exercise exercise) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      childrenPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.white,
      collapsedBackgroundColor: const Color(0xFFF9FAFB),
      title: Text(
        exercise.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Color(0xFF1F2937),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          children: [
            _buildExerciseDetail(Icons.repeat, '${exercise.sets} sets'),
            const SizedBox(width: 16),
            _buildExerciseDetail(Icons.fitness_center, '${exercise.reps} reps'),
            if (exercise.weight != null) ...[
              const SizedBox(width: 16),
              _buildExerciseDetail(Icons.monitor_weight, exercise.weight!),
            ],
          ],
        ),
      ),
      children: [
        Row(
          children: [
            Expanded(
              child: _buildExerciseDetail(Icons.timer, 'Rest: ${exercise.restTime}'),
            ),
            ElevatedButton.icon(
              onPressed: () => _showRestTimer(exercise),
              icon: const Icon(Icons.timer, size: 16),
              label: const Text('Start Timer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showRestTimer(Exercise exercise) {
    // Extract seconds from rest time string (e.g., "90s" -> 90)
    final restTimeString = exercise.restTime.replaceAll(RegExp(r'[^0-9]'), '');
    final restTimeSeconds = int.tryParse(restTimeString) ?? 60;
    
    showModalBottomSheet(
      context: navigatorKey.currentContext!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: WorkoutTimer(
          exerciseName: exercise.name,
          restTimeSeconds: restTimeSeconds,
          onComplete: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  Widget _buildOldExerciseItem(Exercise exercise) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exercise.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildExerciseDetail(Icons.repeat, '${exercise.sets} sets'),
              const SizedBox(width: 16),
              _buildExerciseDetail(Icons.fitness_center, '${exercise.reps} reps'),
              if (exercise.weight != null) ...[
                const SizedBox(width: 16),
                _buildExerciseDetail(Icons.monitor_weight, exercise.weight!),
              ],
            ],
          ),
          const SizedBox(height: 8),
          _buildExerciseDetail(Icons.timer, 'Rest: ${exercise.restTime}'),
        ],
      ),
    );
  }

  Widget _buildExerciseDetail(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: const Color(0xFF6B7280),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

// Global navigator key for accessing context from static methods
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();