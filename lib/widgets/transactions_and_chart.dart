import 'package:expensetracker/model/transaction_type.dart';
import './transaction_add.dart';
import './transaction_item.dart';
import './chart.dart';
import '../model/transaction.dart';
import 'package:flutter/material.dart';

import 'settings/settings_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final List<Transaction> transactionsList = [
    Transaction(
        id: 't3',
        title: 'Hourly Wage',
        amount: 401,
        time: DateTime.now().subtract(Duration(days: 6)),
        transactionType: TransactionType.Income),
    Transaction(
        id: 't1',
        title: 'Shirt',
        amount: -12,
        time: DateTime.now().subtract(Duration(days: 5)),
        transactionType: TransactionType.Expense),
    Transaction(
        id: 't9',
        title: 'Pant',
        amount: -19,
        time: DateTime.now().subtract(Duration(days: 4)),
        transactionType: TransactionType.Expense),
  ];

  bool _switchChart = true;


  List<Transaction> get recentTransactions {
    return transactionsList
        .where((transaction) => transaction.time
        .isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _addTransaction(
      String txTitle, double txAmount, DateTime date, TransactionType txType) {
    final Transaction transaction = Transaction(
        title: txTitle,
        amount: txType == TransactionType.Expense ? txAmount * -1 : txAmount,
        id: DateTime.now().toString(),
        time: date,
        transactionType: txType);
    setState(() {
      transactionsList.add(transaction);
    });
  }

  void _onPressedAddTransaction(BuildContext buildContext) {
    showModalBottomSheet(
        context: buildContext,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: AddTransaction(_addTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final _isLandscapeMode = MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        'Expense App',
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
          },
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Container(

            height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height) *
                0.05,
            child: Visibility(
              visible: _isLandscapeMode,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Show Chart'),
                    Switch(
                        value: _switchChart,
                        onChanged: (value) {
                          setState(() {
                            _switchChart = value;
                          });
                        }),
                  ]),
            ),
          ),
          Visibility(
            visible: !_isLandscapeMode || _switchChart,
            child: Container(
                height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height) *
                    0.4,
                child: Chart(transactionsList)),
          ),
          Container(
              height: (MediaQuery.of(context).size.height -
                  appBar.preferredSize.height) *
                  0.5,
              child: TransactionView(transactions: transactionsList)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _onPressedAddTransaction(context),
      ),
    );
  }
}