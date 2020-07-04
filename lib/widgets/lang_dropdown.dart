import 'package:education/service/lang-codes.dart';
import 'package:flutter/material.dart';

class LangDropDownButton extends StatefulWidget {
  final Function onlangchange;
  const LangDropDownButton({Key key, @required this.onlangchange})
      : super(key: key);
  @override
  _LangDropDownButtonState createState() => _LangDropDownButtonState();
}

class _LangDropDownButtonState extends State<LangDropDownButton> {
  String lang = 'en';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: lang,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        widget.onlangchange(newValue);
        setState(() {
          lang = newValue;
        });
      },
      items: LangCodes.codes.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        );
      }).toList(),
    );
  }
}
