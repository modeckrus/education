import 'package:flutter/material.dart';

class CreateAnAccountButton extends StatelessWidget {
  final VoidCallback _onPressed;

  CreateAnAccountButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: _onPressed,
      child: Text('Sing Up'),
      color: Colors.redAccent,
    );
  }
}