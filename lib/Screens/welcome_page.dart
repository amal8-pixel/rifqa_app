import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 360;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFF071A2B),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/haram.png',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.5),
                    const Color(0xFF071A2B).withOpacity(0.95),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(
                      'أهلًا بك في رِفقة',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isSmall ? 34 : 40,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'رفيق رحلتك في الحرمين\nمن البداية حتى العودة',
                      style: TextStyle(
                        color: Color(0xFFD5DFE7),
                        fontSize: 18,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFF214E78),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 25,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 25,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/login',
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF214E78),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'ابدأ رحلتك',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
