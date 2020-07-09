import 'package:expensetracker/model/screen_state.dart';
import 'package:expensetracker/widgets/adaptive/adaptive_button.dart';
import 'package:expensetracker/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/text_validators.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  ScreenState screenState = ScreenState.NONE;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _onClickLogin() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    setState(() {
      screenState = ScreenState.LOADING;
    });
    print('Start Login');
  }

  @override
  Widget build(BuildContext context) {
    var _isSignUpPage = true;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: screenState == ScreenState.LOADING
              ? LoadingScreen()
              : Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(hintText: 'Email'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Email should not be empty';
                          } else if (!value.isEmailValid()) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(hintText: 'Password'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password should not be empty';
                          } else if (_confirmPasswordController.value.toString() !=
                                _passwordController.value.toString()) {
                              return 'Passwords do not match';
                            }
                          return null;
                        },
                      ),
                      Visibility(
                        visible: _isSignUpPage ? true : false,
                        child: TextFormField(
                          obscureText: true,
                          controller: _confirmPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration:
                              InputDecoration(hintText: 'Confirm Password'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Confirm Password should not be empty';
                            } else if (_confirmPasswordController.value.toString() !=
                                _passwordController.value.toString()) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ),
                      AdaptiveButton('Login',_onClickLogin),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
