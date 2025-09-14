import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProgressTracker extends StatelessWidget {
  const ProgressTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          _buildWeeklyProgress(context),
          const SizedBox(height: 24),
          _buildStatsGrid(context),
          const SizedBox(height: 24),
          _buildRecentWorkouts(context),
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
              colors: [Color(0xFF7C3AED), Color(0xFFEC4899)],
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.trending_up,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Your Progress',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Track your fitness journey and achievements',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF6B7280),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildWeeklyProgress(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This Week\'s Progress',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildProgressItem('Workouts', '4', '5', 0.8),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildProgressItem('Calories', '1850', '2050', 0.9),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().slideY(begin: -0.2);
  }

  Widget _buildProgressItem(String label, String current, String target, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$current / $target',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: const Color(0xFFE5E7EB),
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF7C3AED)),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    final stats = [
      {'title': 'Total Workouts', 'value': '24', 'icon': Icons.fitness_center, 'color': const Color(0xFF10B981)},
      {'title': 'Calories Burned', 'value': '8,450', 'icon': Icons.local_fire_department, 'color': const Color(0xFFF59E0B)},
      {'title': 'Active Days', 'value': '18', 'icon': Icons.calendar_today, 'color': const Color(0xFF2563EB)},
      {'title': 'Personal Bests', 'value': '6', 'icon': Icons.emoji_events, 'color': const Color(0xFFEC4899)},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: (stat['color'] as Color).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    stat['icon'] as IconData,
                    color: stat['color'] as Color,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  stat['value'] as String,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  stat['title'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ).animate(delay: Duration(milliseconds: 200 * index)).scale();
      },
    );
  }

  Widget _buildRecentWorkouts(BuildContext context) {
    final recentWorkouts = [
      {'date': 'Today', 'workout': 'Upper Body Strength', 'duration': '60 min', 'completed': true},
      {'date': 'Yesterday', 'workout': 'Lower Body Power', 'duration': '55 min', 'completed': true},
      {'date': '2 days ago', 'workout': 'Cardio & Core', 'duration': '45 min', 'completed': true},
      {'date': '3 days ago', 'workout': 'Full Body Circuit', 'duration': '50 min', 'completed': false},
    ];

    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Workouts',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...recentWorkouts.map((workout) => _buildWorkoutItem(workout)),
          ],
        ),
      ),
    ).animate().slideX(begin: 0.2);
  }

  Widget _buildWorkoutItem(Map<String, dynamic> workout) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(12),
        color: workout['completed'] ? const Color(0xFF10B981).withOpacity(0.05) : const Color(0xFFF3F4F6),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: workout['completed'] ? const Color(0xFF10B981) : const Color(0xFF6B7280),
              shape: BoxShape.circle,
            ),
            child: Icon(
              workout['completed'] ? Icons.check : Icons.schedule,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workout['workout'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${workout['date']} • ${workout['duration']}',
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}