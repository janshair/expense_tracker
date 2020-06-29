import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {

  final String label;
  final double amount;
  final double pctOfTotal;


  ChartBar(this.label, this.amount, this.pctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 10,
          child: FittedBox(
              child: Text(this.amount.toStringAsFixed(0))),
        ),
        SizedBox(height: 5,),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey,
                      width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: pctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),

        ),
        Text(label.substring(0,1)),

      ],
    );
  }
}
