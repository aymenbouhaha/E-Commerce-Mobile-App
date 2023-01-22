import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../darkThemeProvider.dart';
import '../../constants/constants.dart';

class AppBarTemplate extends StatelessWidget {
  final DarkThemeProvider themeChange;
  const AppBarTemplate({
    required this.themeChange,
  }) ;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: MediaQuery.of(context).size*0.08,
      child: Container(
        decoration: BoxDecoration(
        ),
        child: AppBar(
          leading: IconButton(
            color: Color(0xFF004D40),
            icon: Icon(LineAwesomeIcons.angle_left),
            onPressed: () {},
          ),
          centerTitle: true,
          title: Text(
              'Profile',
              style: kTitleAppBarTextStyle
          ),
          actions: <Widget>[
            Switch(
                activeColor:Color(0xFF004D40) ,
                value: themeChange.darkTheme,
                onChanged: (bool val)  {
                  // SharedPreferences pref=await SharedPreferences.getInstance();
                  // pref.setBool('darkMode', val) ;
                  themeChange.darkTheme=val ; }

            )
            // IconButton(
            //   color: Color(0xFF004D40),
            //   splashColor: Color(0xFF26A69A),
            //   icon: Icon(_iconBool? _iconDark:_iconLight),
            //   onPressed: () {
            //
            //     }
            // ),
          ],
          elevation: MediaQuery.of(context).size.height*0.02,
        ),
      ),
    );
  }
  }