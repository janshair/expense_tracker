import 'package:universal_io/io.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../model/transaction_type.dart';
import '../utils/money_calculator.dart';
import 'adaptive/adaptive_button.dart';

class AddTransaction extends StatefulWidget {
  final Function clickHandler;

  AddTransaction(this.clickHandler){
    print('Add Transaction Constructor');
  }

  @override
  _AddTransactionState createState(){
    print('_AddTransactionState createState() ');
    return _AddTransactionState();
  } 

}

class _AddTransactionState extends State<AddTransaction> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  String dropdownTransactionTypeValue = TransactionType.Expense.toString();
  _AddTransactionState(){
    print('Constructor Called');
  }

  @override
  void initState() {
    // TODO: implement initState
    print('initState()');
    super.initState();
  }

  @override
  void didUpdateWidget(AddTransaction oldWidget) {
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }
  void _onClickAddTransaction() {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      return;
    }
    TransactionType type =
        dropdownTransactionTypeValue == TransactionType.Expense.toString()
            ? TransactionType.Expense
            : TransactionType.Income;
    widget.clickHandler(_titleController.text,
        double.parse(_amountController.text), _selectedDate, type);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }

      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.transparent,
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: ((MediaQuery.of(context).viewInsets.bottom) + 10)),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Title'),
                    keyboardType: TextInputType.text,
                    controller: _titleController,
                    onFieldSubmitted: (_) => _onClickAddTransaction,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'title should not be empty';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Amount'),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    controller: _amountController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Value should not be empty';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) => _onClickAddTransaction,
                  ),
                  Row(
                    children: <Widget>[
                      Text(_selectedDate == null
                          ? 'No Date Chosen:'
                          : DateFormat.yMMMd().format(_selectedDate)),
                      FlatButton(
//                color: Theme.of(context).textTheme.headline6.color,
                        child: Text(
                          'Change Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: _presentDatePicker,
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Transaction Type'),
                      SizedBox(
                        width: 10,
                      ),
                      DropdownButton<String>(
                        value: dropdownTransactionTypeValue.toString(),
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: Theme.of(context).textTheme.headline6,
                        underline: Container(
                          height: 2,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownTransactionTypeValue = newValue;
                          });
                        },
                        items: TransactionType.values
                            .toList()
                            .map<DropdownMenuItem<String>>(
                                (TransactionType txType) {
                          return DropdownMenuItem<String>(
                            value: txType.toString(),
                            child: Text(txType.toString().split('.').last),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  AdaptiveButton('Add Transaction', _onClickAddTransaction),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
