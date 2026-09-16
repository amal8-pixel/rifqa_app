import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFFAF8F5),
        appBar: AppBar(
          backgroundColor: Color(0xFFFAF8F5),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'الاشعارات',
            style: TextStyle(
              color: Color(0xFF2E5339),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _notificationItem(
                icon: Icons.location_on_outlined,
                title: 'تذكير بنقطة التجمع',
                message: 'نقطة تجمع الرحلة عند بوابة الملك فهد.'),
            _notificationItem(
                icon: Icons.person_add_alt_1_outlined,
                title: 'تمت إضافة معتمر',
                message: 'تمت إضافة نورة خالد إلى الرحلة.'),
            _notificationItem(
                icon: Icons.access_time,
                title: 'تذكير بالرحلة',
                message: 'رحلتك القادمة تقترب، تأكد من استعدادك.'),
          ],
        ),
      ),
    );
  }

  Widget _notificationItem({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE4EBDD),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF2E5339),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E5339),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  message,
                  style: const TextStyle(
                    color: Color(0xFF4F5F57),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
