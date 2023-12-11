import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'csvfile_platform_interface.dart';

/// An implementation of [CsvfilePlatform] that uses method channels.
class MethodChannelCsvfile extends CsvfilePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('csvfile');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
