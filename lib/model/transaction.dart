
import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime time;
  final double balance;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.time,
    this.balance=0});


}