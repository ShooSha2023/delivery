import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DynamicSearchScreen(),
    );
  }
}

class DynamicSearchScreen extends StatefulWidget {
  @override
  _DynamicSearchScreenState createState() => _DynamicSearchScreenState();
}

class _DynamicSearchScreenState extends State<DynamicSearchScreen> {
  // القائمة الأساسية للبيانات
  final List<String> items = [
    'Damascus',
    'Aleppo',
    'Homs',
    'Latakia',
    'Tartus',
    'Hama',
    'Daraa',
    'Idlib',
  ];

  // قائمة لتخزين النتائج المصفاة
  List<String> filteredItems = [];

  // المتغير الذي يحتفظ بنص البحث الحالي
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    // في البداية، اعرض كل العناصر
    filteredItems = items;
  }

  // ميثود لتصفية النتائج بناءً على نص البحث
  void _filterItems(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        // إذا كان البحث فارغًا، اعرض كل العناصر
        filteredItems = items;
      } else {
        // تصفية القائمة بناءً على نص البحث
        filteredItems = items
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Search'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // مربع البحث
            TextField(
              onChanged: _filterItems, // استدعاء التصفية عند تغيير النص
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            // عرض النتائج
            Expanded(
              child: filteredItems.isEmpty
                  ? Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(filteredItems[index]),
                          leading:
                              Icon(Icons.location_city, color: Colors.orange),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
