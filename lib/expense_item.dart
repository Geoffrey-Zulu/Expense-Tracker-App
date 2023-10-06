import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'components.dart';

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

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  ExpenseItem({required this.expense});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(), // Unique key for each item
      background: Container(
        color: Colors.green,
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 40.0,
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40.0,
        ),
      ),
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.startToEnd) {
          // Handle edit action here
          // You can navigate to the edit screen or perform any other action
          // Return false to prevent dismissal, or true to allow dismissal
          return false;
        } else if (direction == DismissDirection.endToStart) {
          // Handle delete action here
          // You can show a confirmation dialog or directly delete the item
          // Return false to prevent dismissal, or true to allow dismissal
          return true;
        }
        return false;
      },
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart) {
          // Handle delete action here
          // You can remove the item from your data source
          // This is where you should implement the delete logic
          // After deleting, you can update the UI accordingly
        }
      },
      child: Card(
        elevation: 4.0,
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListTile(
          contentPadding: EdgeInsets.all(16.0),
          leading: Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.contain,
                image: expense.thumbnail.image,
              ),
            ),
          ),
          title: Text(
            'Date: ${DateFormat('yyyy-MM-dd').format(expense.date)}',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
      ),
    );
  }
}
