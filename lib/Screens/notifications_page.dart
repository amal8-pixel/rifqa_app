import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

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

        // ================= APP BAR =================
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'الإشعارات',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),

        // ================= BODY =================
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          children: [
            const Text(
              'آخر التحديثات',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            _notificationItem(
              icon: Icons.location_on_outlined,
              title: 'تذكير بنقطة التجمع',
              message: 'نقطة تجمع الرحلة عند بوابة الملك فهد.',
            ),
            _notificationItem(
              icon: Icons.person_add_alt_1_outlined,
              title: 'تمت إضافة معتمر',
              message: 'تمت إضافة نورة خالد إلى الرحلة.',
            ),
            _notificationItem(
              icon: Icons.access_time_rounded,
              title: 'تذكير بالرحلة',
              message: 'رحلتك القادمة تقترب، تأكد من استعدادك.',
            ),
          ],
        ),
      ),
    );
  }

  // ================= NOTIFICATION CARD =================
  Widget _notificationItem({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.06),
        ),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ================= TEXT - RIGHT =================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  message,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 14),

          // ================= ICON - LEFT =================
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: accentColor,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
