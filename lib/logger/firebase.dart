import 'package:firebase_crashlytics/firebase_crashlytics.dart';

enum LogLevel{DEBUG, INFO, WARNING, ERROR, FATAL}

enum Moudle{LOGIN, REGISTER, HOMEPAGE, ADD_DEVICE, USER_CENTER, OTHER, UNKNOWN}

enum ProblemType{NETWORK, SYSTEM, OTHER, UNKNOWN}

Map<String, String> makeTags(logLevel, module, problemType, {dynamic userId}){
  return {
    "logLevel":logLevel.toString(),
    "module":module.toString(),
    "problemType":problemType.toString(),
    "userId":userId?userId.toString():"unknown",
  };
}

final _firebaseLogger = FirebaseCrashlytics.instance;

// for non-fatal events and messages
void logCustomMessage(String message, Map<String,String> tags) {
  tags.forEach((key, value) {
    FirebaseCrashlytics.instance.setCustomKey(key, value);
  });
  FirebaseCrashlytics.instance.log(message);
}

void logError(Exception exception, StackTrace stackTrace, Map<String,String> tags, {dynamic reason}) {
  tags.forEach((key, value) {
    FirebaseCrashlytics.instance.setCustomKey(key, value);
  });
  FirebaseCrashlytics.instance.recordError(exception, stackTrace, reason: reason);
}