import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:async';

class WorkoutTimer extends StatefulWidget {
  final String exerciseName;
  final int restTimeSeconds;
  final VoidCallback onComplete;

  const WorkoutTimer({
    super.key,
    required this.exerciseName,
    required this.restTimeSeconds,
    required this.onComplete,
  });

  @override
  State<WorkoutTimer> createState() => _WorkoutTimerState();
}

class _WorkoutTimerState extends State<WorkoutTimer>
    with TickerProviderStateMixin {
  late Timer _timer;
  late int _remainingSeconds;
  late AnimationController _pulseController;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.restTimeSeconds;
    _pulseController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });
    _pulseController.repeat();
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer.cancel();
          _pulseController.stop();
          _isRunning = false;
          widget.onComplete();
        }
      });
    });
  }

  void _pauseTimer() {
    setState(() {
      _isRunning = false;
    });
    _timer.cancel();
    _pulseController.stop();
  }

  void _resetTimer() {
    setState(() {
      _remainingSeconds = widget.restTimeSeconds;
      _isRunning = false;
    });
    _timer.cancel();
    _pulseController.stop();
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2563EB).withOpacity(0.1),
            const Color(0xFF7C3AED).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Rest Timer',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.exerciseName,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF6B7280),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Transform.scale(
                scale: _isRunning ? 1.0 + (_pulseController.value * 0.1) : 1.0,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF2563EB),
                        const Color(0xFF7C3AED),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2563EB).withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      _formatTime(_remainingSeconds),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTimerButton(
                icon: _isRunning ? Icons.pause : Icons.play_arrow,
                label: _isRunning ? 'Pause' : 'Start',
                onPressed: _isRunning ? _pauseTimer : _startTimer,
                color: const Color(0xFF10B981),
              ),
              _buildTimerButton(
                icon: Icons.refresh,
                label: 'Reset',
                onPressed: _resetTimer,
                color: const Color(0xFF6B7280),
              ),
              _buildTimerButton(
                icon: Icons.skip_next,
                label: 'Skip',
                onPressed: widget.onComplete,
                color: const Color(0xFFF59E0B),
              ),
            ],
          ),
        ],
      ),
    ).animate().scale(duration: 600.ms);
  }

  Widget _buildTimerButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16),
            elevation: 4,
          ),
          child: Icon(icon, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}