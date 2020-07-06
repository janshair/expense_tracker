
import 'package:expensetracker/model/transaction_type.dart';
import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime time;
  final TransactionType transactionType ;
  final double balance;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.time,
    @required this.transactionType,
    this.balance=0});
}