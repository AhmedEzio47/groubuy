import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:groubuy/pages/app_page.dart';
import 'package:groubuy/services/apple_signIn_available.dart';
import 'package:groubuy/services/auth.dart';
import 'package:groubuy/services/auth_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appleSignInAvailable = await AppleSignInAvailable.check();
  await Firebase.initializeApp();
  runApp(Provider<AppleSignInAvailable>.value(
    value: appleSignInAvailable,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AppPage(),
      ),
    );
  }
}
