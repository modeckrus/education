
import 'package:education/localization/localizations.dart';
import 'package:education/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      icon: Icon(Icons.account_box),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: () {
        BlocProvider.of<LoginBloc>(context).add(
          LoginWithGoogleButtonPressedE(),
        );
      },
      label: Text(AppLocalizations.of(context).singinwithgoogle , style: TextStyle(color: Colors.white)),
      color: Colors.redAccent,
    );
  }
}
