import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTransaction extends StatelessWidget {


  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  void _onPressedAddTransaction() {
    print(titleController.text);
    print(amountController.text);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
//            TextField(
//              decoration: InputDecoration(hintText: 'Date Time'),
//              keyboardType: TextInputType.datetime,
//            ),
            TextFormField(
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
            TextFormField(
              decoration: InputDecoration(hintText: 'Amount'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: amountController,
            ),
            FlatButton(
              child: Text(
                'Add Transaction',
                style:
                    TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
              ),
              onPressed: _onPressedAddTransaction,
            )
          ],
        ),
      ),
    );
  }
}
