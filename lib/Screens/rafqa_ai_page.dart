import 'package:flutter/material.dart';

class RafqaAIPage extends StatefulWidget {
  const RafqaAIPage({super.key});
  @override
  State<RafqaAIPage> createState() => _RafqaAIPageState();
}

class _RafqaAIPageState extends State<RafqaAIPage> {
  static const Color backgroundColor = Color(0xFF0B1220);
  static const Color cardColor = Color(0xFF17243A);
  static const Color primaryColor = Color(0xFF214E78);
  static const Color accentColor = Color(0xFF5C9BD1);
  final TextEditingController messageController = TextEditingController();
  final List<Map<String, String>> messages = [
    {
      'sender': 'ai',
      'message': 'أهلًا بك 👋 أنا مساعد رِفقة، كيف أقدر أساعدك في رحلتك؟',
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
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

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
            'مساعد رِفقة',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),

        // ================= BODY =================
        body: Column(
          children: [
            // ================= CHAT =================
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
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
                        vertical: 13,
                      ),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.78,
                      ),
                      decoration: BoxDecoration(
                        color: isUser ? primaryColor : cardColor,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(18),
                          topRight: const Radius.circular(18),
                          bottomLeft: Radius.circular(
                            isUser ? 18 : 5,
                          ),
                          bottomRight: Radius.circular(
                            isUser ? 5 : 18,
                          ),
                        ),
                        border: Border.all(
                          color: isUser
                              ? Colors.transparent
                              : Colors.white.withOpacity(0.06),
                        ),
                      ),
                      child: Text(
                        message['message']!,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.white,
                          fontWeight:
                              isUser ? FontWeight.normal : FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

// ================= INPUT AREA =================
            Container(
              padding: const EdgeInsets.fromLTRB(
                15,
                10,
                15,
                15,
              ),
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border(
                  top: BorderSide(
                    color: Colors.white.withOpacity(0.06),
                  ),
                ),
              ),
              child: Row(
                textDirection: TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // ================= SEND BUTTON =================
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: IconButton(
                      onPressed: sendMessage,
                      icon: const Icon(
                        Icons.arrow_upward_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // ================= TEXT FIELD =================
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      minLines: 1,
                      maxLines: 4,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      cursorColor: accentColor,
                      decoration: InputDecoration(
                        hintText: 'اكتب سؤالك...',
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: const TextStyle(
                          color: Colors.white38,
                          fontSize: 13,
                        ),
                        filled: true,
                        fillColor: cardColor,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
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
                            width: 1,
                          ),
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
      ),
    );
  }
}
