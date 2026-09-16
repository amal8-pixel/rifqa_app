import 'package:flutter/material.dart';

class RafqaAIPage extends StatefulWidget {
  const RafqaAIPage({super.key});
  @override
  State<RafqaAIPage> createState() => _RafqaAIPageState();
}

class _RafqaAIPageState extends State<RafqaAIPage> {
  final TextEditingController messageController = TextEditingController();
  final List<Map<String, String>> messages = [
    {
      'sender': 'ai',
      'message': 'أهلًا بك 👋 أنا مساعد رفقة، كيف أقدر أساعدك في رحلتك؟',
    },
  ];
  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({
        'sender': 'user',
        'message': text,
      });

      messages.add({
        'sender': 'ai',
        'message': 'حاليًا أعمل على مساعدتك 🤍',
      });
    });

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2E5339);
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF8F5),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'مساعد رفقة',
          style: TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // المحادثة
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUser = message['sender'] == 'user';

                return Align(
                  alignment:
                      isUser ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.78,
                    ),
                    decoration: BoxDecoration(
                      color: isUser ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      message['message']!,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 14,
                        color: isUser ? Colors.white : primaryColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // حقل الكتابة
          Container(
            padding: const EdgeInsets.fromLTRB(
              15,
              10,
              15,
              15,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                // زر الإرسال
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(
                      Icons.arrow_upward_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // TextField
                Expanded(
                  child: TextField(
                    controller: messageController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'اكتب سؤالك...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFFAF8F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) {
                      sendMessage();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
