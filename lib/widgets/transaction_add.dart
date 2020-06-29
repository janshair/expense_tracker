import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function clickHandler;

  AddTransaction(this.clickHandler);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _amountController = TextEditingController();

  DateTime _selectedDate= DateTime.now();

  void _onClickAddTransaction(){
    if(_titleController.text.isEmpty || _amountController.text.isEmpty){
      return;
    }
    widget.clickHandler(_titleController.text,
        double.parse(_amountController.text), _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime.now()).then((value) {
      if( value == null) {
        return;
      }

      setState(() {
        _selectedDate = value;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(hintText: 'Title'),
                keyboardType: TextInputType.text,
                controller: _titleController,
                onFieldSubmitted: (_) => _onClickAddTransaction,
                validator: (value) {
                  if(value.isEmpty) {
                    return 'title should not be empty';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Amount'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: _amountController,
                validator: (value) {
                  if(value.isEmpty) {
                    return 'Value should not be empty';
                  }
                  return null;
                },
                onFieldSubmitted: (_) => _onClickAddTransaction,
              ),
              Row(children: <Widget>[
                Text(_selectedDate == null ?'No Date Chosen:' :  DateFormat.yMMMd().format(_selectedDate)),
                FlatButton(
//                color: Theme.of(context).textTheme.headline6.color,
                  child: Text('Change Date',style: TextStyle(fontWeight: FontWeight.bold),),
                  onPressed: _presentDatePicker,)
              ],
              ),
              RaisedButton(
                  color: Colors.blueAccent,
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.button.color, fontWeight: FontWeight.bold),
                  ),
                  onPressed: _onClickAddTransaction)
            ],
          ),
        ),
      ),
    );
  }
}
