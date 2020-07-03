import 'package:expensetracker/model/transaction_type.dart';

import './transaction_item.dart';
import 'package:flutter/material.dart';
import '../model/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> transactionsList = [
    Transaction
      (
        id: 't1',
        title: 'New Shoes',
        amount: 69.99,
        time: DateTime.now(),
        transactionType: TransactionType.Expense
    ),

    Transaction
      (
        id: 't2',
        title: 'New Trousers',
        amount: 40.99,
        time: DateTime.now(),
        transactionType: TransactionType.Expense
    ),

    Transaction
      (
        id: 't3',
        title: 'Loan',
        amount: 40.99,
        time: DateTime.now(),
        transactionType: TransactionType.Income
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TransactionView(transactions: transactionsList),
    ],);
  }
}
