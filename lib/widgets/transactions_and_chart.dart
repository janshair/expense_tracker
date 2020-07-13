

import 'package:universal_io/io.dart';

import 'package:expensetracker/model/transaction_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './transaction_add.dart';
import './transaction_item.dart';
import './chart.dart';
import '../model/transaction.dart';
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
    final mediaQuery = MediaQuery.of(context);
    final _isLandscapeMode = MediaQuery.of(context).orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS ? CupertinoNavigationBar(
      leading: GestureDetector(
          child: Icon(
            CupertinoIcons.settings,
            color: Theme.of(context).accentColor,
          ),
          onTap: () {
            Navigator.push(context, CupertinoPageRoute(builder: (context) => SettingsScreen()));
          },
        ),
      middle: Text(
        'Expense App',
        style: TextStyle(color: Theme.of(context).accentColor),
      ),
      trailing: GestureDetector(
        child: Icon(
          CupertinoIcons.add,
          color: Theme.of(context).accentColor,
        ),
        onTap: () {
          _onPressedAddTransaction(context);
        },
      ),
    ): AppBar(
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
    var pageBody = SafeArea(
        bottom: true,
        top: true,
        child:  SingleChildScrollView(
              child: Container( decoration: BoxDecoration(color: Theme.of(context).accentColor),

                child: Column(
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
                            'Show Chart',
                            style: Theme.of(context).textTheme.headline6,),
                        Switch.adaptive(
                            activeColor: Theme.of(context).accentColor,
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                    height: (mediaQuery.size.height -
                        appBar.preferredSize.height) *
                        0.5,
                    child: TransactionView(transactions: transactionsList)),
            ),
          ],
        ),
              ),
      )
    );
    
    return Platform.isIOS ? CupertinoPageScaffold(
      child: pageBody,
      navigationBar: appBar,
      ): Scaffold(
      appBar: appBar,
      body: pageBody,
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _onPressedAddTransaction(context),
      ),
    );
  }
}