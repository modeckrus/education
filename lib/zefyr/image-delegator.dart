import 'dart:io';
import 'dart:math';

import 'package:education/service/fstorage-cache-manager.dart';
import 'package:education/widgets/image-widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zefyr/zefyr.dart';

class MyAppZefyrImageDelegate implements ZefyrImageDelegate<ImageSource> {
  const MyAppZefyrImageDelegate();
  @override
  Future<String> pickImage(ImageSource source) async {
    final file = await ImagePicker.pickImage(source: source);
    if (file == null) return null;
    //Get the user
    final user = GetIt.I.get<FirebaseUser>();
    final uri = user.uid + '/' + file.path.split('/').last;
    print(uri);
    final task = FirebaseStorage.instance.ref().child(uri).putFile(file);
    await task.onComplete;
    // We simply return the absolute path to selected file.
    return 'image±/' + uri;
  }

  @override
  Widget buildImage(BuildContext context, String key) {
    if (key.startsWith('super')) {
      print('wow works fine for me');
      return Text('Works suka');
    }
    if (key.startsWith('formula')) {
      print('formula robit eee');
      return Text(key.split('±/')[1] ?? '');
    }
    if (key.startsWith('image')) {
      print('Image rendering');
      return MyImage(fchild: key.split('±/')[1] ?? 'error.jpg');
    }
    // final file = File.fromUri(Uri.parse(key));

    // /// Create standard [FileImage] provider. If [key] was an HTTP link
    // /// we could use [NetworkImage] instead.
    // final image = FileImage(file);
    // return Image(image: image);
  }

  @override
  ImageSource get cameraSource => ImageSource.camera;

  @override
  ImageSource get gallerySource => ImageSource.gallery;
}
