import 'package:flutter/material.dart';

// Define common colors
const Color primaryColor = Color(0xFF5E4725); // Lighter brown color, you can adjust this
const Color secondaryColor = Color(0xFF48CB4D); // Another color you can use

// Define common text styles
final TextStyle headingTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: primaryColor,
);

final TextStyle buttonTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

// Define a common button style
final ButtonStyle commonButtonStyle = ElevatedButton.styleFrom(
  primary: primaryColor,
  onPrimary: Colors.white,
  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0),
  ),
);

// Define a common background widget with the specified color
Widget commonBackground({
  required Color color,
  required Widget child,
}) {
  return Container(
    color: color,
    child: child,
  );
}
