import '../model/transaction.dart';
import '../model/transaction_type.dart';
import 'package:flutter/material.dart';
import '../utils/money_calculator.dart';
import 'package:intl/intl.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  final int index;
  final Function deleteHandler;
  final String balance;

  const TransactionListItem(this.transaction, this.index, this.deleteHandler,this.balance);


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Dismissible(
        key: Key(transaction.id),
        direction: DismissDirection.horizontal,
        onDismissed: (direction) {
          deleteHandler(transaction);
        },
        background: Container(
            color: Colors.red,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            )),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor:
                transaction.transactionType ==
                        TransactionType.Expense
                    ? Colors.red
                    : Theme.of(context).primaryColor,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FittedBox(
                  child: Text(transaction.amount.removeNegitive
                      .toStringAsFixed(0))),
            ),
          ),
          title: Text(
            transaction.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(DateFormat.yMMMMEEEEd()
              .format(transaction.time)),
          // trailing: Text('£${transactions[index].amount}\n Balance£${transactions[index].amount}', style: TextStyle(color: getTransactionViewColor(context, transactions[index])),),
          trailing: RichText(
            maxLines: 2,
            textAlign: TextAlign.right,
            text: TextSpan(children: [
              TextSpan(
                text:
                    '£${transaction.amount.removeNegitive.toStringAsFixed(2)}',
                style: TextStyle(
                    color: getTransactionViewColor(
                        context, transaction)),
              ),
              TextSpan(text: '\n'),
              TextSpan(
                  text:
                      balance,
                  style: TextStyle(color: Colors.grey)),
            ]),
          ),
        ),
      ),
    );
  }
   Color getTransactionViewColor(
          BuildContext context, Transaction transaction) =>
      transaction.amount > 0 ? Theme.of(context).primaryColor : Colors.red;
}