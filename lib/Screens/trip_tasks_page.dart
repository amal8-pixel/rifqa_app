import 'package:flutter/material.dart';

class TripTasksPage extends StatefulWidget {
  const TripTasksPage({super.key});
  @override
  State<TripTasksPage> createState() => _TripTasksPageState();
}

class _TripTasksPageState extends State<TripTasksPage> {
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
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFFFAF8F5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              title: const Text(
                'إضافة مهمة',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF2E5339),
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: taskController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'اكتبي اسم المهمة',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
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
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'إلغاء',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E5339),
                    foregroundColor: Colors.white,
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

                    Navigator.pop(context);
                  },
                  child: const Text('إضافة'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text(
          'مهام الرحلة',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFAF8F5),
        foregroundColor: const Color(0xFF2E5339),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: _showAddTaskDialog,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ملخص الإنجاز
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2E5339),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'عمرة رمضان 1448',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$completedTasks من ${tasks.length} مهام مكتملة',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: Colors.white24,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
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

          const SizedBox(height: 24),

          _buildSection(
            title: 'أثناء الرحلة',
            category: 'أثناء الرحلة',
          ),
        ],
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E5339),
          ),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: CheckboxListTile(
        value: isDone,
        onChanged: (value) {
          setState(() {
            task['done'] = value ?? false;
          });
        },
        activeColor: const Color(0xFF2E5339),
        title: Text(
          task['title'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDone ? Colors.grey : const Color(0xFF2E5339),
            decoration: isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          task['subtitle'],
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
      ),
    );
  }
}
