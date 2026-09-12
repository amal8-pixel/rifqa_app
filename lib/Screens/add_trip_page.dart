import 'package:flutter/material.dart';

class AddTripPage extends StatefulWidget {
  const AddTripPage({super.key});

  @override
  State<AddTripPage> createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController tripNameController = TextEditingController();
  final TextEditingController dataController = TextEditingController();
  final TextEditingController meetingPointController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF8F5),
        appBar: AppBar(
          title: const Text('إضافة رحلة جديدة'),
          backgroundColor: const Color(0xFFFAF8F5),
          foregroundColor: const Color(0xFF2E5339),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'أنشئ رحلة جديدة 🕋',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E5339),
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'اسم الرحلة',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E5339),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                    controller: tripNameController,
                    decoration: InputDecoration(
                      hintText: 'مثال: عمرة رمضان',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال اسم الرحلة';
                      }
                      return null;
                    }),
                const SizedBox(height: 18),
                const Text(
                  'تاريخ الرحلة',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E5339),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: dataController,
                  decoration: InputDecoration(
                    hintText: 'مثال: 15 رمضان 1447',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء ادخال تاريخ الرحلة';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 18),
                const Text(
                  'نقطة التجمع',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E5339),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'مثال: بوابة الملك فهد',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال نقطة التجمع';
                      }
                      return null;
                    }),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() ?? false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تم انشاء الرحلة بنجاح'),
                            backgroundColor: Color(0xFF2E5339),
                          ),
                        );
                        Navigator.pop(
                          context,
                          tripNameController.text,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E5339),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'إنشاء الرحلة',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
