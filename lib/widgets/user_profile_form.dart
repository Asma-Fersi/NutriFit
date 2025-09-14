import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/user_profile.dart';

class UserProfileForm extends StatefulWidget {
  final Function(UserProfile) onSubmit;

  const UserProfileForm({super.key, required this.onSubmit});

  @override
  State<UserProfileForm> createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  
  String _gender = '';
  String _activityLevel = '';
  String _fitnessGoal = '';
  String _experience = '';
  int _workoutsPerWeek = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildBasicInfo(),
            const SizedBox(height: 24),
            _buildActivityLevel(),
            const SizedBox(height: 24),
            _buildFitnessGoals(),
            const SizedBox(height: 24),
            _buildExperienceAndFrequency(),
            const SizedBox(height: 32),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.fitness_center,
            color: Colors.white,
            size: 40,
          ),
        ).animate().scale(delay: 200.ms, duration: 600.ms),
        const SizedBox(height: 16),
        Text(
          'Your Fitness Profile',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1F2937),
          ),
        ).animate().fadeIn(delay: 400.ms),
        const SizedBox(height: 8),
        Text(
          'Tell us about yourself to get a personalized plan',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF6B7280),
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 600.ms),
      ],
    );
  }

  Widget _buildBasicInfo() {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Information',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _ageController,
                    label: 'Age',
                    hint: '25',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    controller: _weightController,
                    label: 'Weight (kg)',
                    hint: '70',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _heightController,
                    label: 'Height (cm)',
                    hint: '175',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDropdown(
                    label: 'Gender',
                    value: _gender,
                    items: const ['Male', 'Female', 'Other'],
                    onChanged: (value) => setState(() => _gender = value!),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().slideX(delay: 800.ms, begin: -0.2);
  }

  Widget _buildActivityLevel() {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Activity Level',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...['Sedentary', 'Moderate', 'Very Active'].map((level) {
              final descriptions = {
                'Sedentary': 'Little to no exercise',
                'Moderate': '3-4 days per week',
                'Very Active': '5+ days per week',
              };
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildSelectionCard(
                  title: level,
                  subtitle: descriptions[level]!,
                  isSelected: _activityLevel == level,
                  onTap: () => setState(() => _activityLevel = level),
                ),
              );
            }),
          ],
        ),
      ),
    ).animate().slideX(delay: 1000.ms, begin: 0.2);
  }

  Widget _buildFitnessGoals() {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fitness Goal',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.5,
              children: [
                'Weight Loss',
                'Muscle Gain',
                'Endurance',
                'General Fitness',
              ].map((goal) => _buildGoalCard(goal)).toList(),
            ),
          ],
        ),
      ),
    ).animate().slideX(delay: 1200.ms, begin: -0.2);
  }

  Widget _buildExperienceAndFrequency() {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Experience & Frequency',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDropdown(
                    label: 'Experience Level',
                    value: _experience,
                    items: const ['Beginner', 'Intermediate', 'Advanced'],
                    onChanged: (value) => setState(() => _experience = value!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDropdown(
                    label: 'Workouts per week',
                    value: _workoutsPerWeek == 0 ? '' : _workoutsPerWeek.toString(),
                    items: const ['2', '3', '4', '5', '6'],
                    onChanged: (value) => setState(() => _workoutsPerWeek = int.parse(value!)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().slideX(delay: 1400.ms, begin: 0.2);
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: const Color(0xFF2563EB).withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'Generate My Personalized Plan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ).animate().scale(delay: 1600.ms, duration: 600.ms);
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value.isEmpty ? null : value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2),
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select $label';
        }
        return null;
      },
    );
  }

  Widget _buildSelectionCard({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFE5E7EB),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? const Color(0xFF2563EB).withOpacity(0.1) : Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? const Color(0xFF2563EB) : const Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: isSelected ? const Color(0xFF2563EB) : const Color(0xFF6B7280),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalCard(String goal) {
    final isSelected = _fitnessGoal == goal;
    return GestureDetector(
      onTap: () => setState(() => _fitnessGoal = goal),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFE5E7EB),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? const Color(0xFF2563EB).withOpacity(0.1) : Colors.white,
        ),
        child: Center(
          child: Text(
            goal,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? const Color(0xFF2563EB) : const Color(0xFF1F2937),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() &&
        _gender.isNotEmpty &&
        _activityLevel.isNotEmpty &&
        _fitnessGoal.isNotEmpty &&
        _experience.isNotEmpty &&
        _workoutsPerWeek > 0) {
      
      final profile = UserProfile(
        age: int.parse(_ageController.text),
        weight: double.parse(_weightController.text),
        height: double.parse(_heightController.text),
        gender: _gender,
        activityLevel: _activityLevel,
        fitnessGoal: _fitnessGoal,
        experience: _experience,
        workoutsPerWeek: _workoutsPerWeek,
      );
      
      widget.onSubmit(profile);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}