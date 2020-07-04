import 'package:expensetracker/model/transaction_type.dart';

import './widgets/transaction_add.dart';
import './widgets/transaction_item.dart';
import './widgets/chart.dart';
import './model/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Expense Tracker',
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.blueAccent,
          fontFamily: 'OpenSans',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 20 ,
                  )))),
      // home: MyHomePage(),
      routes: {'/': (context) => MyHomePage()},
    );
  }
}

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
        amount: 400.99,
        time: DateTime.now(),
        transactionType: TransactionType.Income),
    Transaction(
        id: 't1',
        title: 'Shirt',
        amount: -12,
        time: DateTime.now(),
        transactionType: TransactionType.Expense),
    Transaction(
        id: 't9',
        title: 'Pant',
        amount: -19,
        time: DateTime.now(),
        transactionType: TransactionType.Expense),
  ];

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
          onPressed: () {},
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
            height: (MediaQuery.of(context).size.height - appBar.preferredSize.height) * 0.4,
            child: Chart(transactionsList)),
          Container(
            height: (MediaQuery.of(context).size.height - appBar.preferredSize.height) * 0.6,
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
