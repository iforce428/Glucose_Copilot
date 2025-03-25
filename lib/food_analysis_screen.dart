import 'dart:io';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class FoodAnalysisScreen extends StatelessWidget {
  final String imagePath;

  const FoodAnalysisScreen({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              _buildFoodTitle(),
              _buildFoodImage(),
              _buildGlycemicIndex(),
              _buildNutritionGrid(),
              const SizedBox(height: 60), // Reduced space for bottom navigation
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0), // Reduced padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            style: IconButton.styleFrom(
              backgroundColor: Colors.grey[700],
              padding: const EdgeInsets.all(10), // Smaller padding
            ),
            onPressed: () => Navigator.pop(context),
          ),
          Container(
            padding: const EdgeInsets.all(6), // Smaller padding
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: List.generate(3, (index) => Container(
                width: 20, // Smaller width
                height: 1.5, // Thinner lines
                margin: const EdgeInsets.symmetric(vertical: 1.5),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(1),
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8), // Reduced padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Grilled Salmon',
            style: TextStyle(
              fontSize: 24, // Smaller font size
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0ABAB5),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6), // Smaller radius
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12, // Reduced padding
                vertical: 8,
              ),
            ),
            child: const Text(
              'Update Meal',
              style: TextStyle(
                fontSize: 14, // Smaller font size
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodImage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Reduced padding
        child: Container(
          width: 160, // Smaller image
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8, // Smaller shadow
                offset: const Offset(0, 4),
              ),
            ],
            image: DecorationImage(
              image: FileImage(File(imagePath)),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlycemicIndex() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Reduced margin
      padding: const EdgeInsets.all(16), // Reduced padding
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12), // Smaller radius
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Glycemic Index',
                  style: TextStyle(
                    fontSize: 18, // Smaller font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Diabetes-Friendly',
                  style: TextStyle(
                    fontSize: 14, // Smaller font size
                  ),
                ),
                const SizedBox(height: 6), // Reduced spacing
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10, // Reduced padding
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12), // Smaller radius
                  ),
                  child: const Text(
                    'Recommended',
                    style: TextStyle(
                      fontSize: 12, // Smaller font size
                    ),
                  ),
                ),
                const SizedBox(height: 12), // Reduced spacing
                ..._buildBenefitItems(),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: CircularPercentIndicator(
              radius: 50.0, // Smaller indicator
              lineWidth: 10.0,
              percent: 0.42,
              center: const Text(
                "42%",
                style: TextStyle(
                  fontSize: 20, // Smaller font size
                ),
              ),
              progressColor: const Color(0xFF006C5B),
              backgroundColor: Colors.white,
              circularStrokeCap: CircularStrokeCap.round,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBenefitItems() {
    final benefits = [
      'Protein-based meal → Slower glucose rise',
      'Fiber from vegetables → Better digestion',
      'Brown rice (low GI) → Better energy without sharp spike',
    ];
    
    return benefits.map((text) => Padding(
      padding: const EdgeInsets.only(bottom: 6), // Reduced spacing
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8), // Smaller radius
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 10, // Smaller icon
            ),
          ),
          const SizedBox(width: 6), // Reduced spacing
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 10, // Smaller font size
              ),
            ),
          ),
        ],
      ),
    )).toList();
  }

  Widget _buildNutritionGrid() {
    return Padding(
      padding: const EdgeInsets.all(12.0), // Reduced padding
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildNutritionCard(
                  title: 'Calories',
                  value: '280 kcal/2000 kcal',
                  percent: 0.72,
                  status: 'Good',
                  color: const Color(0xFFB0E2E4),
                ),
              ),
              const SizedBox(width: 12), // Reduced spacing
              Expanded(
                child: _buildNutritionCard(
                  title: 'Protein',
                  value: '7g/100g',
                  percent: 0.72,
                  status: 'Moderate',
                  color: const Color(0xFFB3C4E4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12), // Reduced spacing
          Row(
            children: [
              Expanded(
                child: _buildNutritionCard(
                  title: 'Carbs',
                  value: '28g/250g',
                  percent: 0.72,
                  status: 'Watch Intake',
                  color: const Color(0xFFB7E47A),
                ),
              ),
              const SizedBox(width: 12), // Reduced spacing
              Expanded(
                child: _buildNutritionCard(
                  title: 'Fats',
                  value: '15g/80g',
                  percent: 0.72,
                  status: 'Healthy Fats',
                  color: const Color(0xFFFFEB9A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionCard({
    required String title,
    required String value,
    required double percent,
    required String status,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12), // Reduced padding
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12), // Smaller radius
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16, // Smaller font size
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12, // Smaller font size
            ),
          ),
          const SizedBox(height: 12), // Reduced spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                status,
                style: const TextStyle(
                  fontSize: 16, // Smaller font size
                ),
              ),
              CircularPercentIndicator(
                radius: 16.0, // Smaller indicator
                lineWidth: 4.0,
                percent: percent,
                progressColor: const Color(0xFF0ABAB5),
                backgroundColor: Colors.white,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  "${(percent * 100).toInt()}%",
                  style: const TextStyle(
                    fontSize: 10, // Smaller font size
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0ABAB5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8, // Smaller shadow
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6), // Reduced padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home', false, onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              }),
              _buildNavItem(Icons.grid_view, 'Dashboard', false),
              _buildNavItem(Icons.auto_awesome, 'Features', false),
              _buildNavItem(Icons.medical_services_outlined, 'Health', false),
              _buildNavItem(Icons.person_outline, 'Profile', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20, // Smaller icon
          ),
          const SizedBox(height: 2), // Reduced spacing
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10, // Smaller font size
            ),
          ),
        ],
      ),
    );
  }
}