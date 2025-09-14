import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/user_profile.dart';
import '../widgets/user_profile_form.dart';
import '../widgets/plan_dashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserProfile? userProfile;

  void _onProfileSubmit(UserProfile profile) {
    setState(() {
      userProfile = profile;
    });
  }

  void _onNewPlan() {
    setState(() {
      userProfile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SafeArea(
          child: userProfile == null
              ? UserProfileForm(onSubmit: _onProfileSubmit)
              : PlanDashboard(
                  userProfile: userProfile!,
                  onNewPlan: _onNewPlan,
                ),
        ),
      ),
    );
  }
}