
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
            fontSize: 18
          )
        ) ,
        appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20,
          )
        ))
      ),
      home: MyHomePage(),
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

  final List<Transaction> transactionsList = [];


  List<Transaction> get recentTransactions {
    return transactionsList.where((transaction) => transaction.time.isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();
  }



  void _addTransaction(String txTitle, double txAmount) {
    final Transaction transaction = Transaction(
        title: txTitle,
        amount: txAmount,
        id: DateTime.now().toString(),
        time: DateTime.now());
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _onPressedAddTransaction(context),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Chart(transactionsList),
          TransactionView(transactions: transactionsList),
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
