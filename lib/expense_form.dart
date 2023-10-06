import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'components.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';


class ExpenseForm extends StatefulWidget {
  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final TextEditingController amountController = TextEditingController();
  final DateTime currentDate = DateTime.now();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? pickedImage;
  String? latitude;
  String? longitude;


  Future<void> pickImage() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }

  Future<void> getLocation() async {
    final PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      final Position? currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        latitude = currentPosition?.latitude.toString();
        longitude = currentPosition?.longitude.toString();
      });
    } else {
      // Handle permission denied
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Add Expense',
          style: headingTextStyle.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.0),
              TextFormField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now())),
                decoration: InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
                readOnly: true,
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField(
                items: <String>['Food', 'Groceries', 'Utilities', 'Leisure']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Handle category selection
                },
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton.icon(
                onPressed: pickImage,
                icon: Icon(Icons.image),
                label: Text('Select Image'),
                style: commonButtonStyle,
              ),
              SizedBox(height: 16.0),
              Text(pickedImage?.path ?? ''),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  getLocation();
                },
                style: commonButtonStyle,
                child: Text('Get Location'),
              ),
              SizedBox(height: 20.0),
              Text('${latitude ?? ""}'),
              SizedBox(height: 10.0),
              Text('${longitude ?? ""}'),
              ElevatedButton(
                onPressed: () {
                  // Implement expense submission logic here
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
                child: Text('Submit Expense', style: buttonTextStyle),
                style: commonButtonStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
