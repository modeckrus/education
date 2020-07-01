import 'package:flutter/material.dart';

import 'dart:html';
import 'package:file_picker_web/file_picker_web.dart';

class Picker extends StatefulWidget {
  @override
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  List<File> _files = [];

  void _pickFiles() async {
    _files = await FilePicker.getMultiFile() ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: _files.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (BuildContext context, int index) =>
                        Text(_files[index].name),
                    itemCount: _files.length,
                    separatorBuilder: (_, __) => const Divider(
                      thickness: 5.0,
                    ),
                  )
                : Center(
                    child: Text(
                      'Pick some files',
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: _pickFiles,
              child: Text('Pick Files'),
            ),
          )
        ],
      ),
    );
  }
}
