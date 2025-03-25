import 'package:flutter/material.dart';
import 'home_screen.dart';

class SensorActivationScreen extends StatefulWidget {
  const SensorActivationScreen({super.key});

  @override
  State<SensorActivationScreen> createState() => _SensorActivationScreenState();
}

class _SensorActivationScreenState extends State<SensorActivationScreen> {
  int _reminderHours = 8;
  double _sliderValue = 0.0;
  bool _isUnlocked = false;
  bool _showAlternativeButton = false;

  void _incrementHours() {
    setState(() {
      if (_reminderHours < 24) {
        _reminderHours++;
      }
    });
  }

  void _decrementHours() {
    setState(() {
      if (_reminderHours > 1) {
        _reminderHours--;
      }
    });
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Sensor image with animation
                    Container(
                      height: 250, // Reduced height for better balance
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('https://media.canva.com/v2/files/uri:ifs%3A%2F%2FM%2FkbwzMj8SyQGK5RUN9K6um5LsIjkmkytuT6-b9HXWE2k.jpg?csig=AAAAAAAAAAAAAAAAAAAAABxFPZvjZWYSgnS6sh-VtDHuJM_eZgVBTUkpEyq4ZCmD&exp=1742878280&signer=media-rpc&token=AAIAAU0AL2tid3pNajhTeVFHSzVSVU45SzZ1bTVMc0lqa21reXR1VDYtYjlIWFdFMmsuanBnAAAAAAGVy6QJQEncNrYbBlJU1npfMsmxXio3sNZ8kBDnhXi8Ssq0mzx8'),
                          fit: BoxFit.contain, // Changed to contain for better display
                        ),
                      ),
                    ),
                    
                    // Instruction text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Text(
                        'Move phone closer to sensor to Activate',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24, // Slightly smaller font
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF333333),
                        ),
                      ),
                    ),
                    
                    // Animated sensor target icon
                    TweenAnimationBuilder(
                      duration: const Duration(seconds: 2),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: 0.9 + (0.1 * value),
                          child: Container(
                            width: 160, // Slightly smaller
                            height: 160,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[200],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3 * value),
                                  blurRadius: 10 * value,
                                  spreadRadius: 2 * value,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[300],
                                ),
                                child: Center(
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFF0ABAB5).withOpacity(value),
                                    ),
                                    child: Icon(
                                      Icons.monitor_heart_outlined,
                                      color: Colors.white,
                                      size: 30 * value,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Reminder text
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Get a reminder to scan if you haven\'t scanned for',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18, // Smaller font
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Hour selector with improved UI
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Minus button
                          IconButton(
                            onPressed: _decrementHours,
                            icon: const Icon(Icons.remove),
                            style: IconButton.styleFrom(
                              backgroundColor: const Color(0xFFB0E2E4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          
                          // Hour display
                          Container(
                            width: 80,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                Text(
                                  '$_reminderHours',
                                  style: const TextStyle(
                                    fontSize: 32, // Slightly smaller
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const Text(
                                  'Hours',
                                  style: TextStyle(
                                    fontSize: 14, // Smaller
                                    color: Colors.black54,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          
                          // Plus button
                          IconButton(
                            onPressed: _incrementHours,
                            icon: const Icon(Icons.add),
                            style: IconButton.styleFrom(
                              backgroundColor: const Color(0xFFB0E2E4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            
            // Slide to unlock with fallback button
            Column(
              children: [
                // Slide to unlock button
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF333333),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      // Play button background
                      Positioned(
                        left: 0,
                        child: Container(
                          width: 70, // Smaller
                          height: 70,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                      
                      // Slider area
                      Padding(
                        padding: const EdgeInsets.only(left: 70),
                        child: SizedBox(
                          height: 70,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Slide to Start Tracking',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ...List.generate(3, (index) => 
                                  const Icon(Icons.chevron_right, color: Colors.white, size: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      // Actual slider
                      Positioned.fill(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 70,
                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0.0),
                            overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0),
                          ),
                          child: Slider(
                            value: _sliderValue,
                            min: 0.0,
                            max: 1.0,
                            activeColor: Colors.transparent,
                            inactiveColor: Colors.transparent,
                            thumbColor: Colors.transparent,
                            onChanged: (value) {
                              setState(() {
                                _sliderValue = value;
                                if (value >= 0.9) {
                                  _isUnlocked = true;
                                  _navigateToHome();
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Alternative button (appears after 5 seconds if slider isn't used)
                Visibility(
                  visible: _showAlternativeButton,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ElevatedButton(
                      onPressed: _navigateToHome,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0ABAB5),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Start Tracking'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Show alternative button after 5 seconds if slider isn't used
    Future.delayed(const Duration(seconds: 5), () {
      if (!_isUnlocked) {
        setState(() {
          _showAlternativeButton = true;
        });
      }
    });
  }
}