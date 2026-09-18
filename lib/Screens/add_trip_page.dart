import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/trip_members_cubit.dart';
import 'cubit/trip_members_state.dart';

class AddTripPage extends StatefulWidget {
  const AddTripPage({super.key});

  @override
  State<AddTripPage> createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  final TextEditingController tripNameController = TextEditingController();

  final TextEditingController hotelController = TextEditingController();

  String selectedTripType = 'عمرة';

  // ألوان الثيم
  static const Color backgroundColor = Color(0xFF0B1220);
  static const Color cardColor = Color(0xFF17243A);
  static const Color primaryColor = Color(0xFF214E78);
  static const Color accentColor = Color(0xFF5C9BD1);

  @override
  void dispose() {
    tripNameController.dispose();
    hotelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TripMembersCubit(),
      child: Builder(
        builder: (context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: backgroundColor,

              // =========================
              // AppBar
              // =========================
              appBar: AppBar(
                backgroundColor: backgroundColor,
                elevation: 0,
                centerTitle: true,
                title: const Text(
                  'إنشاء رحلة جديدة',
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

              // =========================
              // Body
              // =========================
              body: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  10,
                  20,
                  35,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // العنوان
                    const Text(
                      'أنشئ رحلتك',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'أدخل تفاصيل الرحلة لتنظيمها بسهولة.',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white60,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // =========================
                    // اسم الرحلة
                    // =========================
                    _sectionTitle('اسم الرحلة'),

                    const SizedBox(height: 10),

                    _textField(
                      controller: tripNameController,
                      hintText: 'مثال: عمرة رمضان مع العائلة',
                      icon: Icons.edit_outlined,
                    ),

                    const SizedBox(height: 25),

                    // =========================
                    // نوع الرحلة
                    // =========================
                    _sectionTitle('نوع الرحلة'),

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
                            icon: Icons.mosque_rounded,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // =========================
                    // عدد الأعضاء
                    // =========================
                    _sectionTitle('عدد الأعضاء'),

                    const SizedBox(height: 12),

                    BlocBuilder<TripMembersCubit, TripMembersState>(
                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.07),
                            ),
                          ),
                          child: Row(
                            children: [
                              // زر النقص
                              _counterButton(
                                icon: Icons.remove_rounded,
                                onPressed: () {
                                  context.read<TripMembersCubit>().decrease();
                                },
                              ),

                              // العدد
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      '${state.membersCount}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    const Text(
                                      'أعضاء الرحلة',
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // زر الزيادة
                              _counterButton(
                                icon: Icons.add_rounded,
                                onPressed: () {
                                  context.read<TripMembersCubit>().increase();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 25),

                    // =========================
                    // الفندق
                    // =========================
                    _sectionTitle('اسم الفندق'),

                    const SizedBox(height: 10),

                    _textField(
                      controller: hotelController,
                      hintText: 'مثال: فندق دار التوحيد',
                      icon: Icons.hotel_outlined,
                    ),

                    const SizedBox(height: 32),

                    // =========================
                    // زر إنشاء الرحلة
                    // =========================
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () async {
                          // التحقق من اسم الرحلة
                          if (tripNameController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'يرجى إدخال اسم الرحلة',
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            );
                            return;
                          }

                          // قراءة عدد الأعضاء قبل await
                          final membersCount = context
                              .read<TripMembersCubit>()
                              .state
                              .membersCount;

                          try {
                            await FirebaseFirestore.instance
                                .collection('trips')
                                .add({
                              'name': tripNameController.text.trim(),
                              'type': selectedTripType,
                              'date': '15 رمضان 1448',
                              'members': membersCount,
                              'status': 'قادمة',
                              'hotel': hotelController.text.trim(),
                              'leader': 'أحمد محمد',
                              'createdAt': FieldValue.serverTimestamp(),
                            });

                            if (!context.mounted) return;

                            Navigator.pop(context);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'تم إنشاء الرحلة بنجاح',
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            );
                          } catch (e) {
                            if (!context.mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'حدث خطأ أثناء إنشاء الرحلة: $e',
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_rounded,
                              size: 21,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'إنشاء الرحلة',
                              style: TextStyle(
                                fontSize: 16,
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
        },
      ),
    );
  }

  // =========================
  // عنوان القسم
  // =========================
  Widget _sectionTitle(String title) {
    return Text(
      title,
      textAlign: TextAlign.right,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // =========================
  // حقل الإدخال
  // =========================
  Widget _textField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintTextDirection: TextDirection.rtl,
        hintStyle: const TextStyle(
          color: Colors.white38,
          fontSize: 13,
        ),
        prefixIcon: Icon(
          icon,
          color: accentColor,
          size: 21,
        ),
        filled: true,
        fillColor: cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.06),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.06),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: accentColor,
            width: 1.2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 17,
        ),
      ),
    );
  }

  // =========================
  // كرت نوع الرحلة
  // =========================
  Widget _tripTypeCard({
    required String title,
    required IconData icon,
  }) {
    final bool isSelected = selectedTripType == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTripType = title;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          vertical: 17,
          horizontal: 6,
        ),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? accentColor.withOpacity(0.65)
                : Colors.white.withOpacity(0.06),
            width: isSelected ? 1.2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected ? accentColor : Colors.white70,
            ),
            const SizedBox(height: 9),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // أزرار زيادة ونقصان العدد
  // =========================
  Widget _counterButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.white.withOpacity(0.06),
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          width: 48,
          height: 48,
          child: Icon(
            icon,
            color: accentColor,
            size: 22,
          ),
        ),
      ),
    );
  }
}
