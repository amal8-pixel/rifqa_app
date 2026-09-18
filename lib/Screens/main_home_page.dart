import 'dart:async';

import 'package:flutter/material.dart';
import '../models/prayer_model.dart';

import 'rafqa_ai_page.dart';
import 'pilgrims_page.dart';
import 'meeting_point_page.dart';
import 'my_trips_page.dart';
import 'trip_tasks_page.dart';
import 'trip_info_page.dart';
import 'notifications_page.dart';

import '../services/prayer_service.dart';
import '../services/weather_service.dart';

class MainHomePage extends StatefulWidget {
  final Function(bool) onThemeChanged;

  const MainHomePage({
    super.key,
    required this.onThemeChanged,
  });

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int selectedIndex = 0;

  Future<PrayerModel>? prayerTimes;
  Future<Map<String, dynamic>>? weatherData;

  Timer? prayerTimer;

  // =========================
  // ألوان الهوية
  // =========================

  static const Color backgroundColor = Color(0xFF0B1220);
  static const Color navyColor = Color(0xFF101C33);
  static const Color blueColor = Color(0xFF173A5E);
  static const Color lightBlue = Color(0xFF5C9BD1);

  @override
  void initState() {
    super.initState();

    prayerTimes = PrayerService.getPrayerTimes();
    weatherData = WeatherService.getWeather();

    prayerTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    prayerTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      // =========================
      // الصفحة
      // =========================

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================
              // HEADER
              // =========================

              Row(
                children: [
                  // صورة المستخدم
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.07),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),

                  const SizedBox(width: 11),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'أهلًا بك 👋',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'أمل',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // الموقع
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: lightBlue,
                        size: 17,
                      ),
                      const SizedBox(width: 3),
                      const Text(
                        'مكة المكرمة',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 9),

                  // زر الإشعارات
                  _headerButton(
                    icon: Icons.notifications_none_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationsPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // =========================
              // MAIN RAFQA CARD
              // =========================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(19),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFF214E78),
                      Color(0xFF10253F),
                      Color(0xFF0D182B),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.08),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 25,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // اسم رفقة
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.06),
                            ),
                          ),
                          child: const Text(
                            'رحلتك القادمة بعد 5 أيام',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const Text(
                          'رِفقة',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'عمرة رمضان 1448',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      'رفيق رحلتك في الحرمين',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 19),

                    // =========================
                    // الصلاة والطقس
                    // =========================

                    Row(
                      children: [
                        // مواقيت الصلاة
                        Expanded(
                          child: _heroInfo(
                            icon: Icons.access_time_rounded,
                            title: 'مواقيت الصلاة',
                            child: FutureBuilder<PrayerModel>(
                              future: prayerTimes,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Text(
                                    'جاري التحميل...',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  );
                                }

                                final prayer = snapshot.data!;

                                final nextPrayerTime = prayer.dateTime;

                                final remaining = nextPrayerTime.difference(
                                  DateTime.now(),
                                );

                                final safeRemaining = remaining.isNegative
                                    ? Duration.zero
                                    : remaining;

                                final hours = safeRemaining.inHours
                                    .toString()
                                    .padLeft(2, '0');

                                final minutes = (safeRemaining.inMinutes % 60)
                                    .toString()
                                    .padLeft(2, '0');

                                final seconds = (safeRemaining.inSeconds % 60)
                                    .toString()
                                    .padLeft(2, '0');

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${prayer.name} · ${prayer.time}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '$hours:$minutes:$seconds',
                                      style: const TextStyle(
                                        color: lightBlue,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        // الطقس
                        Expanded(
                          child: _heroInfo(
                            icon: Icons.wb_sunny_outlined,
                            title: 'الطقس',
                            child: FutureBuilder<Map<String, dynamic>>(
                              future: weatherData,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Text(
                                    'جاري التحميل...',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  );
                                }

                                final weather = snapshot.data!;

                                return Text(
                                  '${weather['temp']}° · ${weather['condition']}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // =========================
                    // الذكر
                    // =========================

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.07),
                        ),
                      ),
                      child: const Text(
                        '( وَقُل رَّبِّ زِدْنِي عِلْمًا )',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
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

              _sectionTitle('أدوات الرحلة'),

              const SizedBox(height: 13),

              Row(
                children: [
                  Expanded(
                    child: _toolCard(
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
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _toolCard(
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
                  ),
                ],
              ),

              const SizedBox(height: 13),

              // =========================
              // نقطة التجمع
              // =========================

              _meetingCard(),

              const SizedBox(height: 28),

              // =========================
              // الخدمات
              // =========================

              _sectionTitle('خدمات رحلتك'),

              const SizedBox(height: 13),

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

              const SizedBox(height: 11),

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
            ],
          ),
        ),
      ),

      // =========================
      // مساعد رفقة
      // =========================

      floatingActionButton: FloatingActionButton(
        backgroundColor: blueColor,
        elevation: 8,
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
          size: 26,
        ),
      ),

      // =========================
      // Bottom Navigation
      // =========================

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0D1728),
          border: Border(
            top: BorderSide(
              color: Colors.white.withOpacity(0.06),
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: selectedIndex,
          onTap: (index) {
            if (index == 0) {
              setState(() {
                selectedIndex = 0;
              });
            } else if (index == 1) {
              setState(() {
                selectedIndex = 1;
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyTripsPage(),
                ),
              );
            } else if (index == 2) {
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
          },
          selectedItemColor: lightBlue,
          unselectedItemColor: Colors.white38,
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
          ],
        ),
      ),
    );
  }

  // =========================
  // Header Button
  // =========================

  Widget _headerButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 43,
        height: 43,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.07),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.white.withOpacity(0.07),
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 21,
        ),
      ),
    );
  }

  // =========================
  // Section Title
  // =========================

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 19,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // =========================
  // Hero Info
  // =========================

  Widget _heroInfo({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      height: 112,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: Colors.white.withOpacity(0.07),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            icon,
            color: lightBlue,
            size: 21,
          ),
          const SizedBox(height: 7),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 4),
          child,
        ],
      ),
    );
  }

  // =========================
  // Tools Card
  // =========================

  Widget _toolCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 125,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.055),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.07),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: lightBlue.withOpacity(0.13),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                icon,
                color: lightBlue,
                size: 23,
              ),
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // Meeting Point
  // =========================

  Widget _meetingCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MeetingPointPage(),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              blueColor.withOpacity(0.8),
              navyColor,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.07),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 47,
              height: 47,
              decoration: BoxDecoration(
                color: lightBlue.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.location_on_outlined,
                color: lightBlue,
                size: 24,
              ),
            ),
            const SizedBox(width: 13),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'نقطة التجمع',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'فندق أبراج الصفوة · 8:00 مساء',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white54,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // Service Card
  // =========================

  Widget _serviceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(19),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.055),
          borderRadius: BorderRadius.circular(19),
          border: Border.all(
            color: Colors.white.withOpacity(0.07),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white38,
              size: 14,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: lightBlue.withOpacity(0.10),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: lightBlue,
                size: 23,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
