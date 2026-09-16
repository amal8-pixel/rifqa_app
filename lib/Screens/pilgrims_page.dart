import 'package:flutter/material.dart';

class PilgrimsPage extends StatelessWidget {
  const PilgrimsPage({super.key});

  final Color primaryColor = const Color(0xFF2E5339);
  final Color backgroundColor = const Color(0xFFFAF8F5);

  // =========================
  // إضافة معتمر
  // =========================
  void _showAddPilgrimDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'إضافة معتمر',
            textAlign: TextAlign.right,
          ),
          content: TextField(
            controller: controller,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            decoration: const InputDecoration(
              hintText: 'اسم المعتمر',
              hintTextDirection: TextDirection.rtl,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'إلغاء',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'تمت إضافة المعتمر بنجاح',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              child: const Text(
                'إضافة',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // بيانات تجريبية مؤقتة
    final List<Map<String, dynamic>> pilgrims = [
      {
        'name': 'أحمد محمد',
        'role': 'قائد الرحلة',
        'isOnline': true,
        'initial': 'أ',
      },
      {
        'name': 'سارة علي',
        'role': 'معتمرة',
        'isOnline': true,
        'initial': 'س',
      },
      {
        'name': 'محمد خالد',
        'role': 'معتمر',
        'isOnline': false,
        'initial': 'م',
      },
      {
        'name': 'نورة عبدالله',
        'role': 'معتمرة',
        'isOnline': true,
        'initial': 'ن',
      },
      {
        'name': 'خالد سعيد',
        'role': 'معتمر',
        'isOnline': false,
        'initial': 'خ',
      },
      {
        'name': 'ريم فهد',
        'role': 'معتمرة',
        'isOnline': true,
        'initial': 'ر',
      },
      {
        'name': 'عبدالله حسن',
        'role': 'معتمر',
        'isOnline': true,
        'initial': 'ع',
      },
    ];

    return Scaffold(
      backgroundColor: backgroundColor,

      // =========================
      // App Bar
      // =========================
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'المعتمرون',
          style: TextStyle(
            color: Color(0xFF2E5339),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF2E5339),
            size: 20,
          ),
        ),
      ),

      // =========================
      // Body
      // =========================
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            20,
            10,
            20,
            30,
          ),
          children: [
            // =========================
            // معلومات الرحلة
            // =========================
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF416E51),
                    Color(0xFF2E5339),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  // عدد المعتمرين
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.people_outline_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 15),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'عمرة رمضان 1448',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          '7 معتمرين في الرحلة',
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

            // =========================
            // عنوان القائمة
            // =========================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'أفراد الرحلة',
                  style: TextStyle(
                    color: Color(0xFF2E5339),
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${pilgrims.length} أشخاص',
                  style: TextStyle(
                    color: primaryColor.withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // =========================
            // قائمة المعتمرين
            // =========================
            ...pilgrims.map(
              (pilgrim) => _pilgrimCard(
                context: context,
                name: pilgrim['name'],
                role: pilgrim['role'],
                isOnline: pilgrim['isOnline'],
                initial: pilgrim['initial'],
              ),
            ),

            const SizedBox(height: 12),

            // =========================
            // إضافة معتمر
            // =========================
            InkWell(
              onTap: () {
                _showAddPilgrimDialog(context);
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: primaryColor.withOpacity(0.15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_add_alt_1_rounded,
                      color: primaryColor,
                      size: 21,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'إضافة معتمر',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
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

  // =========================
  // بطاقة المعتمر
  // =========================
  Widget _pilgrimCard({
    required BuildContext context,
    required String name,
    required String role,
    required bool isOnline,
    required String initial,
  }) {
    return InkWell(
      onTap: () {
        _showPilgrimInfo(
          context,
          name,
          role,
          isOnline,
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
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
            // =========================
            // الصورة / الحرف
            // =========================
            Stack(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    initial,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // حالة الاتصال
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: Container(
                    width: 13,
                    height: 13,
                    decoration: BoxDecoration(
                      color: isOnline ? Colors.green : Colors.grey.shade400,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 14),

            // =========================
            // الاسم
            // =========================
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    role,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // =========================
            // الحالة
            // =========================
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  isOnline ? 'متصل' : 'غير متصل',
                  style: TextStyle(
                    color:
                        isOnline ? Colors.green.shade700 : Colors.grey.shade500,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFF2E5339),
                  size: 13,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // معلومات المعتمر
  // =========================
  void _showPilgrimInfo(
    BuildContext context,
    String name,
    String role,
    bool isOnline,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Color(0xFFFAF8F5),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // مؤشر السحب
              Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 25),

              // صورة المعتمر
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    name.isNotEmpty ? name.substring(0, 1) : '?',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // الاسم
              Text(
                name,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              // الوظيفة
              Text(
                role,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 15),

              // حالة الاتصال
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isOnline
                      ? Colors.green.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isOnline ? '● متصل الآن' : '● غير متصل',
                  style: TextStyle(
                    color:
                        isOnline ? Colors.green.shade700 : Colors.grey.shade600,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // زر التواصل
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.phone_outlined,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'التواصل',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
