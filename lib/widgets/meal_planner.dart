import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MealPlanner extends StatefulWidget {
  const MealPlanner({super.key});

  @override
  State<MealPlanner> createState() => _MealPlannerState();
}

class _MealPlannerState extends State<MealPlanner> {
  final List<String> _selectedIngredients = [];
  final List<String> _availableIngredients = [
    'Chicken Breast', 'Salmon', 'Eggs', 'Greek Yogurt', 'Quinoa',
    'Brown Rice', 'Sweet Potato', 'Broccoli', 'Spinach', 'Avocado',
    'Almonds', 'Olive Oil', 'Banana', 'Berries', 'Oats'
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          _buildIngredientSelector(context),
          const SizedBox(height: 24),
          _buildMealSuggestions(context),
          const SizedBox(height: 24),
          _buildGenerateButton(context),
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
              colors: [Color(0xFF10B981), Color(0xFF059669)],
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.restaurant_menu,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Meal Planner',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Create custom meals based on your preferences',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF6B7280),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildIngredientSelector(BuildContext context) {
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
              'Select Ingredients',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableIngredients.map((ingredient) {
                final isSelected = _selectedIngredients.contains(ingredient);
                return FilterChip(
                  label: Text(ingredient),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedIngredients.add(ingredient);
                      } else {
                        _selectedIngredients.remove(ingredient);
                      }
                    });
                  },
                  selectedColor: const Color(0xFF10B981).withOpacity(0.2),
                  checkmarkColor: const Color(0xFF10B981),
                  backgroundColor: const Color(0xFFF3F4F6),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    ).animate().slideY(begin: -0.2);
  }

  Widget _buildMealSuggestions(BuildContext context) {
    if (_selectedIngredients.isEmpty) {
      return const SizedBox.shrink();
    }

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
              'Suggested Meals',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ..._generateMealSuggestions().map((meal) => _buildMealSuggestion(meal)),
          ],
        ),
      ),
    ).animate().slideX(begin: 0.2);
  }

  List<Map<String, dynamic>> _generateMealSuggestions() {
    // Simple meal generation based on selected ingredients
    final suggestions = <Map<String, dynamic>>[];
    
    if (_selectedIngredients.contains('Chicken Breast') && 
        _selectedIngredients.contains('Brown Rice')) {
      suggestions.add({
        'name': 'Chicken & Rice Bowl',
        'calories': 450,
        'protein': 35,
        'ingredients': ['Chicken Breast', 'Brown Rice', 'Broccoli'],
      });
    }
    
    if (_selectedIngredients.contains('Salmon') && 
        _selectedIngredients.contains('Sweet Potato')) {
      suggestions.add({
        'name': 'Salmon Sweet Potato',
        'calories': 520,
        'protein': 30,
        'ingredients': ['Salmon', 'Sweet Potato', 'Spinach'],
      });
    }
    
    if (_selectedIngredients.contains('Eggs') && 
        _selectedIngredients.contains('Avocado')) {
      suggestions.add({
        'name': 'Avocado Egg Bowl',
        'calories': 380,
        'protein': 20,
        'ingredients': ['Eggs', 'Avocado', 'Spinach'],
      });
    }
    
    return suggestions;
  }

  Widget _buildMealSuggestion(Map<String, dynamic> meal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFF9FAFB),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                meal['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF1F2937),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${meal['calories']} cal',
                  style: const TextStyle(
                    color: Color(0xFF10B981),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Protein: ${meal['protein']}g',
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 4,
            children: (meal['ingredients'] as List<String>).map((ingredient) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  ingredient,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF374151),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildGenerateButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: _selectedIngredients.isNotEmpty ? _generateMealPlan : null,
        icon: const Icon(Icons.auto_awesome),
        label: const Text('Generate Meal Plan'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFE5E7EB),
          elevation: 8,
          shadowColor: const Color(0xFF10B981).withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    ).animate().scale(delay: 600.ms);
  }

  void _generateMealPlan() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Meal Plan Generated!'),
        content: const Text('Your personalized meal plan has been created based on your selected ingredients.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('View Plan'),
          ),
        ],
      ),
    );
  }
}