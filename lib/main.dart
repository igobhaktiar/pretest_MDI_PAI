import 'package:flutter/material.dart';
import 'package:pretest_mdi_pai/controller/login_controller.dart';
import 'package:pretest_mdi_pai/pages/home_page.dart';
import 'package:pretest_mdi_pai/pages/login_page.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';


List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => LoginController()),
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  final MyApp myApp = MyApp(
    initialRoute: (token != null) ? HomePage.routeName : LoginPage.routeName,
  );
  runApp(myApp);
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.initialRoute});
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  // This widget is the root of your application.
  final String initialRoute;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        routes: {
          'home' : (context) => const HomePage(),
          'login' : (context) => const LoginPage(),
        },
        navigatorKey: navigatorKey,
      ),

    );
  }
}
