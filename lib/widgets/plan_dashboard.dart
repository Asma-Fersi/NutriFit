import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/user_profile.dart';
import '../data/mock_data.dart';
import 'training_plan_widget.dart';
import 'nutrition_plan_widget.dart';
import 'progress_tracker.dart';
import 'meal_planner.dart';
import 'settings_screen.dart';

class PlanDashboard extends StatefulWidget {
  final UserProfile userProfile;
  final VoidCallback onNewPlan;

  const PlanDashboard({
    super.key,
    required this.userProfile,
    required this.onNewPlan,
  });

  @override
  State<PlanDashboard> createState() => _PlanDashboardState();
}

class _PlanDashboardState extends State<PlanDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildUserSummary(),
        _buildTabBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              TrainingPlanWidget(workouts: MockData.workouts),
              NutritionPlanWidget(
                meals: MockData.meals,
                dailyTargets: MockData.dailyTargets,
              ),
              const ProgressTracker(),
              const MealPlanner(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.fitness_center,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FitPlan AI',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Personalized Fitness & Nutrition',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: widget.onNewPlan,
            icon: const Icon(Icons.refresh),
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFF3F4F6),
              foregroundColor: const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => _navigateToSettings(context),
            icon: const Icon(Icons.settings),
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFF3F4F6),
              foregroundColor: const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    ).animate().fadeIn();
  }

  Widget _buildUserSummary() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to Your Personalized Plan!',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _buildSummaryChip('Goal', widget.userProfile.fitnessGoal),
              _buildSummaryChip('Experience', widget.userProfile.experience),
              _buildSummaryChip('Frequency', '${widget.userProfile.workoutsPerWeek} days/week'),
            ],
          ),
        ],
      ),
    ).animate().slideY(delay: 200.ms, begin: -0.2);
  }

  Widget _buildSummaryChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2563EB).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$label: $value',
        style: const TextStyle(
          color: Color(0xFF2563EB),
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Color(0xFF10B981), Color(0xFF2563EB)],
          ),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF6B7280),
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        tabs: const [
          Tab(
            icon: Icon(Icons.fitness_center),
            text: 'Training Plan',
          ),
          Tab(
            icon: Icon(Icons.restaurant),
            text: 'Nutrition Plan',
          ),
          Tab(
            icon: Icon(Icons.trending_up),
            text: 'Progress',
          ),
          Tab(
            icon: Icon(Icons.restaurant_menu),
            text: 'Meal Planner',
          ),
        ],
      ),
    ).animate().slideY(delay: 400.ms, begin: 0.2);
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }
}