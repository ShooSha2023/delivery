import 'package:flutter/material.dart';
import 'login_screen.dart'; // تأكد من استيراد شاشة تسجيل الدخول

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // تعريف المتغير بشكل صحيح
  late Animation<double> _opacityAnimation; // تعريف متغير الشفافية

  @override
  void initState() {
    super.initState();

    // إعداد AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 3), // مدة التلاشي
      vsync: this,
    );

    // إعداد Animation لتغيير الشفافية
    _opacityAnimation =
        Tween<double>(begin: 2.0, end: 0.02).animate(_controller);

    // بدء الحركة
    _controller.forward();

    // الانتقال بعد انتهاء التلاشي
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // التخلص من الموارد عند إغلاق الشاشة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _opacityAnimation, // استخدام الرسوم المتحركة
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/hello.jpg'), // مسار الصورة
              fit: BoxFit.cover, // لجعل الصورة تملأ الشاشة بالكامل
            ),
          ),
        ),
      ),
    );
  }
}
