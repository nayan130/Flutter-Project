import 'package:flutter/material.dart';
import '../all_preference.dart';
import 'home_page.dart';
import 'member_pages/login_pages.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName='/launcher';
  const LauncherPage({Key? key}) : super(key: key);


  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    getLoginStatus().then((value) => {
      if(value){
        Navigator.pushReplacementNamed(context, HomePage.routeName)
      }
      else{
        Navigator.pushReplacementNamed(context, LoginManagerPage.routeName)
      }

    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Loading....',style: TextStyle(fontSize: 20),),
      ),
    );
  }
}
