import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:animalCare/db/local_cache.dart';
import 'package:animalCare/util/export_file.dart';
import 'package:animalCare/logger/logger.dart';
import 'package:animalCare/util/assets_path.dart';

Future<String> getDocPath() async {
  return (await getApplicationDocumentsDirectory()).path;
}

checkDir(String path) async {
  bool isDirExist = await Directory(path).exists();
  if (!isDirExist) {
    Directory(path).create();
  }
}

Future<String> getUserDir() async {
  var usrId = LocalCache.getInstance().get(USER_ID);
  var userPrivacyDirPath = "${await getDocPath()}/$usrId";
  checkDir(userPrivacyDirPath);
  return userPrivacyDirPath;
}

Future<String> getDeviceDirPath(String deviceNo) async {
  var deviceDirPath = "${await getUserDir()}/$deviceNo";
  checkDir(deviceDirPath);
  return deviceDirPath;
}

Future<String> getBirdBookDirPath(String deviceNo) async {
  var birdBookDirPath = "${await getDeviceDirPath(deviceNo)}/$BIRD_BOOK_DIR";
  checkDir(birdBookDirPath);
  return birdBookDirPath;
}

Future<String> getCollectionDirPath(String deviceNo) async {
  var birdBookDirPath = "${await getDeviceDirPath(deviceNo)}/$BIRD_COLLECTION_DIR";
  checkDir(birdBookDirPath);
  return birdBookDirPath;
}

Future<String> getCollectionBirdDirPath(String deviceNo, String birdName) async {
  var collectionBirdDirPath = "${await getCollectionDirPath(deviceNo)}/$birdName";
  checkDir(collectionBirdDirPath);
  return collectionBirdDirPath;
}


Future<String> getLocalAvatarPath(int imageId) async {
  String userDir = await getUserDir();
  String avatarDir = "$userDir/avatar";
  return '$avatarDir/avatar_${imageId}.jpg';
}

Future<Image?> readLocalUserAvatar(int imageId) async {
  if(imageId == 0){
    return DEFAULT_AVATAR;
  }

  try {
    String avatarPath = await getLocalAvatarPath(imageId);
    File imageFile = File(avatarPath);
    if (!await imageFile.exists()) {
      return null; // File does not exist, return null or a default image
    }

    Image avatar = Image.file(imageFile);
    return avatar;
  } catch (e) {
    logger.error('Error reading image: $e');
    return null; // Return null or a default image in case of an error
  }
}


void saveUserAvatar(int imageId, Uint8List imageData) async {
  String userDir = await getUserDir();
  //logger.error("saveUserAvatar");
  String avatarDir = "$userDir/avatar";
  checkDir(avatarDir);
  if (imageData != null) {
    final File newImage = File('$avatarDir/avatar_${imageId}.jpg');
    await newImage.writeAsBytes(imageData);
  }
}