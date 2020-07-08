import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {

final String text;
final Function handler;
  AdaptiveButton(this.text, this.handler);
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
                      ? CupertinoButton(
                          color: Theme.of(context).accentColor,
                          child: Text(
                            text,
                            style: TextStyle(
                                color: Theme.of(context).textTheme.button.color,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: handler)
                      : RaisedButton(
                          color: Theme.of(context).accentColor,
                          child: Text(
                            text,
                            style: TextStyle(
                                color: Theme.of(context).textTheme.button.color,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: handler);
  }
}