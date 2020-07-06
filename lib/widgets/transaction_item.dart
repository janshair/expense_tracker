import '../model/transaction_type.dart';
import '../utils/money_calculator.dart';

import '../model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: Dismissible(
                    key: Key(widget.transactions[index].id),
                    direction: DismissDirection.horizontal,
                    onDismissed: (direction) {
                      _deleteItemFromList(widget.transactions[index]);
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
                            widget.transactions[index].transactionType ==
                                    TransactionType.Expense
                                ? Colors.red
                                : Theme.of(context).primaryColor,
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FittedBox(
                              child: Text(widget
                                  .transactions[index].amount.removeNegitive
                                  .toStringAsFixed(0))),
                        ),
                      ),
                      title: Text(
                        widget.transactions[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(DateFormat.yMMMMEEEEd()
                          .format(widget.transactions[index].time)),
                      // trailing: Text('£${transactions[index].amount}\n Balance£${transactions[index].amount}', style: TextStyle(color: getTransactionViewColor(context, transactions[index])),),
                      trailing: RichText(
                        maxLines: 2,
                        textAlign: TextAlign.right,
                        text: TextSpan(children: [
                          TextSpan(
                            text:
                                '£${widget.transactions[index].amount.removeNegitive.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: getTransactionViewColor(
                                    context, widget.transactions[index])),
                          ),
                          TextSpan(text: '\n'),
                          TextSpan(
                              text:
                                  '£${MoneyCalculator.calculateBalance(widget.transactions, index).toStringAsFixed(2)}',
                              style: TextStyle(color: Colors.grey)),
                        ]),
                      ),
                    ),
                  ),
                );
              },
              itemCount: widget.transactions.length,
              reverse: true,
              shrinkWrap: true,
            ),
          );
  }

  Color getTransactionViewColor(
          BuildContext context, Transaction transaction) =>
      transaction.amount > 0 ? Theme.of(context).primaryColor : Colors.red;
}
