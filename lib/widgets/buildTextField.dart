import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildTextField({
  required String label,
  required String hintText,
  required IconData icon,
  ValueChanged<String>? onChanged,
  TextInputType? keyboardType,
  List<TextInputFormatter>? inputFormatters,
}) {
  return TextField(
    onChanged: onChanged,
    keyboardType: keyboardType,
    inputFormatters: inputFormatters,
    style: TextStyle(color: Color(0xFFEF6C00)),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.orange[800]),
      hintText: hintText,
      prefixIcon: Icon(icon, color: Colors.orange),
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
  );
}
