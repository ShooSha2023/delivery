import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // لتتبع الأيقونة النشطة

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // الصورة كخلفية
            Positioned.fill(
              child: Image.asset(
                'images/signup.jpg', // ضع مسار الصورة هنا
                fit: BoxFit.fill,
              ),
            ),
            // محتوى التطبيق فوق الصورة
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(200.0, 35.0, 25, 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.search, color: Colors.orange),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'ابحث هنا...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 200),
                  child: Text(
                    'the factories',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 136, 0),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // قائمة المتاجر
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 100, 40),
                    child: ListView.builder(
                      itemCount: 10, // عدد المتاجر
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            print("تم اختيار المتجر ${index + 1}");
                          },
                          child: Card(
                            color: Color.fromARGB(255, 255, 241, 224),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.orange,
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text("اسم المتجر ${index + 1}"),
                              subtitle: Text("وصف مختصر عن المتجر"),
                              trailing: Icon(Icons.arrow_forward_ios,
                                  color: Colors.orange),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // Drawer الجانبي
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Text(
                'قائمة التنقل',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('الرئيسية'),
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('المفضلة'),
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('البروفايل'),
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('السلة'),
              onTap: () {
                setState(() {
                  _currentIndex = 3;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('خروج'),
              onTap: () {
                setState(() {
                  _currentIndex = 4;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      // إضافة أيقونة لفتح Drawer باستخدام Builder
      floatingActionButton: Builder(
        builder: (BuildContext context) {
          return FloatingActionButton(
            onPressed: () {
              // فتح Drawer عند الضغط على الأيقونة
              Scaffold.of(context).openDrawer();
            },
            backgroundColor: Colors.orange,
            child: Icon(Icons.menu),
          );
        },
      ),
    );
  }
}
