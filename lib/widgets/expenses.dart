import 'package:finance_app/widgets/chart/chart.dart';
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
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    int removedIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: const Text("Expense has been removed"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(removedIndex, expense);
            });
          }
        ),
      )
    );
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
    Widget mainContent = const Center(
      child: Text("No expenses found, add an expense using the plus in the upper right corner."),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense);
    }

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
          Chart(
            expenses: _registeredExpenses
          ),
          Expanded(
            child: mainContent
          ),
        ],
      ),
    );
  }
}