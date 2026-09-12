import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class TripDetailsPage extends StatefulWidget {
  final String tripName;

  TripDetailsPage({
    super.key,
    required this.tripName,
  });
  @override
  State<TripDetailsPage> createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition();

    print(
      'Latitude: ${position.latitude}, Longitude: ${position.longitude}',
    );
  }

  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF8F5),
        appBar: AppBar(
          backgroundColor: const Color(0xFF2E5339),
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'تفاصيل الرحلة',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          //padding: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // اسم الرحلة
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Color(0xFFE4EBDD),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.tripName,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E5339),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.mosque_outlined,
                            size: 30,
                            color: Color(0xFF2E5339),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'رفيقك في رحلة العمرة',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF4F5F57),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // معلومات الرحلة
              Text(
                'معلومات الرحلة',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E5339),
                ),
              ),

              const SizedBox(height: 15),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _infoRow(
                      icon: Icons.calendar_today_outlined,
                      title: 'التاريخ',
                      value: '15 رمضان 1447',
                    ),
                    const Divider(height: 28),
                    _infoRow(
                      icon: Icons.location_on_outlined,
                      title: 'الوجهة',
                      value: 'مكة المكرمة',
                    ),
                    const Divider(height: 28),
                    _infoRow(
                      icon: Icons.people_outline,
                      title: 'عدد المعتمرين',
                      value: '12 معتمر',
                    ),
                    const Divider(height: 28),
                    _infoRow(
                      icon: Icons.hotel_outlined,
                      title: 'الفندق',
                      value: 'فندق دار التوحيد',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // نقطة التجمع
              const Text(
                'نقطة التجمع',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E5339),
                ),
              ),

              const SizedBox(height: 15),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE4EBDD),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.place_outlined,
                        color: Color(0xFF2E5339),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'بوابة الملك فهد',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E5339),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'نقطة تجمع أفراد الرحلة',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF4F5F57),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // المعتمرون
              const Text(
                'المعتمرون',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E5339),
                ),
              ),

              const SizedBox(height: 15),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _personRow(
                      name: 'أحمد محمد',
                      icon: Icons.person_outline,
                    ),
                    const Divider(height: 25),
                    _personRow(
                      name: 'سارة أحمد',
                      icon: Icons.person_outline,
                    ),
                    const Divider(height: 25),
                    _personRow(
                      name: 'محمد عبدالله',
                      icon: Icons.person_outline,
                    ),
                    const Divider(height: 25),
                    _personRow(
                      name: 'نورة خالد',
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '+ اضافة معتمرين آخرين',
                      style: TextStyle(
                        color: Color(0xFF2E5339),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // مشاركة الموقع
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E5339),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.location_searching,
                      color: Colors.white,
                      size: 35,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'هل تفرّق أحد أفراد الرحلة؟',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'شارك موقعك ليسهل على رفاقك الوصول إليك.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await getLocation();
                        },
                        icon: const Icon(
                          Icons.location_on_outlined,
                        ),
                        label: const Text(
                          'مشاركة موقعي',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF2E5339),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // معلومات الرحلة
  static Widget _infoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFE4EBDD),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF2E5339),
            size: 22,
          ),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E5339),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // أسماء المعتمرين
  static Widget _personRow({
    required String name,
    required IconData icon,
  }) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 21,
          backgroundColor: Color(0xFFE4EBDD),
          child: Icon(
            Icons.person_outline,
            color: Color(0xFF2E5339),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E5339),
          ),
        ),
      ],
    );
  }
}
