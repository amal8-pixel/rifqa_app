import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PilgrimsPage extends StatefulWidget {
  const PilgrimsPage({super.key});

  @override
  State<PilgrimsPage> createState() => _PilgrimsPageState();
}

class _PilgrimsPageState extends State<PilgrimsPage> {
  static const Color backgroundColor = Color(0xFF0B1220);
  static const Color cardColor = Color(0xFF17243A);
  static const Color primaryColor = Color(0xFF214E78);
  static const Color accentColor = Color(0xFF5C9BD1);

  // قائمة المعتمرين
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

  // =========================
  // إضافة معتمر
  // =========================
  void _showAddPilgrimDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            title: const Text(
              'إضافة معتمر',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: TextField(
              controller: controller,
              autofocus: true,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white,
              ),
              cursorColor: accentColor,
              decoration: InputDecoration(
                hintText: 'اسم المعتمر',
                hintTextDirection: TextDirection.rtl,
                hintStyle: const TextStyle(
                  color: Colors.white38,
                ),
                filled: true,
                fillColor: backgroundColor,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Colors.white.withOpacity(0.06),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: accentColor,
                  ),
                ),
              ),
            ),
            actionsPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text(
                  'إلغاء',
                  style: TextStyle(
                    color: Colors.white54,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final name = controller.text.trim();

                  if (name.isEmpty) return;

                  // حفظ المعتمر في Firestore
                  await FirebaseFirestore.instance.collection('pilgrims').add({
                    'name': name,
                    'role': 'معتمر',
                    'isOnline': false,
                    'initial': name.characters.first,
                    'createdAt': Timestamp.now(),
                  });

                  // التحديث المحلي للقائمة
                  setState(() {
                    pilgrims.add({
                      'name': name,
                      'role': 'معتمر',
                      'isOnline': false,
                      'initial': name.characters.first,
                    });
                  });

                  if (!mounted) return;

                  // إغلاق النافذة المنبثقة
                  Navigator.pop(dialogContext);

                  // إظهار رسالة التأكيد
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'تمت إضافة $name بنجاح',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'إضافة',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'المعتمرون',
            style: TextStyle(
              color: Colors.white,
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
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
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
                ),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'عمرة رمضان 1448',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${pilgrims.length} معتمرين في الرحلة',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.people_outline_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  const Expanded(
                    child: Text(
                      'أفراد الرحلة',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${pilgrims.length} أشخاص',
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ...pilgrims.map(
                (pilgrim) => _pilgrimCard(
                  context: context,
                  name: pilgrim['name'],
                  role: pilgrim['role'],
                  isOnline: pilgrim['isOnline'],
                  initial: pilgrim['initial'],
                ),
              ),
              const SizedBox(height: 8),
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
                    color: primaryColor.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: accentColor.withOpacity(0.25),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_add_alt_1_rounded,
                        color: accentColor,
                        size: 21,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'إضافة معتمر',
                        style: TextStyle(
                          color: accentColor,
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
      ),
    );
  }

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
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.06),
          ),
        ),
        child: Row(
          textDirection: TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isOnline ? 'متصل' : 'غير متصل',
                  style: TextStyle(
                    color: isOnline ? const Color(0xFF4FC3F7) : Colors.white38,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 7),
                const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white38,
                  size: 13,
                ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      name,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      role,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 14),
            Stack(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    initial,
                    style: const TextStyle(
                      color: accentColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: Container(
                    width: 13,
                    height: 13,
                    decoration: BoxDecoration(
                      color:
                          isOnline ? const Color(0xFF4FC3F7) : Colors.white24,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: cardColor,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    name.isNotEmpty ? name.characters.first : '?',
                    style: const TextStyle(
                      color: accentColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  role,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isOnline
                        ? const Color(0xFF4FC3F7).withOpacity(0.10)
                        : Colors.white.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isOnline ? '● متصل الآن' : '● غير متصل',
                    style: TextStyle(
                      color:
                          isOnline ? const Color(0xFF4FC3F7) : Colors.white54,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 22),
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
          ),
        );
      },
    );
  }
}
