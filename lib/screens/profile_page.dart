import 'dart:io'; // لدعم التعامل مع ملفات الصور
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/widgets/buildTextField.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart'; // مكتبة اختيار الصور

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? selectedLocation; // متغير لتخزين الموقع المختار من القائمة
  final List<String> locations = [
    'Damascus',
    'حلب',
    'حمص',
    'اللاذقية',
    'طرطوس'
  ];
  String? locationDetails;

  // متغير لتخزين الصورة المختارة
  File? _profileImage;
  Future<void> _requestPermission() async {
    if (await Permission.photos.isDenied) {
      await Permission.photos.request();
    }
    if (await Permission.camera.isDenied) {
      await Permission.camera.request();
    }
  }

  // ميثود لفتح المعرض واختيار صورة
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          title: Text('Profile page'),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 30.0),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // صورة البروفايل مع زر التعديل
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 78,
                      backgroundColor: Colors.orange[500],
                      child: CircleAvatar(
                        radius: 75,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : AssetImage('images/hello.jpg') as ImageProvider,
                        backgroundColor: Colors.orange[400],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.orange,
                        size: 30,
                      ),
                      onPressed: _pickImage, // استدعاء ميثود اختيار الصورة
                    ),
                  ],
                ),
                SizedBox(height: 32),
                buildTextField(
                  label: 'first name',
                  hintText: 'enter your first name',
                  icon: Icons.person_3_rounded,
                ),
                SizedBox(height: 24),
                buildTextField(
                  label: 'last name',
                  hintText: 'enter your last name',
                  icon: Icons.person_3_rounded,
                ),
                SizedBox(height: 24),
                buildTextField(
                  label: 'phone number',
                  hintText: 'enter your phone number',
                  icon: Icons.phone,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                SizedBox(height: 16),
                _buildLocationDropdown(),
                if (selectedLocation != null) ...[
                  SizedBox(height: 16),
                  buildTextField(
                    label: 'location details',
                    hintText: 'enter more details about your location',
                    icon: Icons.location_on,
                    onChanged: (value) {
                      locationDetails = value;
                    },
                  ),
                ],
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ElevatedButton(
                    onPressed: () {
                      print('Selected Location: $selectedLocation');
                      print('Location Details: $locationDetails');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'save',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable TextField Widget

  // Dropdown for Location selection
  Widget _buildLocationDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'location',
        labelStyle: TextStyle(color: Colors.orange[800]),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
      value: selectedLocation,
      hint: Text('choose your location'),
      items: locations
          .map(
            (location) => DropdownMenuItem<String>(
              value: location,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.orange, width: 0.5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(location),
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedLocation = value;
          locationDetails = null;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'الرجاء اختيار الموقع';
        }
        return null;
      },
      dropdownColor: Colors.white,
      iconEnabledColor: Colors.orange,
      style: TextStyle(color: Colors.orange[800]),
    );
  }
}
