import 'dart:ui';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  bool isLoading = false;
  void _continue() {
    final phone = phoneController.text.trim();
    if (phone.length < 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('فضلاً أدخل رقم جوال صحيح'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      Navigator.pushNamed(
        context,
        '/verify',
        arguments: phone,
      );
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // =========================
          // Background Image
          // =========================
          Positioned.fill(
            child: Image.asset(
              'assets/images/login_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          // =========================
          // Navy Overlay
          // =========================
          Positioned.fill(
            child: Container(
              color: const Color(0xFF071A2F).withOpacity(0.72),
            ),
          ),

          // =========================
          // Subtle Gradient
          // =========================
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF06182B).withOpacity(0.25),
                    const Color(0xFF06182B).withOpacity(0.45),
                    const Color(0xFF020B17).withOpacity(0.82),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Column(
                children: [
                  // =========================
                  // Logo
                  // =========================
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.22),
                            ),
                          ),
                          child: const Icon(
                            Icons.groups_rounded,
                            color: Colors.white,
                            size: 27,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'رِفقة',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // =========================
                  // Main Text
                  // =========================
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'أهلًا بك في رِفقة',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'رفيق رحلتك في الحرمين',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // =========================
                  // Glass Phone Field
                  // =========================
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 12,
                        sigmaY: 12,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.22),
                          ),
                        ),
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'رقم الجوال',
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.55),
                            ),
                            prefixIcon: const Icon(
                              Icons.phone_outlined,
                              color: Colors.white70,
                            ),
                            prefixText: '+966  ',
                            prefixStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // =========================
                  // Continue Button
                  // =========================
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _continue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF183B5B),
                        disabledBackgroundColor:
                            const Color(0xFF183B5B).withOpacity(0.65),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19),
                          side: BorderSide(
                            color: Colors.white.withOpacity(0.22),
                          ),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 23,
                              height: 23,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.2,
                                color: Colors.white,
                              ),
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'متابعة',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // =========================
                  // Privacy Text
                  // =========================
                  Text(
                    'بتسجيل الدخول، أنت توافق على شروط الاستخدام والخصوصية',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.55),
                      fontSize: 11.5,
                      height: 1.5,
                    ),
                  ),

                  const Spacer(),

                  // =========================
                  // Bottom Branding
                  // =========================
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFF7FAF91),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'رحلتك تبدأ بخطوة',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.55),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
