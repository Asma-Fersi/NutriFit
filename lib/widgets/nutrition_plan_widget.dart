import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/user_profile.dart';

class NutritionPlanWidget extends StatelessWidget {
  final List<Meal> meals;
  final DailyTargets dailyTargets;

  const NutritionPlanWidget({
    super.key,
    required this.meals,
    required this.dailyTargets,
  });

  @override
  Widget build(BuildContext context) {
    final totalCalories = meals.fold(0, (sum, meal) => sum + meal.calories);
    final totalProtein = meals.fold(0, (sum, meal) => sum + meal.protein);
    final totalCarbs = meals.fold(0, (sum, meal) => sum + meal.carbs);
    final totalFats = meals.fold(0, (sum, meal) => sum + meal.fats);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          _buildDailySummary(context, totalCalories, totalProtein, totalCarbs, totalFats),
          const SizedBox(height: 24),
          ...meals.asMap().entries.map((entry) {
            final index = entry.key;
            final meal = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildMealCard(context, meal)
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
              colors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.restaurant,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Your Nutrition Plan',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Balanced meal plan to support your fitness goals',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF6B7280),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDailySummary(BuildContext context, int totalCalories, int totalProtein, int totalCarbs, int totalFats) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF59E0B).withOpacity(0.1),
            const Color(0xFFEF4444).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.trending_up,
                color: Color(0xFFF59E0B),
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Daily Nutrition Summary',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildNutrientSummary('Calories', totalCalories.toString(), dailyTargets.calories.toString(), const Color(0xFFF59E0B))),
              Expanded(child: _buildNutrientSummary('Protein', '${totalProtein}g', '${dailyTargets.protein}g', const Color(0xFF2563EB))),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildNutrientSummary('Carbs', '${totalCarbs}g', '${dailyTargets.carbs}g', const Color(0xFF10B981))),
              Expanded(child: _buildNutrientSummary('Fats', '${totalFats}g', '${dailyTargets.fats}g', const Color(0xFF7C3AED))),
            ],
          ),
        ],
      ),
    ).animate().slideY(begin: -0.2);
  }

  Widget _buildNutrientSummary(String label, String actual, String target, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            actual,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF6B7280),
            ),
          ),
          Text(
            'Target: $target',
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealCard(BuildContext context, Meal meal) {
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
                  meal.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: Color(0xFFF59E0B),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        meal.time,
                        style: const TextStyle(
                          color: Color(0xFFF59E0B),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildMacroCard('${meal.calories}', 'Calories', const Color(0xFFF59E0B), Icons.local_fire_department)),
                const SizedBox(width: 8),
                Expanded(child: _buildMacroCard('${meal.protein}g', 'Protein', const Color(0xFF2563EB), Icons.fitness_center)),
                const SizedBox(width: 8),
                Expanded(child: _buildMacroCard('${meal.carbs}g', 'Carbs', const Color(0xFF10B981), Icons.grain)),
                const SizedBox(width: 8),
                Expanded(child: _buildMacroCard('${meal.fats}g', 'Fats', const Color(0xFF7C3AED), Icons.opacity)),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Foods:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF374151),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: meal.foods.map((food) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  food,
                  style: const TextStyle(
                    color: Color(0xFF374151),
                    fontSize: 12,
                  ),
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroCard(String value, String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 14,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}