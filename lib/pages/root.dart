import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:groubuy/app_util.dart';
import 'package:groubuy/constants/colors.dart';
import 'package:groubuy/constants/constants.dart';
import 'package:groubuy/pages/app_page.dart';
import 'package:groubuy/services/auth.dart';
import 'package:groubuy/services/database_service.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool emailVerified;

  AuthStatus _authStatus = AuthStatus.NOT_DETERMINED;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await authAssignment();
  }

  @override
  void initState() {
    getLanguage();
    super.initState();
  }

  getLanguage() async {
    String language = await AppUtil.getLanguage();
    if (language == null) {
      Constants.language = 'ar';
    } else {
      Constants.language = language;
    }
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        color: MyColors.primaryColor,
        alignment: Alignment.center,
        child: Center(
            //
            child: SpinKitCubeGrid(
          color: MyColors.primaryColor,
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
      case AuthStatus.NOT_LOGGED_IN:
        //return WelcomePage();
        return AppPage();
      case AuthStatus.LOGGED_IN:
        return AppPage();
    }
    return null;
  }

  Future authAssignment() async {
    User user = await Auth().getCurrentUser();

    if (user?.uid != null &&
        ((await DatabaseService.getUserWithId(user?.uid)).id != null)) {
      AppUtil.setUserVariablesByFirebaseUser(user);
      setState(() {
        _authStatus = AuthStatus.LOGGED_IN;
      });
    } else if (user?.uid != null && !(user.emailVerified)) {
      print('!(user.isEmailVerified) = ${!(user.emailVerified)}');
      setState(() {
        _authStatus = AuthStatus.NOT_LOGGED_IN;
        authStatus = AuthStatus.NOT_LOGGED_IN;
      });
    } else {
      setState(() {
        _authStatus = AuthStatus.NOT_LOGGED_IN;
        authStatus = AuthStatus.NOT_LOGGED_IN;
      });
    }
    print('authStatus = $_authStatus');
  }
}
