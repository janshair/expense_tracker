
import 'package:flutter_test/flutter_test.dart';
import 'package:expensetracker/model/transaction.dart';
import 'package:expensetracker/utils/money_calculator.dart';


void main() {
  final List<Transaction> transactionsList = [
    Transaction
      (
        id: 't1',
        title: 'New Shoes',
        amount: 69.99,
        time: DateTime.now()
    ),

    Transaction
      (
        id: 't2',
        title: 'New Trousers',
        amount: 40.99,
        time: DateTime.now()
    ),

    Transaction
      (
        id: 't3',
        title: 'Loan',
        amount: -40.99,
        time: DateTime.now()
    ),
  ];

  group("Calculating balances", (){
    test("0 index returns amount", () {
      expect(MoneyCalculator.calculateBalance(transactionsList, 0), transactionsList[0].amount);
    });
    test("1 index returns balance", () {
      expect(MoneyCalculator.calculateBalance(transactionsList, 1), transactionsList[1].amount+transactionsList[0].amount);
    });


    test("last index returns sum of all", () {
      expect(MoneyCalculator.calculateBalance(transactionsList, transactionsList.length - 1), transactionsList.fold(0, (previousValue, element) => previousValue + element.amount));
    });
  });
  
}