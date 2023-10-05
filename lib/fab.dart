import 'package:flutter/material.dart';
import 'components.dart';

class ExpenseFABWithForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Navigate to the expense form when FAB is tapped
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ExpenseForm(),
          ),
        );
      },
      child: Icon(Icons.add),
      backgroundColor: primaryColor, // Apply custom background color
    );
  }
}

class ExpenseForm extends StatelessWidget {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Add Expense',
          style: headingTextStyle.copyWith(color: Colors.white), // Apply custom text style
        ),
        centerTitle: true, // Center align the title
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
                controller: dateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 16.0),
              // DropdownButtonFormField for Category
              DropdownButtonFormField(
                items: <String>['Category 1', 'Category 2', 'Category 3', 'Category 4']
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
                onPressed: () {
                  // Implement image selection/upload logic here
                },
                icon: Icon(Icons.image),
                label: Text('Select Image'),
                style: commonButtonStyle, // Apply custom button style
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Implement expense submission logic here
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
                child: Text('Submit Expense', style: buttonTextStyle), // Apply custom text style
                style: commonButtonStyle, // Apply custom button style
              ),
            ],
          ),
        ),
      ),
    );
  }
}
