import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();
enum Category {food, travel, leisure, work}

const categoryIcons = {
  Category.food: Icons.food_bank_outlined,
  Category.travel: Icons.wallet_travel_outlined,
  Category.leisure: Icons.beach_access_outlined,
  Category.work: Icons.business_center_outlined,
};

class Expense{
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();


  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate{
    return formatter.format(date);
  }
}