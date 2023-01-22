import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:testprofile/screens/admin/add_product_screen.dart';
import 'package:testprofile/screens/shared/profile_screen.dart';
import './screens/constants/constants.dart';
import 'darkThemeProvider.dart';
String language= 'EN' ;
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }
  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return  ChangeNotifierProvider(
          create:(_){
            return themeChangeProvider;
          },
          child: Consumer<DarkThemeProvider>(
            builder: (BuildContext context, value,_) {

         return  MaterialApp(
              title: 'Mini_projet',
              debugShowCheckedModeBanner: false,
              home: Add(),
              theme: themeChangeProvider.darkTheme? kDarkTheme:kLightTheme
            );
         }
    )

        );
      },
    );
  }
}
