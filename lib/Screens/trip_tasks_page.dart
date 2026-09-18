import 'package:flutter/material.dart';

class TripTasksPage extends StatefulWidget {
  const TripTasksPage({super.key});
  @override
  State<TripTasksPage> createState() => _TripTasksPageState();
}

class _TripTasksPageState extends State<TripTasksPage> {
  static const Color backgroundColor = Color(0xFF0B1220);
  static const Color cardColor = Color(0xFF17243A);
  static const Color primaryColor = Color(0xFF214E78);
  static const Color accentColor = Color(0xFF5C9BD1);
  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'تجهيز حقيبة الرحلة',
      'subtitle': 'التأكد من تجهيز الاحتياجات الأساسية',
      'category': 'قبل الرحلة',
      'done': false,
    },
    {
      'title': 'التأكد من وثائق الرحلة',
      'subtitle': 'الهوية والتصاريح والمستندات المطلوبة',
      'category': 'قبل الرحلة',
      'done': false,
    },
    {
      'title': 'التأكد من موعد التجمع',
      'subtitle': 'الوصول إلى نقطة التجمع في الوقت المحدد',
      'category': 'قبل الرحلة',
      'done': true,
    },
    {
      'title': 'التجمع مع أفراد الرحلة',
      'subtitle': 'التأكد من وجود جميع المعتمرين',
      'category': 'أثناء الرحلة',
      'done': false,
    },
    {
      'title': 'الالتزام ببرنامج الرحلة',
      'subtitle': 'متابعة المواعيد والتنقلات',
      'category': 'أثناء الرحلة',
      'done': false,
    },
  ];
  int get completedTasks => tasks.where((task) => task['done'] == true).length;
  double get progress => tasks.isEmpty ? 0 : completedTasks / tasks.length;
  void _showAddTaskDialog() {
    final taskController = TextEditingController();
    String selectedCategory = 'قبل الرحلة';
    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                backgroundColor: cardColor,
                surfaceTintColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: BorderSide(
                    color: Colors.white.withOpacity(0.07),
                  ),
                ),
                title: const Text(
                  'إضافة مهمة',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: taskController,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'اكتبي اسم المهمة',
                        hintStyle: const TextStyle(
                          color: Colors.white38,
                        ),
                        filled: true,
                        fillColor: backgroundColor,
                        prefixIcon: const Icon(
                          Icons.task_alt_outlined,
                          color: accentColor,
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
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      dropdownColor: cardColor,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: backgroundColor,
                        prefixIcon: const Icon(
                          Icons.category_outlined,
                          color: accentColor,
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
                      items: const [
                        DropdownMenuItem(
                          value: 'قبل الرحلة',
                          child: Text('قبل الرحلة'),
                        ),
                        DropdownMenuItem(
                          value: 'أثناء الرحلة',
                          child: Text('أثناء الرحلة'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() {
                            selectedCategory = value;
                          });
                        }
                      },
                    ),
                  ],
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      if (taskController.text.trim().isEmpty) {
                        return;
                      }

                      setState(() {
                        tasks.add({
                          'title': taskController.text.trim(),
                          'subtitle': 'مهمة مضافة حديثًا',
                          'category': selectedCategory,
                          'done': false,
                        });
                      });

                      Navigator.pop(dialogContext);
                    },
                    child: const Text(
                      'إضافة',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      taskController.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text(
            'مهام الرحلة',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.add_rounded,
                color: accentColor,
              ),
              onPressed: _showAddTaskDialog,
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          children: [
            // ملخص الإنجاز
            Container(
              padding: const EdgeInsets.all(21),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF214E78),
                    Color(0xFF10253F),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.checklist_rounded,
                          color: accentColor,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 13),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'عمرة رمضان 1448',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'تابع مهام رحلتك خطوة بخطوة',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$completedTasks من ${tasks.length} مهام مكتملة',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        '${(progress * 100).round()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: Colors.white.withOpacity(0.15),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        accentColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            _buildSection(
              title: 'قبل الرحلة',
              category: 'قبل الرحلة',
            ),

            const SizedBox(height: 16),

            _buildSection(
              title: 'أثناء الرحلة',
              category: 'أثناء الرحلة',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String category,
  }) {
    final categoryTasks =
        tasks.where((task) => task['category'] == category).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          textDirection: TextDirection.rtl,
          children: [
            Container(
              width: 5,
              height: 22,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 9),
            Text(
              title,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...categoryTasks.map(
          (task) => _buildTaskCard(task),
        ),
      ],
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    final bool isDone = task['done'] == true;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDone
              ? accentColor.withOpacity(0.15)
              : Colors.white.withOpacity(0.06),
        ),
      ),
      child: CheckboxListTile(
        value: isDone,
        onChanged: (value) {
          setState(() {
            task['done'] = value ?? false;
          });
        },
        activeColor: accentColor,
        checkColor: backgroundColor,
        title: Text(
          task['title'],
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: isDone ? Colors.white54 : Colors.white,
            decoration:
                isDone ? TextDecoration.lineThrough : TextDecoration.none,
            decorationColor: Colors.white54,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            task['subtitle'],
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
        ),
        controlAffinity: ListTileControlAffinity.trailing,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
      ),
    );
  }
}
