import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double heightScreen = mediaQueryData.size.height;
    double paddingBottom = mediaQueryData.padding.bottom;

    return Scaffold(
      body: Container(
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
                bottom: paddingBottom > 0 ? paddingBottom : 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  _buildWidgetLabelCreateNewAccount(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetLabelCreateNewAccount(BuildContext context) {
    return Expanded(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                // TODO: do something in here
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
          ),
        ],
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
          // TODO: do something in here
        },
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildWidgetTextFieldPassword() {
    return TextField(
      keyboardType: TextInputType.text,
      obscureText: true,
    );
  }

  Widget _buildWidgetTextFieldEmailAddress() {
    return TextField(
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
