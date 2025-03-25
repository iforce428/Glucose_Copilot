import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'widgets/app_footer.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
              _buildGlucoseChart(),
              _buildWorkoutImpact(),
              _buildActivityLog(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppFooter(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  // Header with back button and menu
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: List.generate(3, (index) => Container(
                width: 24,
                height: 2,
                margin: const EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(2),
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }

  // Glucose chart section
  Widget _buildGlucoseChart() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Activity Tracker',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Glucose Level vs Exercise',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Text('Date: 25th March 2025', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                  Text('Time: 6:00 PM', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0ABAB5),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Update', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: LineChart(_createChartData()),
          ),
        ],
      ),
    );
  }

  // Chart data configuration
  LineChartData _createChartData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 50,
        getDrawingHorizontalLine: (value) => FlLine(color: Colors.grey[300], strokeWidth: 1),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => value == 6 
              ? const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text('Afternoon Run', style: TextStyle(color: Colors.black, fontSize: 12)),
                )
              : const SizedBox(),
            reservedSize: 30,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              const times = ['6 AM', '8 AM', '10 AM', '12 PM', '2 PM', '4 PM', '6 PM', '8 PM', '9 PM'];
              return value.toInt() >= 0 && value.toInt() < times.length
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(times[value.toInt()], style: const TextStyle(color: Colors.grey, fontSize: 10)),
                  )
                : const SizedBox();
            },
            reservedSize: 30,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 50,
            getTitlesWidget: (value, meta) => Text(
              value.toInt().toString(),
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            reservedSize: 30,
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
            FlSpot(0, 100), FlSpot(1, 105), FlSpot(2, 140), 
            FlSpot(3, 120), FlSpot(4, 150), FlSpot(5, 130),
            FlSpot(6, 145), FlSpot(7, 110), FlSpot(8, 140),
          ],
          isCurved: true,
          color: Colors.red,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
              radius: 4,
              color: Colors.red,
              strokeWidth: 2,
              strokeColor: Colors.white,
            ),
          ),
          belowBarData: BarAreaData(show: false),
        ),
      ],
      extraLinesData: ExtraLinesData(
        verticalLines: [
          VerticalLine(
            x: 6, // 6 PM - Afternoon Run
            color: Colors.green,
            strokeWidth: 2,
            dashArray: [5, 5],
          ),
        ],
      ),
    );
  }

  // Workout impact section
  Widget _buildWorkoutImpact() {
    return Container(
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Impact of Todays Workout', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          _buildImpactRow(
            color: Colors.green,
            icon: Icons.check,
            text: '30 min Run at 6:00 PM → Lowered glucose from 150 → 120 mg/dL',
          ),
          const SizedBox(height: 5),
          _buildImpactRow(
            color: Colors.orange,
            icon: Icons.arrow_forward,
            text: 'Tomorrow Recommendation: 30 min brisk walk after lunch to prevent the post-lunch spike (160 mg/dL).',
          ),
          const SizedBox(height: 5),
          const Text('Tomorrow Workout', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: const Color(0xFF0ABAB5),
              onPressed: () {},
              child: const Text('Set Reminder'),
            ),
          ),
        ],
      ),
    );
  }

  // Helper for impact rows
  Widget _buildImpactRow({required Color color, required IconData icon, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: Colors.white, size: 12),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500))),
      ],
    );
  }

  // Activity log section
  Widget _buildActivityLog() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Activity Log', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: const Color(0xFF0ABAB5),
              tabs: const [Tab(text: 'Progress'), Tab(text: 'Activities')],
            ),
          ),
          const SizedBox(height: 16),
          const Text('This Week', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildActivityCard(
            title: 'Running',
            distance: 'Distance: 23km/50km',
            time: 'Time: 2 hr',
            coin: 'Coin: 10',
            progress: 0.46,
            icon: Icons.directions_run,
          ),
          const SizedBox(height: 16),
          _buildActivityCard(
            title: 'Cycling',
            distance: 'Distance: 0km/15km',
            time: 'Time: 0 hr',
            coin: 'Coin: 10',
            progress: 0.0,
            icon: Icons.directions_bike,
          ),
        ],
      ),
    );
  }

  // Activity card widget
  Widget _buildActivityCard({
    required String title,
    required String distance,
    required String time,
    required String coin,
    required double progress,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Icon(icon, size: 40, color: Colors.black54),
            ],
          ),
          const SizedBox(height: 8),
          Text(distance, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(time, style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 16),
              Text(coin, style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 16),
          LinearPercentIndicator(
            lineHeight: 10.0,
            percent: progress,
            backgroundColor: Colors.grey[200],
            progressColor: const Color(0xFF0ABAB5),
            barRadius: const Radius.circular(7),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  // Bottom navigation bar
  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0ABAB5),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home', false, onTap: () => Navigator.pop(context)),
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

  // Navigation item widget
  Widget _buildNavItem(IconData icon, String label, bool isSelected, {VoidCallback? onTap}) {
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

