import 'package:flutter/material.dart';
import 'fab.dart';
import 'components.dart'; // Import your common components
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Expense Tracker',
          style: headingTextStyle.copyWith(color: Colors.white), // Apply custom text style
        ),
        centerTitle: true, // Center align the title
      ),


      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: primaryColor,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row( // Use Row to display items side by side
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the thumbnail here with a smaller size
                Container(
                  width: 80.0, // Adjust the width as needed
                  height: 80.0, // Adjust the height as needed
                  margin: EdgeInsets.only(right: 16.0), // Add spacing between thumbnail and details
                  child: expense.thumbnail, // Display the thumbnail image
                ),
                Expanded( // Use Expanded to allow the details to take available space
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: ${DateFormat('yyyy-MM-dd').format(expense.date)}',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Amount: \$${expense.amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Category: ${expense.category}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),



      floatingActionButton: ExpenseFABWithForm(), // Use the ExpenseFABWithForm widget
    );
  }
}

class Expense {
  final DateTime date;
  final double amount;
  final String category;
  final Image thumbnail;

  Expense({
    required this.date,
    required this.amount,
    required this.category,
    required this.thumbnail,
  });
}

final List<Expense> expenses = [
  Expense(
    date: DateTime.now(),
    amount: 50.0,
    category: 'Groceries',
    thumbnail: Image.asset(
      'assets/images/thumbnail.png',
      height: 100, // Adjust the size as needed
      width: 100, // Adjust the size as needed
    ),
  ),
  // Add more expenses as needed
];
