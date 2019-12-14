import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_oauth/src/bloc/register/register_bloc.dart';
import 'package:flutter_sample_oauth/src/model/register/register.dart';
import 'package:flutter_sample_oauth/src/widget/widget_card_loading.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterBloc _registerBloc = RegisterBloc();
  final TextEditingController _controllerEmailAddress = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RegisterBloc>(
        create: (context) => _registerBloc,
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterFailure) {
              showDialog(
                  context: context,
                  builder: (context) {
                    String title = 'Oops...';
                    String content = state.error;
                    if (Platform.isIOS) {
                      return CupertinoAlertDialog(
                        title: Text(title),
                        content: Text(content),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('Try Again'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      );
                    } else {
                      return AlertDialog(
                        title: Text(title),
                        content: Text(content),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Try Again'),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      );
                    }
                  });
            } else if (state is RegisterSuccess) {
              showDialog(
                context: context,
                builder: (context) {
                  String title = 'Info';
                  String content = 'Register successfully';
                  if (Platform.isIOS) {
                    return CupertinoAlertDialog(
                      title: Text(title),
                      content: Text(content),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: Text('Ok'),
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context, '/login_screen', (r) => false);
                          },
                        ),
                      ],
                    );
                  } else {
                    return AlertDialog(
                      title: Text(title),
                      content: Text(content),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Ok'),
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context, '/login_screen', (r) => false);
                          },
                        )
                      ],
                    );
                  }
                },
              );
            }
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildWidgetSizedBox(24.0),
                      _buildWidgetTitle(context),
                      _buildWidgetSizedBox(24.0),
                      _buildWidgetLabel(context, 'EMAIL ADDRESS'),
                      _buildWidgetTextFieldEmailAddress(),
                      _buildWidgetSizedBox(16.0),
                      _buildWidgetLabel(context, 'PASSWORD'),
                      _buildWidgetTextFieldPassword(),
                      _buildWidgetSizedBox(16.0),
                      _buildWidgetLabel(context, 'AGE'),
                      _buildWidgetTextFieldAge(),
                      _buildWidgetSizedBox(16.0),
                      _buildWidgetButtonSignup(context),
                    ],
                  ),
                ),
                _buildWidgetLoading(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetTextFieldAge() {
    return TextField(
      controller: _controllerAge,
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildWidgetLoading() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        if (state is RegisterLoading) {
          return WidgetCardLoading();
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildWidgetButtonSignup(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        child: Text(
          'SIGNUP',
          style: TextStyle(color: Colors.white),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          String username = _controllerEmailAddress.text.trim();
          String password = _controllerPassword.text.trim();
          String strAge = _controllerAge.text.trim();
          int age = strAge.isEmpty ? 0 : int.parse(strAge);
          _registerBloc.add(RegisterEvent(Register(age, username, password)));
        },
      ),
    );
  }

  Widget _buildWidgetTextFieldPassword() {
    return TextField(
      controller: _controllerPassword,
      keyboardType: TextInputType.text,
      obscureText: true,
    );
  }

  Widget _buildWidgetTextFieldEmailAddress() {
    return TextField(
      controller: _controllerEmailAddress,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildWidgetLabel(BuildContext context, String label) {
    return Text(
      label,
      style: Theme.of(context).textTheme.subtitle.merge(
            TextStyle(
              color: Colors.grey,
            ),
          ),
    );
  }

  Widget _buildWidgetTitle(BuildContext context) {
    return Center(
      child: Text(
        'Create your free account.',
        style: Theme.of(context).textTheme.title.merge(
              TextStyle(fontWeight: FontWeight.bold),
            ),
      ),
    );
  }

  Widget _buildWidgetSizedBox(double height) => SizedBox(height: height);
}
