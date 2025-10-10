import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdHelper {
  static String get interstitialUnitId {
    if (Platform.isAndroid) {
      return dotenv.env['ANDROID_INTERSTITIAL_ID'] ?? '';
    } else if (Platform.isIOS) {
      return dotenv.env['IOS_INTERSTITIAL_ID'] ?? '';
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerUnitId {
    if (Platform.isAndroid) {
      return dotenv.env['ANDROID_BANNER_ID'] ?? '';
    } else if (Platform.isIOS) {
      return dotenv.env['IOS_BANNER_ID'] ?? '';
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
