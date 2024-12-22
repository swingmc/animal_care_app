import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:animalCare/model/my_marker.dart';

class ShareMediaProvider with ChangeNotifier {

  String imagePath = '';

  double latitude = 0.0;
  double longitude = 0.0;

  void setImagePath(String path) {
    imagePath = path;
  }

  void setLatitude(double lat) {
    latitude = lat;
  }
  void setLongitude(double longti) {
    longitude = longti;
  }


  //List<MyMarker> _mediaList = [];
  List<MyMarker> mediaList = [
    MyMarker("A injured deer", "it's leg is broken, need rescue", "assets/animal/deer.png", 52.0919, 5.1230),
    MyMarker("A bird", "a bird with head blooded", "assets/animal/bird.png", 52.0705, 4.3007),
    MyMarker("A homeless fox", "need food", "assets/animal/fox.png", 52.3676, 4.9041),
    MyMarker("A died tiger", "need funeral", "assets/animal/tiger.png", 52.1676, 4.6041),
    MyMarker("A injureed bird", "need rescue", "assets/animal/bird2.png", 51.5705, 4.5007),
  ];

  TextEditingController _controller = TextEditingController();


  //List<MyMarker> get mediaList => _mediaList;

  TextEditingController get controller => _controller;

  Future<void> initMediaList() async {
    notifyListeners();
  }

  void addMarker(MyMarker marker) {
    mediaList.add(marker);
    notifyListeners();
  }

}