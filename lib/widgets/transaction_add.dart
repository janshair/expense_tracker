import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTransaction extends StatefulWidget {
  final Function clickHandler;

  AddTransaction(this.clickHandler);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  void _onClickAddTransaction(){
    if(titleController.text.isEmpty || amountController.text.isEmpty){
      return;
    }
    widget.clickHandler(titleController.text,
        double.parse(amountController.text));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
//            TextField(
//              decoration: InputDecoration(hintText: 'Date Time'),
//              keyboardType: TextInputType.datetime,
//            ),
            TextField(
              decoration: InputDecoration(hintText: 'Title'),
              keyboardType: TextInputType.text,
              controller: titleController,
//              validator: (value) {
//                if(value.isEmpty) {
//                  return 'title should not be empty';
//                }
//                return null;
//              },
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Amount'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: amountController,
              onSubmitted: (_) => _onClickAddTransaction,
            ),
            RaisedButton(
                color: Colors.blueAccent,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: _onClickAddTransaction)
          ],
        ),
      ),
    );
  }
}
