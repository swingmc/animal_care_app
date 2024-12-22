export 'package:animalCare/logger/firebase.dart';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:animalCare/logger/firebase.dart';


final GeneralLogger logger = GeneralLogger();

final _logger = Logger(
  printer: PrettyPrinter(),
  output: ConsoleOutput()
);
const bool useFirebase = false;


class GeneralLogger {
  void debug(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.log(Level.debug, message, error, stackTrace);
  }

  void info(dynamic message, {Moudle module = Moudle.UNKNOWN, ProblemType problemType = ProblemType.UNKNOWN, dynamic error, StackTrace? stackTrace}) {
    if(!kDebugMode&&useFirebase) {
      logCustomMessage(message, makeTags(LogLevel.INFO, module, problemType));
    }else{
      _logger.log(Level.info, message, error, stackTrace);
    }
  }

  void warning(dynamic message, {Moudle module = Moudle.UNKNOWN, ProblemType problemType = ProblemType.UNKNOWN, dynamic error, StackTrace? stackTrace}) {
    if(!kDebugMode&&useFirebase) {
      logCustomMessage(message, makeTags(LogLevel.WARNING, module, problemType));
    }else{
      _logger.log(Level.warning, message, error, stackTrace);
    }
  }

  void error(dynamic message, {Moudle module = Moudle.UNKNOWN, ProblemType problemType = ProblemType.UNKNOWN, dynamic error, StackTrace? stackTrace}) {
    if(!kDebugMode&&useFirebase) {
      logCustomMessage(message, makeTags(LogLevel.ERROR, module, problemType));
    }else{
      _logger.log(Level.error, message, error, stackTrace);
    }
  }

  void fatal(dynamic message, StackTrace stackTrace, {Exception? exception, Moudle moudle = Moudle.UNKNOWN, ProblemType problemType = ProblemType.UNKNOWN}) {
    if(!kDebugMode&&useFirebase) {
      logError(message, stackTrace, makeTags(LogLevel.FATAL, moudle, problemType), reason: exception?.toString());
    }else{
      print("message: " + message.toString() + "\nstack: " + "exception: " + exception.toString() + "\nstack: " + stackTrace.toString());
    }
  }
}