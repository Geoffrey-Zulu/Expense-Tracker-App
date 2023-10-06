import 'package:flutter/material.dart';
import 'expense_form.dart'; // Import the ExpenseFormScreen widget
import 'expense_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: ExpenseList(), // Add your expense list widget here
      floatingActionButton: ExpenseFABWithForm(), // Add your FAB here
      bottomNavigationBar: BottomNavigation(), // Add the BottomNavigation widget here
    );
  }
}

class ExpenseList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your actual list of expenses
    final List<Expense> expenses = [
      Expense(
        date: DateTime.now(),
        amount: 50.0,
        category: 'Groceries',
        thumbnail: Image.asset(
          'assets/images/thumbnail.png',
          fit: BoxFit.contain,
          width: 20,
          height: 20,
        ),
      ),
      // Add more expenses as needed
    ];

    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];
        return ExpenseItem(expense: expense); // Use the ExpenseItem widget
      },
    );
  }
}

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/'); // Navigate to the home screen
            break;
          case 1:
            Navigator.pushNamed(context, '/statistics'); // Navigate to the statistics screen
            break;
          case 2:
            Navigator.pushNamed(context, '/settings'); // Navigate to the settings screen
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insert_chart),
          label: 'Statistics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}

class ExpenseFABWithForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ExpenseForm(), // Navigate to the form screen
          ),
        );
      },
      child: Icon(Icons.add),
    );
  }
}
