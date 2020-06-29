import '../model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionView extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionView({@required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        child: transactions.isEmpty ? Column(children: <Widget>[
          Text('No Transactions yet'),
          SizedBox(height: 20,),
          Container(
              height: 200,
              child: Image.asset('assets/image/waiting.png', fit: BoxFit.cover,))
        ],) : ListView.builder(itemBuilder: (ctx, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: Dismissible(
              key: Key(transactions[index].id) ,
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {},
              background: Container(
                color: Colors.red,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Colors.white,),),
              ),
              secondaryBackground: Container(
              color: Colors.black,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.map, color: Colors.white,),),
            ),

              child: ListTile(
                leading: CircleAvatar(radius: 30, child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FittedBox(child: Text(transactions[index].amount.toStringAsFixed(0))),
                ),
                ),
                title: Text(transactions[index].title, style: Theme.of(context).textTheme.headline6,),
                subtitle: Text(DateFormat.yMMMd().format(transactions[index].time)),
                trailing: Text('£${transactions[index].amount}', style: TextStyle(color: getTransactionViewColor(context, transactions[index])),),
              ),
            ),
          );
        },
        itemCount: transactions.length,),
      ),
    );
  }

  Color getTransactionViewColor(BuildContext context, Transaction transaction) =>
      transaction.amount > 0 ? Theme.of(context).primaryColor : Colors.red;
}
