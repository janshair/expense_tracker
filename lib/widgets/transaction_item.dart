import '../utils/money_calculator.dart';

import '../model/transaction.dart';
import './transaction_list_item.dart';
import 'package:flutter/material.dart';

class TransactionView extends StatefulWidget {
  final List<Transaction> transactions;

  TransactionView({@required this.transactions});

  @override
  _TransactionViewState createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  
void _deleteItemFromList(Transaction transaction) {
    setState(() {
      widget.transactions.remove(transaction);
    });
    print('transaction deleted');
  }

  @override
  Widget build(BuildContext context) {
    return widget.transactions.isEmpty
        ? Column(
            children: <Widget>[
              Text('No Transactions yet'),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 200,
                  child: Image.asset(
                    'assets/image/waiting.png',
                    fit: BoxFit.cover,
                  ))
            ],
          )
        : Align(
            alignment: Alignment.topCenter,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return TransactionListItem(widget.transactions[index], index, _deleteItemFromList, getBalance(index));
              },
              itemCount: widget.transactions.length,
              reverse: true,
              shrinkWrap: true,
            ),
          );
  }

  String getBalance(int index) => MoneyCalculator.calculateBalance(widget.transactions, index).toStringAsFixed(2);
}


