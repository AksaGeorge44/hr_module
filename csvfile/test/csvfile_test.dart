import 'package:flutter_test/flutter_test.dart';
import 'package:csvfile/csvfile_platform_interface.dart';
import 'package:csvfile/csvfile_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCsvfilePlatform
    with MockPlatformInterfaceMixin
    implements CsvfilePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CsvfilePlatform initialPlatform = CsvfilePlatform.instance;

  test('$MethodChannelCsvfile is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCsvfile>());
  });

  test('getPlatformVersion', () async {
    CsvfilePlatform.instance = MockCsvfilePlatform(); // Set the platform interface to your mock implementation
    expect(await CsvfilePlatform.instance.getPlatformVersion(), '42');
  });
}
