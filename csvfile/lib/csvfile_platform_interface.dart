import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'csvfile_method_channel.dart';

abstract class CsvfilePlatform extends PlatformInterface {
  /// Constructs a CsvfilePlatform.
  CsvfilePlatform() : super(token: _token);

  static final Object _token = Object();

  static CsvfilePlatform _instance = MethodChannelCsvfile();

  /// The default instance of [CsvfilePlatform] to use.
  ///
  /// Defaults to [MethodChannelCsvfile].
  static CsvfilePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CsvfilePlatform] when
  /// they register themselves.
  static set instance(CsvfilePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
