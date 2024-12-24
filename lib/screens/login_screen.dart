import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/RegisterScreen.dart';
import 'package:flutter_application_1/widgets/buildTextField.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // الخلفية من الصورة المرسلة
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/signin.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // محتوى الواجهة
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // "Welcome Back!"
                Text(
                  'Wassilly',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 136, 0),
                    fontSize: 50.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "welcome back!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 30),
                // الحقول للتسجيل
                buildTextField(
                  label: 'phone number',
                  hintText: 'enter your phone number',
                  icon: Icons.person_3_rounded,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                SizedBox(height: 16.0),
                TextField(
                  obscureText: !_isPasswordVisible,
                  style: TextStyle(color: Color(0xFFEF6C00)),
                  decoration: InputDecoration(
                    labelText: 'password',
                    labelStyle: TextStyle(color: Color(0xFFEF6C00)),
                    hintText: 'create your password',
                    prefixIcon: const Icon(Icons.lock_person_outlined,
                        color: Colors.orange),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Color(0xFFEF6C00),
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                // زر التسجيل
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 136, 0),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Center(
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 235, 235),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                // "ليس لديك حساب؟" مع الانتقال إلى صفحة التسجيل
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(_createRoute());
                      },
                      child: const Text(
                        "SignUp",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 136, 0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => RegisterScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // الانتقال من اليمين
        const end = Offset.zero; // الوصول إلى الموقع النهائي
        const curve = Curves.slowMiddle;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 300),
    );
  }
}
