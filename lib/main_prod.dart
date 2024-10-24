
import 'package:flutter/material.dart';

import 'app.dart';
import 'common/http/environment.dart';
import 'common/services/service_init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Environment.value = EnvironmentEnum.develop;
  await ServiceInitManager.init();
  runApp(const App());
}
