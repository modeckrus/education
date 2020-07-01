import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

/// Widget used to handle the management of
class Uploader extends StatefulWidget {
  final File file;
  final String uid;
  final String path;
  Uploader(
      {Key key, @required this.file, @required this.uid, @required this.path})
      : super(key: key);

  createState() => _UploaderState(uid);
}

class _UploaderState extends State<Uploader> {
  final String uid;
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://gvisionmodeck.appspot.com');

  StorageUploadTask _uploadTask;
  String storagePath;
  _UploaderState(this.uid);

  _startUpload() {
    storagePath =
        'users/$uid/${widget.file.path.split('/').last.split('.').first}/${widget.file.path.split('/').last}';

    setState(() {
      _uploadTask = _storage.ref().child(storagePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (context, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;
            if (_uploadTask.isComplete) {
              Navigator.pop(context, [widget.file.path, storagePath]);
            }
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_uploadTask.isComplete)
                    Text('🎉🎉🎉',
                        style: TextStyle(
                            color: Colors.greenAccent,
                            height: 2,
                            fontSize: 30)),
                  if (_uploadTask.isPaused)
                    FlatButton(
                      child: Icon(Icons.play_arrow, size: 50),
                      onPressed: _uploadTask.resume,
                    ),
                  if (_uploadTask.isInProgress)
                    FlatButton(
                      child: Icon(Icons.pause, size: 50),
                      onPressed: _uploadTask.pause,
                    ),
                  LinearProgressIndicator(value: progressPercent),
                  Text(
                    '${(progressPercent * 100).toStringAsFixed(2)} % ',
                    style: TextStyle(fontSize: 50),
                  ),
                ]);
          });
    } else {
      return FlatButton.icon(
          color: Colors.blue,
          label: Text('Upload to Firebase'),
          icon: Icon(Icons.cloud_upload),
          onPressed: _startUpload);
    }
  }
}
