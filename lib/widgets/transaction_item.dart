import '../model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionView extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionView({@required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty ? Column(children: <Widget>[
        Text('No Transactions yet'),
        SizedBox(height: 20,),
        Container(
            height: 200,
            child: Image.asset('assets/image/waiting.png', fit: BoxFit.cover,))
      ],) : ListView.builder(itemBuilder: (ctx, index) {
        return Card(
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
                      transactions[index]
                          .title,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd HH:MM').format(transactions[index]
                          .time),
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 12, color: Colors.black38),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('£ ${transactions[index]
                    .amount.toStringAsFixed(2)}'.replaceAll('-', ''),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: getTransactionViewColor(context,transactions[index])
                    )),
              ),
            ],
          ),
        );
      },
      itemCount: transactions.length,),
    );
  }

  Color getTransactionViewColor(BuildContext context, Transaction transaction) =>
      transaction.amount > 0 ? Theme.of(context).primaryColor : Colors.red;
}
