import 'package:flutter/material.dart';
import 'package:technical_test_propnext/config/flavor_config.dart';
import 'package:technical_test_propnext/config/network_constans.dart';
import 'package:technical_test_propnext/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlavorConfig(
    flavor: Flavor.development,
    baseUrl: NetworkConstants.BASE_URL_DEV,
  );
  runApp(MainPage());
}
