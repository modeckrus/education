import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/settinguser_bloc.dart';

class SettingUserButton extends StatefulWidget {
  Duration duration = Duration(milliseconds: 500);
  Function onTap;
  SettingUserButton({Key key, this.duration, this.onTap}) : super(key: key);

  @override
  _SettingUserButtonState createState() => _SettingUserButtonState();
}

class _SettingUserButtonState extends State<SettingUserButton> {
  SettinguserBloc get bloc => BlocProvider.of<SettinguserBloc>(context);
  Color color = Colors.red;
  Widget icon = Icon(Icons.close);
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (context, state) {
        if (state is NextButtonOkS) {
          print('button ok');
          setState(() {
            color = Colors.teal;
            icon = Icon(Icons.check);
          });
        }
        if (state is NextButtonErrorS) {
          setState(() {
            color = Colors.redAccent;
            icon = Icon(Icons.error);
          });
        }
        if (state is NextButtonFailS) {
          setState(() {
            color = Colors.red;
            icon = Icon(Icons.close);
          });
        }
        if (state is NextButtonLoadingS) {
          setState(() {
            color = Colors.blueAccent;
            icon = CircularProgressIndicator();
          });
        }
      },
      bloc: bloc,
      child: GestureDetector(
        onTap: widget.onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: AnimatedContainer(
              width: 60,
              height: 60,
              color: color,
              duration: widget.duration,
              child: icon),
        ),
      ),
    );
  }
}

/*
BlocBuilder<SettinguserBloc, SettinguserState>(
      builder: (context, state) {
        if (state is NextButtonErrorS) {
          return ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: AnimatedContainer(
              width: 60,
              height: 60,
              duration: widget.duration,
              color: Colors.redAccent,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.error,
                    size: 30,
                  ),
                  Text('Error'),
                ],
              ),
            ),
          );
        }
        if (state is NextButtonFailS) {
          return ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: AnimatedContainer(
              width: 60,
              height: 60,
              color: Colors.red,
              duration: widget.duration,
              child: Icon(
                Icons.close,
                size: 30,
              ),
            ),
          );
        }
        if (state is NextButtonLoadingS) {
          return Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: AnimatedContainer(
                  color: Colors.blueAccent,
                  duration: widget.duration,
                  width: 60,
                  height: 60,
                  child: Icon(Icons.watch_later, size: 30,),
                ),
              ),
              SizedBox(
                height: 70,
                width: 70,
              ),
              CircularProgressIndicator(),
            ],
          );
        }
        if (state is NextButtonOkS) {
          return GestureDetector(
            onTap: widget.onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: AnimatedContainer(
                width: 60,
                height: 60,
                color: Colors.teal,
                duration: widget.duration,
                child: Icon(
                  Icons.done,
                  size: 30,
                ),
              ),
            ),
          );
        }
      },
    );
*/
