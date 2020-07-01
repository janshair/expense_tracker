import 'package:flutter_test/flutter_test.dart';
import 'package:expensetracker/utils/text_validators.dart';

void main(){
 group("Validate Email Addresses",() {
    test("Email is not valid", () {
      expect("actual".isEmailValid(), false);
    });

    test("Name is not valid", () {
      expect("actual@".isEmailValid(), false);
    });

    test("Name is not valid", () {
      expect("actual@abc".isEmailValid(), false);
    });

   test("Name is not valid", () {
     expect("actual@abc.com".isEmailValid(), true);
   });

 });
}