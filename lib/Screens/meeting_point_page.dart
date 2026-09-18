import 'package:flutter/material.dart';

class MeetingPointPage extends StatelessWidget {
  const MeetingPointPage({super.key});

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
            'نقطة التجمع',
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ================= HERO =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
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
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white10,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.location_on_rounded,
                            color: accentColor,
                            size: 25,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'عمرة رمضان 1448',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'نقطة التجمع',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'تأكد من الوصول في الموعد المحدد',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ================= SECTION TITLE =================
              const Text(
                'موقع التجمع',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              // ================= MAP =================
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white10,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF172D45),
                              Color(0xFF101C2E),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.map_outlined,
                            size: 80,
                            color: Color(0xFF315577),
                          ),
                        ),
                      ),
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: accentColor.withOpacity(0.10),
                        ),
                      ),
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: accentColor.withOpacity(0.15),
                        ),
                      ),
                      const Icon(
                        Icons.location_on_rounded,
                        size: 52,
                        color: accentColor,
                      ),
                      Positioned(
                        top: 14,
                        right: 14,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.my_location_rounded,
                                size: 14,
                                color: accentColor,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'نقطة التجمع',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ================= LOCATION CARD =================
              _infoCard(
                icon: Icons.location_on_outlined,
                title: 'مكان التجمع',
                value: 'فندق أبراج الصفوة',
                subtitle: 'مكة المكرمة · أمام مدخل الفندق',
              ),

              const SizedBox(height: 12),

              // ================= TIME CARD =================
              _infoCard(
                icon: Icons.access_time_rounded,
                title: 'وقت التجمع',
                value: '8:00 مساءً',
                subtitle: 'يفضل الوصول قبل الموعد بـ 15 دقيقة',
              ),

              const SizedBox(height: 24),

              // ================= BUTTON =================
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: cardColor,
                        content: Text(
                          'سيتم فتح الموقع على الخريطة',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.navigation_rounded,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'فتح الموقع',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // ================= NOTE =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white10,
                  ),
                ),
                child: const Row(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'يرجى الحضور قبل موعد التجمع بـ 15 دقيقة.',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.info_outline_rounded,
                      color: accentColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= INFO CARD =================
  static Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white10,
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
                    color: Colors.white54,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
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
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
