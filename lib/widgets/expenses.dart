import 'package:finance_app/widgets/expenses_list/expenses_list.dart';
import 'package:finance_app/models/expense.dart';
import 'package:finance_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses>{
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Gym Membership',
      amount: 42.99,
      date: DateTime.now(),
      category: Category.leisure
    ),
    Expense(
      title: 'MTA',
      amount: 2.90,
      date: DateTime.now(),
      category: Category.travel
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vadim\'s Cool Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add_box_outlined)
          ),
        ],
      ),
      body: Column(
        children: [
          Text("Chart"),
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses)
          ),
        ],
      ),
    );
  }
}