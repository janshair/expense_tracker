import '../model/transaction.dart';
class MoneyCalculator{

static double calculateBalance(List<Transaction> transactions, int currentIndex) {
  final Transaction currentTransaction = transactions[currentIndex];
  if(currentIndex == 0) {
    return currentTransaction.amount;
  } else {
    return currentTransaction.amount + transactions.getRange(0, currentIndex).fold(0, (previousValue, element) => previousValue + element.amount);
  }

}

static double getSum(List<Transaction> transactions, int index) {
  double sum = 0;
  for(int i = 0; i<index; i++ ) {
    sum+=transactions[i].amount;
  }
  return sum;
}

}

extension NegitiveValues on double {
  double get removeNegitive => this < 0 ? this * -1 : this;
  double get addNegitive => this > 0 ? this * -1 : this;
}