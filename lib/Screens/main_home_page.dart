import 'package:flutter/material.dart';

import 'rafqa_ai_page.dart';
import 'pilgrims_page.dart';
import 'meeting_point_page.dart';
import 'my_trips_page.dart';
import 'trip_tasks_page.dart';
import 'trip_info_page.dart';
import 'notifications_page.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int selectedIndex = 0;

  final Color primaryColor = const Color(0xFF2E5339);
  final Color backgroundColor = const Color(0xFFFAF8F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      // =========================
      // الصفحة الرئيسية
      // =========================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================
              // Header
              // =========================
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person_outline_rounded,
                      color: primaryColor,
                      size: 25,
                    ),
                  ),

                  const SizedBox(width: 10),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'أهلًا بك 👋',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'أمل',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E5339),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: primaryColor,
                        size: 19,
                      ),
                      const SizedBox(width: 3),
                      const Text(
                        'مكة المكرمة',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2E5339),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 8),

                  // زر الإشعارات
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.notifications_rounded,
                        color: primaryColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationsPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // =========================
              // Hero
              // =========================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFF416E51),
                      Color(0xFF2E5339),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Text(
                            'رحلتك القادمة بعد 5 أيام',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const Text(
                          'رفقة',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    const Text(
                      'عمرة رمضان 1448',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'رفيق رحلتك في الحرمين',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // =========================
                    // الصلاة + الطقس
                    // =========================
                    Row(
                      children: [
                        Expanded(
                          child: _heroInfo(
                            icon: Icons.access_time_rounded,
                            title: 'الصلاة القادمة',
                            value: 'العصر · 3:45 م',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _heroInfo(
                            icon: Icons.wb_sunny_outlined,
                            title: 'الطقس',
                            value: '39° · مشمس',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // =========================
                    // الذكر
                    // =========================
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 11,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Text(
                        '( وَقُل رَّبِّ زِدْنِي عِلْمًا )',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // =========================
              // أدوات الرحلة
              // =========================
              const Text(
                'أدوات الرحلة',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E5339),
                ),
              ),

              const SizedBox(height: 14),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
                children: [
                  // المعتمرون
                  _wideHomeCard(
                    icon: Icons.people_outline_rounded,
                    title: 'المعتمرون',
                    subtitle: 'قائمة المعتمرين',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PilgrimsPage(),
                        ),
                      );
                    },
                  ),

                  // رحلاتي
                  _wideHomeCard(
                    icon: Icons.luggage_outlined,
                    title: 'رحلاتي',
                    subtitle: 'عرض رحلاتك',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyTripsPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // =========================
              // نقطة التجمع
              // =========================
              _wideHomeCard(
                icon: Icons.place_outlined,
                title: 'نقطة التجمع',
                subtitle: 'فندق أبراج الصفوة · 8:00 مساء',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MeetingPointPage(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // =========================
              // خدمات الرحلة
              // =========================
              const Text(
                'خدمات رحلتك',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E5339),
                ),
              ),

              const SizedBox(height: 12),

              // مهام الرحلة
              _serviceCard(
                icon: Icons.checklist_rounded,
                title: 'مهام الرحلة',
                subtitle: 'تابع ما تم إنجازه وما تبقى',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TripTasksPage(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              // معلومات الرحلة
              _serviceCard(
                icon: Icons.info_outline_rounded,
                title: 'معلومات الرحلة',
                subtitle: 'تفاصيل رحلتك ومواعيدها',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TripInfoPage(
                        trip: {
                          'name': 'عمرة رمضان 1448',
                          'type': 'عمرة',
                          'data': '15 رمضان 1448',
                          'members': '7',
                          'status': 'قادمة',
                        },
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // =========================
      // مساعد رفقة
      // =========================
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        elevation: 5,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RafqaAIPage(),
            ),
          );
        },
        child: const Icon(
          Icons.smart_toy_outlined,
          color: Colors.white,
          size: 27,
        ),
      ),

      // =========================
      // Bottom Navigation
      // =========================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          // الرئيسية
          if (index == 0) {
            setState(() {
              selectedIndex = 0;
            });
          }

          // رحلاتي
          else if (index == 1) {
            setState(() {
              selectedIndex = 1;
            });

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyTripsPage(),
              ),
            );
          }

          // الإشعارات
          else if (index == 2) {
            setState(() {
              selectedIndex = 2;
            });

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationsPage(),
              ),
            );
          }

          // ملفي
          else if (index == 3) {
            setState(() {
              selectedIndex = 3;
            });

            // مؤقتًا حتى تضيف ProfilePage
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'صفحة الملف الشخصي قيد التطوير',
                  textAlign: TextAlign.right,
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.luggage_outlined),
            activeIcon: Icon(Icons.luggage_rounded),
            label: 'رحلاتي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_rounded),
            activeIcon: Icon(Icons.notifications_rounded),
            label: 'الإشعارات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_rounded),
            label: 'ملفي',
          ),
        ],
      ),
    );
  }

  // =========================
  // Hero Info
  // =========================
  Widget _heroInfo({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 21,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // بطاقات أدوات الرحلة
  // =========================
  Widget _wideHomeCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF2E5339),
              size: 18,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Color(0xFF2E5339),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF2E5339).withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF2E5339),
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // بطاقات الخدمات
  // =========================
  Widget _serviceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                color: primaryColor,
                size: 26,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
