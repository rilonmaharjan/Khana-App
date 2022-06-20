import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  Future<FirebaseRemoteConfig> setRemoteConfig() async {
    FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 30),
        minimumFetchInterval: const Duration(seconds: 10)));

    _remoteConfig.setDefaults(<String, dynamic>{
      'updateModel': true,
      'welcome': 'Khana Ghar',
      'screenView': '''{
        "size": 18.0,
        "iconSize": 20.0,
        "text": "Khana Ghar"
      }''',
    });

    _remoteConfig.fetchAndActivate();
    return _remoteConfig;
  }
}
