import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'trip_info_page.dart';

class MyTripsPage extends StatefulWidget {
  const MyTripsPage({super.key});
  @override
  State<MyTripsPage> createState() => _MyTripsPageState();
}

class _MyTripsPageState extends State<MyTripsPage> {
  final Color primaryColor = const Color(0xFF2E5339);
  final Color backgroundColor = const Color(0xFFFAF8F5);
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'رحلاتي',
          style: TextStyle(
            color: Color(0xFF2E5339),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF2E5339),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add-trip');
            },
            icon: const Icon(
              Icons.add_circle_outline_rounded,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          // التبويبات
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _tabItem('الكل', 0),
                _tabItem('القادمة', 1),
                _tabItem('النشطة', 2),
                _tabItem('المنتهية', 3),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // تم تغليف StreamBuilder بـ Expanded وتصحيح التنسيق
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('trips').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('حدث خطأ أثناء تحميل البيانات'),
                  );
                }

                final docs = snapshot.data?.docs ?? [];

                List<Map<String, dynamic>> trips = docs
                    .map((doc) => doc.data() as Map<String, dynamic>)
                    .toList();

                if (selectedTab != 0) {
                  final statuses = ['قادمة', 'نشطة', 'منتهية'];
                  trips = trips
                      .where(
                          (trip) => trip['status'] == statuses[selectedTab - 1])
                      .toList();
                }

                if (trips.isEmpty) {
                  return const Center(
                    child: Text('لا توجد رحلات هنا'),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  itemCount: trips.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    return _tripCard(trips[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabItem(String title, int index) {
    final bool isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade300,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _tripCard(Map<String, dynamic> trip) {
    final String status = trip['status'] ?? '';
    Color statusColor;
    if (status == 'قادمة') {
      statusColor = const Color(0xFF2E5339);
    } else if (status == 'نشطة') {
      statusColor = const Color(0xFF1976A8);
    } else {
      statusColor = const Color(0xFFC63828);
    }
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TripInfoPage(
              trip: trip,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.luggage_outlined,
                  color: Color(0xFF2E5339),
                  size: 28,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              trip['name'] ?? '',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E5339),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  trip['date'] ?? '',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 18),
                Text(
                  '${trip['members'] ?? 0} معتمرين',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.people_outline,
                  size: 17,
                  color: Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'عرض تفاصيل الرحلة',
                  style: TextStyle(
                    color: Color(0xFF2E5339),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                SizedBox(width: 6),
                Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 13,
                  color: Color(0xFF2E5339),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
