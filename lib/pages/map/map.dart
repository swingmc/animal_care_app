import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:animalCare/logger/logger.dart';
import 'package:animalCare/main.dart';
import 'package:animalCare/model/my_marker.dart';




const DeerPath = "assets/animal/deer.jpeg";

final List<MyMarker> MyMarkers =  [
  MyMarker("A injured deer", "it's leg is broken, need rescue", "assets/animal/deer.png", 52.0919, 5.1230),
  MyMarker("A bird", "a bird with head blooded", "assets/animal/bird.png", 52.0705, 4.3007),
  MyMarker("A homeless fox", "need food", "assets/animal/fox.png", 52.3676, 4.9041),
  MyMarker("A died tiger", "need funeral", "assets/animal/tiger.png", 52.1676, 4.6041),
  MyMarker("A injureed bird", "need rescue", "assets/animal/bird2.png", 51.5705, 4.5007),
];




// 定义一个异步函数来获取当前位置
Future<LocationData?> getCurrentLocation() async {
  // 创建Location实例
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  // 检查位置服务是否启用
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    // 如果未启用，请求启用位置服务
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      // 用户未启用位置服务，返回null
      return null;
    }
  }

  // 检查位置权限
  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    // 如果权限被拒绝，请求权限
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      // 用户未授予权限，返回null
      return null;
    }
  }

  // 获取当前位置
  LocationData _locationData = await location.getLocation();
  print(_locationData.latitude);
  print(_locationData.longitude);
  logger.error("latitude: ${_locationData.latitude}");
  logger.error("longitude: ${_locationData.longitude}");

  shareMediaProvider.setLatitude(_locationData.latitude!);
  shareMediaProvider.setLongitude(_locationData.longitude!);

  return _locationData;
}


class OldMapPage extends StatefulWidget {
  @override
  _OldMapPageState createState() => _OldMapPageState();
}

class _OldMapPageState extends State<OldMapPage> {
  final Location location = Location();
  GoogleMapController? mapController;
  LatLng? currentLocation;
  Set<Marker> _markers = {}; // 添加一个存储标记的集合

  @override
  void initState() {
    super.initState();
    initMap();
  }

  void initMap() async {
    _getLocation();
  }

  void _getLocation() async {
    var _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    var _locationData = await location.getLocation();
    currentLocation = LatLng(_locationData.latitude!, _locationData.longitude!);

    await _setCustomMarkerIcon();

    setState(() {
      currentLocation = LatLng(_locationData.latitude!, _locationData.longitude!);
    });

    if (mapController != null && currentLocation != null) {
      mapController!.animateCamera(CameraUpdate.newLatLng(currentLocation!));
    }

    logger.error("latitude: ${_locationData.latitude}");
    logger.error("longitude: ${_locationData.longitude}");

  }


  void _addMarkerWithGraph(LatLng position, String title, String description, String path) async {
    final marker = Marker(
        markerId: MarkerId(title),
        position: position,
        infoWindow: InfoWindow(
          title: title,
          snippet: description,
        ),
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(40, 40)),
            // 可以指定加载图片的配置，如大小
            path,
            mipmaps: false
        )
    );

    setState(() {
      _markers.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: currentLocation == null
          ? Center(child: CircularProgressIndicator())
          :  GoogleMap(
          initialCameraPosition: CameraPosition(
            target: currentLocation!,
            zoom: 15,
          ),
          onMapCreated: (GoogleMapController controller) async {
            logger.error("latitude");
            logger.error(currentLocation!.latitude);
            mapController = controller;


          },
          markers: _markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        ),
    );
  }

  // 如果要使用自定义图片作为图标，可以使用这个方法

  Future<void> _setCustomMarkerIcon() async {


    for (var marker in MyMarkers) {
      BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)),
        marker.path, // 确保在pubspec.yaml中添加这个资源
      );

      final marker2 = Marker(
        markerId: MarkerId("custom_marker"),
        position: LatLng(marker.lati, marker.longti),
        infoWindow: InfoWindow(
          title: marker.title,
          snippet: marker.desc,
        ),
        icon: customIcon,
      );

      setState(() {
        _markers.add(marker2);
      });

    }







  }





  void _addMarker(LatLng position, String title, String description) async {
    final BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(10, 5)),
        // 可以指定加载图片的配置，如大小
        'assets/images/marker.png',
        mipmaps: false
    );

    void _addMarkerWithGraph(LatLng position, String title, String description, String path) async {
      final marker = Marker(
          markerId: MarkerId(title),
          position: position,
          infoWindow: InfoWindow(
            title: title,
            snippet: description,
          ),
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(size: Size(40, 40)),
              // 可以指定加载图片的配置，如大小
              path,
              mipmaps: false
          )
      );

      setState(() {
        _markers.add(marker);
      });
    }




    final marker = Marker(
      markerId: MarkerId(title),
      position: position,
      infoWindow: InfoWindow(
        title: title,
        snippet: description,
      ),
      icon: customIcon, // 使用默认标记但改变颜色
    );

    setState(() {
      _markers.add(marker);
    });
  }
}
