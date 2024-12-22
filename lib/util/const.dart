import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:animalCare/util/assets_path.dart';
import 'package:animalCare/util/debug_env.dart';
import 'color.dart';




const String TOKEN_KEY = "user_token";
const String USER_ID = "user_id";
const String USER_NAME = "user_name";

const String USER_READ_MARK = "user_read_mark";
const String USER_READ_MESSAGES = "user_read_messages";

const DOMAIN_HOST = "101.33.230.162:7777";

var RTSP_DOMAIN_HOST = GetRtspAddress();

const HTTPS_PREFIX = "https://";
const HTTP_PREFIX = "http://";

const LOGIN_PATH = "/api/v1/login";
const REGISTER_PATH = "/api/v1/register";


///bird_book为本地录制/拍照
///collection为云视频/照片
const BIRD_BOOK_DIR = "bird_book";
const BIRD_COLLECTION_DIR = "bird_collection";
const String COLLECTION_LOACL_PAGE = "local_collection_page";
const String COLLECTION_BIRD_PAGE = "bird_collection_page";

const TEST_RTSP_URL = "rtsp://101.33.230.162:8554/230500001";

typedef ShareType = int;

const int VIDEO_ALBUM_PAGE = 1;
const int VIDEO_CLOUD_PAGE = 2;
const int VIDEO_SHARE_PAGE = 3;

const int IDENTIFY_OTHER_ANIMAL = -1;
const int IDENTIFY_BACKGROUND = -2;
const int IDENTIFY_UNKONW_BIRD = -3;

const ShareType Binding = 1; // 绑定
const ShareType Share   = 2; // 共享
const ShareType ShareTo = 3; // 共享给别人的设备 仅用于查询参数区分

const int COLLECTION_VIDEO_TYPE = 1;
const int COLLECTION_PHOTO_TYPE = 2;

const openDeviceMsg = 1000;
const bindDeviceMsg = 1001;
const openStreamingMsg = 1002;
const closeStreamingMsg = 1003;


const String OPEN_STREAMING_EVENT = "open_streaming";
const String CLOSE_STREAMING_EVENT = "close_streaming";
const String OPEN_DEVICE_EVENT = "open_device";
const String TAKE_SNAPSHOT = "take_snapshot";

const String KEY_HOME_GUIDE_POPPED = "home_guide_popped";
const String KEY_ALBUM_GUIDE_POPPED = "album_guide_popped";
const String KEY_PROFILE_GUIDE_POPPED = "profile_guide_popped";

const String KEY_DISCOVERY_POP = "discovery_pop";
const String KEY_FEEDBACK_POP = "feedback_pop";
const String KEY_CLOUD_POP = "cloud_pop";
const String KEY_CHAT_USER_MESSAGE = 'userMessage';
const String KEY_CHAT_ASSISTANT_MESSAGE = 'assistantMessage';
const String KEY_ILLUSTRATED_BOOK_VERSION = 'illustrated_version';
const String KEY_ILLUSTRATED_BOOK_COVER_LIST = 'illustrated_cover_list';

const String CHAT_ROLE_USER= "user";
const String CHAT_ROLE_AI = "assistant";

const String GOOGLE_STORE_ID = "com.mc.app.animal_care";
const String APPLE_STORE_ID = "6450153813";

const List<String> deviceAvatarList = [
  EQUIPMENT_HEAD_PORTRAI_1,
  EQUIPMENT_HEAD_PORTRAI_2,
  EQUIPMENT_HEAD_PORTRAI_3,
  EQUIPMENT_HEAD_PORTRAI_4,
  EQUIPMENT_HEAD_PORTRAI_5,
  EQUIPMENT_HEAD_PORTRAI_6,
  EQUIPMENT_HEAD_PORTRAI_7,
  EQUIPMENT_HEAD_PORTRAI_8,
];

const List<Color> deviceCardColor = [
  cloudCardColor_1,
  cloudCardColor_2,
  cloudCardColor_3,
  cloudCardColor_4,
  cloudCardColor_5,
  cloudCardColor_6,
  cloudCardColor_7,
  cloudCardColor_8,
];

const List<String> largeModeCardImagePath = [
  BIRDBOOK_ALBUM,
  BIRDBOOK_VIDEO,
  BIRDBOOK_CLOUD,
  BIRDBOOK_PUBLISH
];

const List<String> largeModeCardLabel = [
  'Photo',
  'Video',
  'Replay',
  'Share'
];

const int MAX_PHOTO_LENGTH = 9;
const int MAX_VIDEO_LENGTH = 9;


// TODO right mapping
enum FeedbackCategory {Network, Connection, Register, Push, Identification, Others}

FeedbackCategory getEnumFromString(String value) {
  return FeedbackCategory.values.firstWhere(
        (type) => type.toString().split('.').last == value,
    orElse: () => FeedbackCategory.Others,
  );
}