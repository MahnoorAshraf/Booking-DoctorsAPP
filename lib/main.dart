
import 'package:clientwork/providers/homeprovider.dart';
import 'package:clientwork/providers/loginprovider.dart';
import 'package:clientwork/routes/routenames.dart';
import 'package:clientwork/routes/routes.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) =>SelectedIndexProvider()),
            ChangeNotifierProvider(create: (_) =>LoginState()),



        ],
        child:MaterialApp(
           navigatorKey: navigatorKey,
     debugShowCheckedModeBanner: false,
     initialRoute: Routenames.splashscreen,
      onGenerateRoute: Routes.generateRoute
    ));}}
     