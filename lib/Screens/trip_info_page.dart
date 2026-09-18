import 'package:flutter/material.dart';

class TripInfoPage extends StatelessWidget {
  final Map<String, dynamic> trip;
  const TripInfoPage({
    super.key,
    required this.trip,
  });
  static const Color backgroundColor = Color(0xFF0B1220);
  static const Color cardColor = Color(0xFF17243A);
  static const Color primaryColor = Color(0xFF214E78);
  static const Color accentColor = Color(0xFF5C9BD1);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text(
            'معلومات الرحلة',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          children: [
            // بطاقة الرحلة الرئيسية
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF214E78),
                    Color(0xFF10253F),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.luggage_outlined,
                      color: accentColor,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          trip['name'] ?? '',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          'رحلتك القادمة',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'تفاصيل الرحلة',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 14),

            _infoCard(
              icon: Icons.mosque_outlined,
              title: 'نوع الرحلة',
              value: trip['type'] ?? '',
            ),

            _infoCard(
              icon: Icons.calendar_today_outlined,
              title: 'تاريخ الرحلة',
              // تم تصحيح data إلى date
              value: trip['date'] ?? '',
            ),

            _infoCard(
              icon: Icons.hotel_outlined,
              title: 'مكان الإقامة',
              value: trip['hotel'] ?? '',
            ),

            _infoCard(
              icon: Icons.people_outline_rounded,
              title: 'عدد أفراد الرحلة',
              value: '${trip['members'] ?? 0} معتمرين',
            ),

            _infoCard(
              icon: Icons.person_outline_rounded,
              title: 'قائد الرحلة',
              value: trip['leader'] ?? '',
            ),

            const SizedBox(height: 6),

            // حالة الرحلة
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.07),
                ),
              ),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.check_circle_outline_rounded,
                      color: accentColor,
                      size: 27,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'حالة الرحلة',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          trip['status'] ?? '',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  _statusBadge(trip['status'] ?? ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.07),
        ),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          // الأيقونة على اليمين Container( width: 48, height: 48, decoration: BoxDecoration( color: accentColor.withOpacity(0.10), borderRadius: BorderRadius.circular(15), ), child: Icon( icon, color: accentColor, size: 23, ), ),
          const SizedBox(width: 14),

          // المعلومات
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _statusBadge(String status) {
    Color color;
    if (status == 'نشطة') {
      color = const Color(0xFF4FC3F7);
    } else if (status == 'منتهية') {
      color = const Color(0xFF90A4AE);
    } else {
      color = accentColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.20),
        ),
      ),
      child: Text(
        status.isEmpty ? 'غير محدد' : status,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
