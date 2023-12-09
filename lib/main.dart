import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_demo_satish/app_routes.dart';
import 'package:web_demo_satish/model/Services/get_storage_service.dart';
import 'package:web_demo_satish/navigation_service/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: GetStorageServices.getUserLoggedInStatus() == true
          ? AppRoutes.homeScreen
          : AppRoutes.loginScreen,
      onGenerateRoute: (settings) => OnGenerateRoutes.generateRoute(settings),
    );
  }
}
