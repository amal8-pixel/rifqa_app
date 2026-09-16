import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTripPage extends StatefulWidget {
  const AddTripPage({super.key});
  @override
  State<AddTripPage> createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  final TextEditingController tripNameController = TextEditingController();
  final TextEditingController hotelController = TextEditingController();
  String selectedTripType = 'عمرة';
  int membersCount = 7;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF8F5),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFAF8F5),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'إنشاء رحلة جديدة',
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
              const Text(
                'أنشئ رحلتك',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E5339),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'أدخل تفاصيل الرحلة لتنظيمها بسهولة.',
                style: TextStyle(
                  color: Color(0xFF4F5F57),
                ),
              ),

              const SizedBox(height: 25),

              // اسم الرحلة
              const Text(
                'اسم الرحلة',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E5339),
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: tripNameController,
                decoration: InputDecoration(
                  hintText: 'مثال: عمرة رمضان مع العائلة',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // نوع الرحلة
              const Text(
                'نوع الرحلة',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E5339),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _tripTypeCard(
                      title: 'حج',
                      icon: Icons.mosque_outlined,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _tripTypeCard(
                      title: 'مدينة',
                      icon: Icons.location_city_outlined,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _tripTypeCard(
                      title: 'عمرة',
                      icon: Icons.mosque,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // عدد الأعضاء
              const Text(
                'عدد الأعضاء',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E5339),
                ),
              ),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (membersCount > 1) {
                          setState(() {
                            membersCount--;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: Color(0xFF2E5339),
                      ),
                    ),
                    Text(
                      '$membersCount',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E5339),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          membersCount++;
                        });
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Color(0xFF2E5339),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // اسم الفندق
              const Text(
                'اسم الفندق',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E5339),
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: hotelController,
                decoration: InputDecoration(
                  hintText: 'مثال: فندق دار التوحيد',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // إنشاء الرحلة
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (tripNameController.text.isNotEmpty) {
                      try {
                        await FirebaseFirestore.instance
                            .collection('trips')
                            .add({
                          'type': selectedTripType,
                          'date': '15 رمضان 1448',
                          'members': membersCount,
                          'status': 'قادمة',
                          'hotel': hotelController.text.trim(),
                          'leader': 'أحمد محمد',
                        });
                        if (!context.mounted) return;

                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('حدث خطأ: $e'),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E5339),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'إنشاء الرحلة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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

  Widget _tripTypeCard({
    required String title,
    required IconData icon,
  }) {
    final isSelected = selectedTripType == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTripType = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE4EBDD) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? const Color(0xFF2E5339) : Colors.transparent,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 28,
              color: const Color(0xFF2E5339),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: const Color(0xFF2E5339),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
