import 'package:animalCare/db/local_cache.dart';

var CURRENT_REGION =
  3;

const REGION_OVERSEA = 1;
const REGION_CN = 2;
//海外测试环境
const REGION_OVERSEA_TEST = 3;

//获取硬件服务器地址
String GetRtspAddress() {
  return "testlb-56520767.us-west-2.elb.amazonaws.com:6666";
}


String GetCurrentServerDomain() {
  return "testlb-56520767.us-west-2.elb.amazonaws.com:6666";
}

bool GetUseHTTPS(){
  return false;
}

