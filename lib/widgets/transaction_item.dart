import 'package:expensetracker/model/transaction.dart' ;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionView extends StatefulWidget {
  @override
  _TransactionViewState createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  List<Transaction> transactions = [
    Transaction
  (
        id: 't1',
        title: 'New Shoes',
        amount: 69.99,
        time: DateTime.now()
    ),

    Transaction
  (
        id: 't2',
        title: 'New Trousers',
        amount: 40.99,
        time: DateTime.now()
    ),

    Transaction
  (
        id: 't3',
        title: 'Loan',
        amount: -40.99,
        time: DateTime.now()
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
        children: transactions.map((t1) {
      return TransactionViewWidget(transaction: t1);}
    ).toList()
    );
  }
}


class TransactionViewWidget extends StatelessWidget {
  final Transaction transaction;

  TransactionViewWidget({@required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transaction
                  .title,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd HH:MM').format(transaction
                  .time),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 12, color: Colors.black38),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('£ ${transaction
            .amount}'.replaceAll('-', ''),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: getTransactionViewColor()
                )),
            ),
          ],
        ),
      ),
    );
  }

  MaterialColor getTransactionViewColor() =>
      transaction.amount > 0 ? Colors.green : Colors.red;
}
