import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'food_scanner_screen.dart';

class DietaryScreen extends StatelessWidget {
  const DietaryScreen({super.key});

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
              _buildGlucoseChart(context),
              _buildLastReading(),
              _buildRecommendedDinner(),
              const SizedBox(height: 80), // Space for bottom navigation
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 7.0, 12.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 20,
                      height: 2,
                      margin: const EdgeInsets.symmetric(vertical: 1),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Container(
                      width: 20,
                      height: 2,
                      margin: const EdgeInsets.symmetric(vertical: 1),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Container(
                      width: 20,
                      height: 2,
                      margin: const EdgeInsets.symmetric(vertical: 1),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dietary Tracker',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Glucose Level vs Meal',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Date: 25th March 2025',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
          ),
          Text(
            'Time: 9:00 PM',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlucoseChart(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 7.0, 12.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTitleSection(),
              CupertinoButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FoodScannerScreen(),
                    ),
                  );
                },
                color: const Color(0xFF0ABAB5),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: const Text(
                  'Scan Food',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 160,
            child: Stack(
              children: [
                LineChart(
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
                          FlSpot(8, 140), // 9 PM
                        ],
                        isCurved: true,
                        color: Colors.red,
                        barWidth: 3,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) {
                            if (index == 8) { // Last point (9 PM)
                              return FlDotCirclePainter(
                                radius: 4,
                                color: Colors.red,
                                strokeWidth: 1.5,
                                strokeColor: Colors.white,
                              );
                            }
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
                    extraLinesData: ExtraLinesData(
                      verticalLines: [
                        VerticalLine(
                          x: 1, // 8 AM - Breakfast
                          color: Colors.amber,
                          strokeWidth: 2,
                          dashArray: [5, 5],
                          label: VerticalLineLabel(
                            show: true,
                            alignment: Alignment.topCenter,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                            labelResolver: (line) => 'Breakfast',
                          ),
                        ),
                        VerticalLine(
                          x: 3, // 12 PM - Lunch
                          color: Colors.amber,
                          strokeWidth: 2,
                          dashArray: [5, 5],
                          label: VerticalLineLabel(
                            show: true,
                            alignment: Alignment.topCenter,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                            labelResolver: (line) => 'Lunch',
                          ),
                        ),
                        VerticalLine(
                          x: 5, // 4 PM - Snack
                          color: Colors.amber,
                          strokeWidth: 2,
                          dashArray: [5, 5],
                          label: VerticalLineLabel(
                            show: true,
                            alignment: Alignment.topCenter,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                            labelResolver: (line) => 'Snack',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLastReading() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircularPercentIndicator(
            radius: 40.0,
            lineWidth: 6.0,
            percent: 0.6,
            center: const Text(
              "60%",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            progressColor: Colors.red,
            backgroundColor: Colors.grey[300]!,
            circularStrokeCap: CircularStrokeCap.round,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Last reading',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.amber[700],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.amber[300],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.circle, size: 5, color: Colors.black),
                    SizedBox(width: 6),
                    Text(
                      'Glucose Level:',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text('120 mg/dL'),
                  ],
                ),
                const SizedBox(height: 6),
                const Row(
                  children: [
                    Icon(Icons.circle, size: 5, color: Colors.black),
                    SizedBox(width: 6),
                    Text(
                      'Last Meal:',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text('Snack at 4PM'),
                  ],
                ),
                const SizedBox(height: 6),
                const Row(
                  children: [
                    Icon(Icons.circle, size: 5, color: Colors.black),
                    SizedBox(width: 6),
                    Text(
                      'Trend:',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text('Slightly Increase'),
                  ],
                ),
                const SizedBox(height: 12),
                CupertinoButton(
                  onPressed: () {},
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: const Text(
                    'Take Dinner with lower Glycemic Index',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedDinner() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recommended Dinner',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 300, // Ensure this height is sufficient
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFoodCard(
                  title: 'Grilled Salmon',
                  imageUrl: 'https://media.canva.com/v2/files/uri:ifs%3A%2F%2FM%2FVAtdQkPXVySIXzJTz-v9CAdbEIuxMNBZSeXg0ODCoj4.jpg?csig=AAAAAAAAAAAAAAAAAAAAAC4K-3k5S_WNOuvy5UbCV-_Ie2HedQ5PoxFyyUUwoQyM&exp=1742878258&signer=media-rpc&token=AAIAAU0AL1ZBdGRRa1BYVnlTSVh6SlR6LXY5Q0FkYkVJdXhNTkJaU2VYZzBPRENvajQuanBnAAAAAAGVy6OzUIrkziH2Etj4EnOJv-rpRtzPWUZQYrKfjtCyZ1R91WJs',
                  benefits: const [
                    'Protein-based meal → Slower glucose rise',
                    'Fiber from vegetables → Better digestion',
                    'Brown rice (low GI) → Better energy without sharp spike',
                  ],
                ),
                const SizedBox(width: 12),
                _buildFoodCard(
                  title: 'Salad',
                  imageUrl: 'https://media.canva.com/v2/files/uri:ifs%3A%2F%2FM%2Fup2yPEs5GsKO1DLJMYzfRee46OYIGKu8c4BpIsGKmrM.jpg?csig=AAAAAAAAAAAAAAAAAAAAAM736mJt8uN3piQBp4eD3ihSYG9oSHL9ULlm2Pw5QGYK&exp=1742879296&signer=media-rpc&token=AAIAAU0AL3VwMnlQRXM1R3NLTzFETEpNWXpmUmVlNDZPWUlHS3U4YzRCcElzR0ttck0uanBnAAAAAAGVy7OKABwW7_4XNe_wPmogCXAmb2PTdOW8ORtMoH14YeVg71U3',
                  benefits: const [
                    'Protein-based meal → Slower glucose rise',
                    'Fiber from vegetables → Better digestion',
                    'Brown rice (low GI) → Better energy without sharp spike',
                  ],
                ),
                const SizedBox(width: 12),
                _buildFoodCard(
                  title: 'Chicken Stir Fry',
                  imageUrl: 'https://th.bing.com/th/id/OIP.vl31rU5tNy4G1PejK9MHHQHaLH?rs=1&pid=ImgDetMain',
                  benefits: const [
                    'Lean protein → Supports muscle growth',
                    'Low in carbs → Helps maintain glucose levels',
                    'Rich in vegetables → Provides essential nutrients',
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCard({
    required String title,
    required String imageUrl,
    required List<String> benefits,
  }) {
    return Container(
      width: 200, // Set a specific width for the card
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.network(
              imageUrl,
              height: 120,
              width: 200, // Set a specific width for the image
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                ...benefits.map((benefit) => Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 10,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              benefit,
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
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
              _buildNavItem(Icons.home, 'Home', false, onTap: () {
                Navigator.pop(context);
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
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
            size: 20,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

