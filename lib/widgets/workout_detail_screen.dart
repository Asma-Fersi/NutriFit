import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/user_profile.dart';
import 'workout_timer.dart';

class WorkoutDetailScreen extends StatefulWidget {
  final WorkoutDay workout;

  const WorkoutDetailScreen({super.key, required this.workout});

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  int currentExerciseIndex = 0;
  List<bool> completedExercises = [];

  @override
  void initState() {
    super.initState();
    completedExercises = List.filled(widget.workout.exercises.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout.day),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showWorkoutInfo,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFEBF4FF),
              Color(0xFFFFFFFF),
              Color(0xFFF3E8FF),
            ],
          ),
        ),
        child: Column(
          children: [
            _buildProgressHeader(),
            Expanded(
              child: _buildExerciseList(),
            ),
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressHeader() {
    final completedCount = completedExercises.where((completed) => completed).length;
    final progress = completedCount / widget.workout.exercises.length;

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.workout.focus,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$completedCount/${widget.workout.exercises.length}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF10B981),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFFE5E7EB),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
            minHeight: 8,
          ),
        ],
      ),
    ).animate().slideY(begin: -0.2);
  }

  Widget _buildExerciseList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: widget.workout.exercises.length,
      itemBuilder: (context, index) {
        final exercise = widget.workout.exercises[index];
        final isCompleted = completedExercises[index];
        final isCurrent = index == currentExerciseIndex;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Card(
            elevation: isCurrent ? 12 : 4,
            shadowColor: isCurrent 
                ? const Color(0xFF2563EB).withOpacity(0.3)
                : Colors.black.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: isCurrent 
                  ? const BorderSide(color: Color(0xFF2563EB), width: 2)
                  : BorderSide.none,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isCompleted 
                              ? const Color(0xFF10B981)
                              : isCurrent
                                  ? const Color(0xFF2563EB)
                                  : const Color(0xFFE5E7EB),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: isCompleted
                              ? const Icon(Icons.check, color: Colors.white, size: 20)
                              : Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: isCurrent ? Colors.white : const Color(0xFF6B7280),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exercise.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isCompleted 
                                    ? const Color(0xFF6B7280)
                                    : const Color(0xFF1F2937),
                                decoration: isCompleted 
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${exercise.sets} sets × ${exercise.reps} reps',
                              style: const TextStyle(
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!isCompleted)
                        ElevatedButton(
                          onPressed: () => _markAsCompleted(index),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF10B981),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Complete'),
                        ),
                    ],
                  ),
                  if (exercise.weight != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Weight: ${exercise.weight}',
                        style: const TextStyle(
                          color: Color(0xFF374151),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ).animate(delay: Duration(milliseconds: 100 * index)).slideX(begin: 0.2);
      },
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _startRestTimer,
              icon: const Icon(Icons.timer),
              label: const Text('Start Rest Timer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: _finishWorkout,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Finish'),
          ),
        ],
      ),
    );
  }

  void _markAsCompleted(int index) {
    setState(() {
      completedExercises[index] = true;
      if (index == currentExerciseIndex && index < widget.workout.exercises.length - 1) {
        currentExerciseIndex = index + 1;
      }
    });
  }

  void _startRestTimer() {
    if (currentExerciseIndex < widget.workout.exercises.length) {
      final exercise = widget.workout.exercises[currentExerciseIndex];
      final restTimeString = exercise.restTime.replaceAll(RegExp(r'[^0-9]'), '');
      final restTimeSeconds = int.tryParse(restTimeString) ?? 60;
      
      showModalBottomSheet(
        context: context,
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
  }

  void _showWorkoutInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(widget.workout.day),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Focus: ${widget.workout.focus}'),
            const SizedBox(height: 8),
            Text('Duration: ${widget.workout.duration}'),
            const SizedBox(height: 8),
            Text('Exercises: ${widget.workout.exercises.length}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _finishWorkout() {
    final completedCount = completedExercises.where((completed) => completed).length;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Workout Complete!'),
        content: Text('You completed $completedCount out of ${widget.workout.exercises.length} exercises. Great job!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}