import 'package:flutter/material.dart';
import 'trip_datails.dart';

class HomePage extends StatelessWidget {
  final String tripName;

  const HomePage({
    super.key,
    required this.tripName,
  });

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 360;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF8F5),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFAF8F5),
          elevation: 0,
          title: const Text(
            'رحلاتي',
            style: TextStyle(
              color: Color(0xFF2E5339),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'أهلًا بك في رفقة 👋',
                style: TextStyle(
                  fontSize: isSmall ? 22 : 25,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2E5339),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'رحلاتك في الحرمين، أقرب وأسهل.',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF4F5F57),
                ),
              ),
              const SizedBox(height: 25),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE4EBDD),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tripName,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E5339),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '12 من المعتمرين',
                      style: TextStyle(
                        color: Color(0xFF4F5F57),
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TripDetailsPage(
                                tripName: tripName,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E5339),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'عرض تفاصيل الرحلة',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/add-trip',
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Color(0xFF2E5339),
                  ),
                  label: const Text(
                    'إضافة رحلة جديدة',
                    style: TextStyle(
                      color: Color(0xFF2E5339),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    side: const BorderSide(
                      color: Color(0xFF2E5339),
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
      ),
    );
  }
}
