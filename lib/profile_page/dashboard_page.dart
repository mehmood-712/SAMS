import 'package:flutter/material.dart';
import 'attendance_page.dart';
import 'reports_page.dart';
import 'schedule_page.dart';
import '../login_page/login_page.dart';
import 'profile_page.dart';

class DashboardPage extends StatelessWidget {
  final String name;
  final String email;
  final String role;

  const DashboardPage({
    super.key,
    required this.name,
    required this.email,
    required this.role,
  });

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final double gridMaxWidth = isSmallScreen ? double.infinity : 400;
    final double cardSize = isSmallScreen ? 120 : 100;
    final double iconSize = isSmallScreen ? 40 : 32;
    final double fontSize = isSmallScreen ? 18 : 16;
    final double cardPadding = isSmallScreen ? 12 : 8;
    final double spacing = isSmallScreen ? 16 : 12;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          "Dashboard",
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF334155), Color(0xFF1E293B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.logout_rounded),
              onPressed: () => _logout(context),
              tooltip: "Logout",
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            // Modern Welcome Banner Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.25),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.waving_hand_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome, $name!",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          email,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.85),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade800,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: gridMaxWidth),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  childAspectRatio: 1.05,
                  children: [
                    _buildDashboardCard(
                      icon: Icons.person_rounded,
                      title: "Profile",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ProfilePage(
                                  name: name,
                                  email: email,
                                  password: "********",
                                ),
                          ),
                        );
                      },
                      cardSize: cardSize,
                      iconSize: iconSize,
                      fontSize: fontSize,
                      cardPadding: cardPadding,
                    ),
                    _buildDashboardCard(
                      icon: Icons.check_circle_rounded,
                      title: "Attendance",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AttendancePage(),
                          ),
                        );
                      },
                      cardSize: cardSize,
                      iconSize: iconSize,
                      fontSize: fontSize,
                      cardPadding: cardPadding,
                    ),
                    _buildDashboardCard(
                      icon: Icons.calendar_month_rounded,
                      title: "Schedule",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SchedulePage(),
                          ),
                        );
                      },
                      cardSize: cardSize,
                      iconSize: iconSize,
                      fontSize: fontSize,
                      cardPadding: cardPadding,
                    ),
                    _buildDashboardCard(
                      icon: Icons.analytics_rounded,
                      title: "Reports",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AttendanceReportPage(),
                          ),
                        );
                      },
                      cardSize: cardSize,
                      iconSize: iconSize,
                      fontSize: fontSize,
                      cardPadding: cardPadding,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required double cardSize,
    required double iconSize,
    required double fontSize,
    required double cardPadding,
  }) {
    return SizedBox(
      width: cardSize,
      height: cardSize,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: EdgeInsets.all(cardPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(icon, size: iconSize, color: Colors.blueGrey),
                SizedBox(height: cardPadding / 2),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
