import 'package:flutter/material.dart';
import 'package:meal_system_management/pages/home_page.dart';
import 'package:meal_system_management/pages/launcer_page.dart';
import 'package:meal_system_management/pages/member_pages/login_pages.dart';
import 'package:meal_system_management/pages/meal_pages/meal_history_details.dart';
import 'package:meal_system_management/provider/add_member_provider.dart';
import 'package:meal_system_management/provider/details_meal_provider.dart';
import 'package:provider/provider.dart';
import 'pages/cost_pages/cost_details_page.dart';
import 'pages/cost_pages/cost_details_update_page.dart';
import 'pages/cost_pages/cost_histtory_details_page.dart';
import 'pages/guest_home_page.dart';
import 'pages/meal_pages/meal_details_pages.dart';
import 'pages/meal_pages/meal_details_update_page.dart';
import 'pages/member_pages/add_members_pages.dart';
import 'pages/member_pages/member_details_page.dart';
import 'provider/details_cost_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>AddMemberProvider()..getAllMembers()),
      ChangeNotifierProvider(create: (context)=>DetailsMealProvider()..getAllDetailsMember()),
      ChangeNotifierProvider(create: (context)=>DetailsCostProvider()..getAllCost()),
    ],
      
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const LoginManagerPage(),
      initialRoute:  LauncherPage.routeName,
      routes: {
        LoginManagerPage.routeName:(context)=>LoginManagerPage(),
        AddMemberPage.routeName:(context)=>AddMemberPage(),
        HomePage.routeName: (context)  => HomePage(),
        MemberMealDetailsPage.routeName: (context) => MemberMealDetailsPage(),
        CostDetailsPage.routeName: (context) => CostDetailsPage(),
        LauncherPage.routeName:(context)=>LauncherPage(),
        MealHistoryPage.routeName:(context)=>MealHistoryPage(),
        MealUpdatePage.routeName:(context)=>MealUpdatePage(),
        GuestHomePage.routeName:(context)=>GuestHomePage(),
        CostHistoryPage.routeName:(context)=>CostHistoryPage(),
        CostUpdateDetailsPage.routeName:(context) => CostUpdateDetailsPage(),
        MemberDetails.routeName:(context) => MemberDetails()
      },
    );
  }
}

