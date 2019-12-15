import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_oauth/src/bloc/login/login_bloc.dart';
import 'package:flutter_sample_oauth/src/model/login/login_body.dart';
import 'package:flutter_sample_oauth/src/widget/widget_card_loading.dart';

class LoginScreen extends StatelessWidget {
  final LoginBloc _loginBloc = LoginBloc();
  final TextEditingController _controllerEmailAddress = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double heightScreen = mediaQueryData.size.height;
    double paddingBottom = mediaQueryData.padding.bottom;
    
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => _loginBloc,
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              String title = 'Info';
              showDialog(
                context: context,
                builder: (context) {
                  if (Platform.isIOS) {
                    return CupertinoAlertDialog(
                      title: Text(title),
                      content: Text(state.error),
                    );
                  } else {
                    return AlertDialog(
                      title: Text(title),
                      content: Text(state.error),
                    );
                  }
                },
              );
            } else if (state is LoginSuccess){
              Navigator.pushNamedAndRemoveUntil(context, '/dashboard_user_screen', (r) => false);
            }
          },
          child: Container(
            color: Colors.white,
            height: double.infinity,
            child: Stack(
              children: <Widget>[
                _buildWidgetImageHeader(heightScreen),
                _buildWidgetOverlayBackgroundImageHeader(heightScreen),
                _buildWidgetRectangleWhite(heightScreen),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: paddingBottom == 0 ? 16.0 : paddingBottom,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            _buildWidgetSizedBox(heightScreen / 2.6),
                            _buildWidgetTitleLogin(context),
                            _buildWidgetSizedBox(16.0),
                            _buildWidgetLabel(context, 'EMAIL ADDRESS'),
                            _buildWidgetTextFieldEmailAddress(),
                            _buildWidgetSizedBox(16.0),
                            _buildWidgetLabel(context, 'PASSWORD'),
                            _buildWidgetTextFieldPassword(),
                            _buildWidgetSizedBox(16.0),
                            _buildWidgetButtonSignin(context),
                          ],
                        ),
                      ),
                      _buildWidgetLabelCreateNewAccount(context),
                    ],
                  ),
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return WidgetCardLoading();
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetLabelCreateNewAccount(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/register_screen');
        },
        child: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: 'Don\'t have account? ',
              ),
              TextSpan(
                text: 'Create new account.',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetButtonSignin(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        child: Text(
          'Signin',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          String username = _controllerEmailAddress.text.trim();
          String password = _controllerPassword.text.trim();
          _loginBloc.add(LoginEvent(LoginBody(username, password, 'password')));
        },
        color: Theme.of(context).primaryColor,
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

  Widget _buildWidgetTitleLogin(BuildContext context) {
    return Text(
      'Login',
      style: Theme.of(context).textTheme.title.merge(
            TextStyle(
              fontSize: 24.0,
            ),
          ),
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

  Widget _buildWidgetSizedBox(double height) => SizedBox(height: height);

  Widget _buildWidgetRectangleWhite(double heightScreen) {
    return Container(
      height: heightScreen / 2.4,
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 20.0,
        color: Colors.white,
      ),
    );
  }

  Widget _buildWidgetOverlayBackgroundImageHeader(double heightScreen) {
    return Container(
      height: heightScreen / 2.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.white.withOpacity(1.0),
            Colors.white.withOpacity(0.1),
          ],
          stops: [
            0.1,
            0.5,
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetImageHeader(double heightScreen) {
    return Container(
      height: heightScreen / 2.5,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/image_header.png'),
        fit: BoxFit.cover,
      )),
    );
  }
}
