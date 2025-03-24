import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'chat_screen.dart';
import 'dietary_screen.dart';
import 'medication_screen.dart';
import 'activity_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildGlucoseChart(),
              _buildInfoCards(),
              _buildCategories(context),
              _buildConsultation(),
              const SizedBox(height: 80), // Space for bottom navigation
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.amber[300],
            child: ClipOval(
              child: Image.asset(
                'assets/profile_pic.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Good Morning',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Adam Malek',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.orange[400],
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none, size: 30),
                color: Colors.amber,
                onPressed: () {},
              ),
              Positioned(
                right: 12,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGlucoseChart() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 7.0, 12.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Live Glucose Level',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const Text(
            'Date: 25th March 2025',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
          const Text(
            'Time: 9:00 PM',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 160,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 50,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[300],
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const times = [
                          '6 AM',
                          '8 AM',
                          '10 AM',
                          '12 PM',
                          '2 PM',
                          '4 PM',
                          '6 PM',
                          '8 PM',
                          '9 PM'
                        ];
                        if (value.toInt() >= 0 && value.toInt() < times.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              times[value.toInt()],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 8,
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                      reservedSize: 24,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 50,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        );
                      },
                      reservedSize: 24,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 8,
                minY: 0,
                maxY: 200,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 100), // 6 AM
                      FlSpot(1, 105), // 8 AM
                      FlSpot(2, 140), // 10 AM
                      FlSpot(3, 120), // 12 PM
                      FlSpot(4, 150), // 2 PM
                      FlSpot(5, 130), // 4 PM
                      FlSpot(6, 145), // 6 PM
                      FlSpot(7, 120), // 8 PM
                      FlSpot(8, 180), // 9 PM
                    ],
                    isCurved: true,
                    color: Colors.red,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 3,
                          color: Colors.red,
                          strokeWidth: 1.5,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCards() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                  title: 'Glucose Level',
                  subtitle: 'Slightly Increasing',
                  value: '60%',
                  valueColor: Colors.red,
                  icon: Icons.monitor_heart_outlined,
                  backgroundColor: Colors.cyan[100]!,
                  showUpArrow: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInfoCard(
                  title: 'Carbo Intake',
                  subtitle: 'Average amout',
                  value: 'Limit Sugar',
                  valueColor: Colors.black87,
                  icon: Icons.restaurant_outlined,
                  backgroundColor: Colors.blue[100]!,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                  title: 'Last Medication',
                  subtitle: 'Last Taken:',
                  subtitleExtra: 'Metformin - 2:00 PM',
                  value: '3/4',
                  valueColor: Colors.black87,
                  icon: Icons.medication_outlined,
                  backgroundColor: Colors.lightGreen[100]!,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInfoCard(
                  title: 'Physical Activity',
                  subtitle: 'Run - 30 mins at',
                  subtitleExtra: '6:00 PM',
                  value: 'Optimum',
                  valueColor: Colors.black87,
                  icon: Icons.directions_run_outlined,
                  backgroundColor: Colors.amber[100]!,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String subtitle,
    String? subtitleExtra,
    required String value,
    required Color valueColor,
    required IconData icon,
    required Color backgroundColor,
    bool showUpArrow = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black54,
                    ),
                  ),
                  if (subtitleExtra != null)
                    Text(
                      subtitleExtra,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                      ),
                    ),
                  const SizedBox(height: 1),
                  Row(
                    children: [
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: valueColor,
                        ),
                      ),
                      if (showUpArrow)
                        Icon(
                          Icons.arrow_upward,
                          color: valueColor,
                          size: 20,
                        ),
                    ],
                  ),
                ],
              ),
              Icon(
                icon,
                size: 30,
                color: Colors.black54,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCategoryItem(
                icon: Icons.fitness_center,
                label: 'Activity',
                color: Colors.blue[100]!,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ActivityScreen(),
                    ),
                  );
                },
              ),
              _buildCategoryItem(
                icon: Icons.restaurant_menu,
                label: 'Dietary',
                color: Colors.blue[100]!,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DietaryScreen(),
                    ),
                  );
                },
              ),
              _buildCategoryItem(
                icon: Icons.medical_services,
                label: 'Medication',
                color: Colors.blue[100]!,
               onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MedicationScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem({
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 30,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsultation() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Consultation',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Green_Stack__Copy_-xKuJHGMpQJhDWGTDBewqwzwSmT6yCs.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'More Accurate Health\nManagement with AI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          child: const Text('Start'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Green_Stack__Copy_-xKuJHGMpQJhDWGTDBewqwzwSmT6yCs.png',
                      ),
                      fit: BoxFit.cover,
                    ),
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
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home', true),
              _buildNavItem(
                Icons.grid_view,
                'Dashboard',
                false,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DietaryScreen(),
                    ),
                  );
                },
              ),
              _buildNavItem(Icons.auto_awesome, 'Features', false),
              _buildNavItem(
                Icons.medical_services_outlined,
                'Health',
                false,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatScreen(),
                    ),
                  );
                },
              ),
              _buildNavItem(Icons.person_outline, 'Profile', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected,
      {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
