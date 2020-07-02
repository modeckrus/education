import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class FStoreCacheManager extends BaseCacheManager {
  static const key = "customCache";

  static FStoreCacheManager _instance;

  factory FStoreCacheManager() {
    if (_instance == null) {
      _instance = new FStoreCacheManager._();
    }
    return _instance;
  }

  FStoreCacheManager._()
      : super(key,
            maxAgeCacheObject: Duration(days: 7), maxNrOfCacheObjects: 20);

  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return p.join(directory.path, key);
  }

  Future<File> getFStoreFile(String childpath) async {
    final fileinfo = await getFileFromCache(childpath);
    print(fileinfo);
    if (fileinfo == null) {
      final data = await FirebaseStorage.instance
          .ref()
          .child(childpath)
          .getData(20 * 1024);
      final file = await putFile(childpath, data);
      return file;
    }
    return fileinfo.file;
  }
}
