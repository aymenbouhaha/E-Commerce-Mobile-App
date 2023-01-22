import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../darkThemeProvider.dart';
import './widgets/ProfileListItem.dart';
import '../constants/constants.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  IconData _iconLight=Icons.wb_sunny;
  IconData _iconDark=Icons.nights_stay;
  File? profileImage;
  @override
  void initState() {
    super.initState();
    profileImage=null;
    // getSelectedPref();
  }
  uploadProfileImage() async {
    var pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        profileImage = File(pickedImage.path);
      });
    } else {}
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(414, 896), minTextAdapt: true);
    final themeChange = Provider.of<DarkThemeProvider>(context);
    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 10,
            width: kSpacingUnit.w * 10,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: Stack(
              children: <Widget>[
                Container(
                  decoration:BoxDecoration(
                    shape:BoxShape.circle,
                    boxShadow:[ BoxShadow(
                      spreadRadius: 3.sp,blurRadius: 12.sp,
                      color:themeChange.darkTheme?kLightPrimaryColor.withOpacity(0.1):kDarkPrimaryColor.withOpacity(0.4),
                      offset: Offset(0,10)
                    )]
                  ) ,
                  child:
                  profileImage!=null?
                  CircleAvatar(
                    radius: kSpacingUnit.w * 5,
                    backgroundImage:FileImage(profileImage!)
                  ):
                  CircleAvatar(
                      radius: kSpacingUnit.w * 5,
                      backgroundImage:AssetImage('./assets/images/Avatar_Ismail.png')
                  )
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: kSpacingUnit.w * 3.5,
                    width: kSpacingUnit.w * 3.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      heightFactor: kSpacingUnit.w * 1.5,
                      widthFactor: kSpacingUnit.w * 1.5,
                      child: IconButton(
                        splashColor: Color(0xFFF8BBD0),
                        splashRadius: 30.sp,
                        onPressed: (){uploadProfileImage();},
                        icon: Icon(
                        LineAwesomeIcons.camera,
                        color: Theme.of(context).primaryColor,
                        size: ScreenUtil().setSp(kSpacingUnit.w * 2.5),
                      ),
                    ),
                  ),
                ),
                )],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text(
            'ismail said ',
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text(
            'saidismail@gmail.com',
            style: kCaptionTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text(
            '55944716',
            style: kCaptionTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Container(
            height: kSpacingUnit.w * 4,
            width: kSpacingUnit.w * 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
              color: kAccentColor,
            ),
            child: Center(
              child: Text(
                'Upgrade to PRO',
                style: kButtonTextStyle,
              ),
            ),
          ),
          SizedBox(height:kSpacingUnit.w * 2)
        ],
      ),
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: kSpacingUnit.w * 3),
        profileInfo,
        SizedBox(width: kSpacingUnit.w * 3),
      ],
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.08,
        child: Container(
          decoration: BoxDecoration(),
          child:
          // AppBarTemplate(themeChange: themeChange)
          AppBar(
            leading: IconButton(
              color: Color(0xFF004D40),
              icon: Icon(LineAwesomeIcons.angle_left),
              onPressed: () {},
            ),
            centerTitle: true,
            title: Text('Profile', style: kTitleAppBarTextStyle),
            actions: <Widget>[
              IconButton(
                  splashColor:Color(0xFF004D40) ,
                  color:Color(0xFF004D40) ,
                  splashRadius: 20.sp,
                  onPressed: (){
                    themeChange.darkTheme=!themeChange.darkTheme;
                  }
                  , icon:Icon(themeChange.darkTheme?_iconLight:_iconDark)
                // Switch(
                //     activeColor: Color(0xFF004D40),
                //     value: themeChange.darkTheme,
                //     onChanged: (bool val) {
                //       // SharedPreferences pref=await SharedPreferences.getInstance();
                //       // pref.setBool('darkMode', val) ;
                //       themeChange.darkTheme = val;
                //     })
              )],
            elevation: MediaQuery.of(context).size.height * 0.02,
          ),
        ),
      ),
      body: Column(
        children: [
          // SizedBox(height: kSpacingUnit.w * 5),
          header,
          Expanded(
            child: ListView(
              children: [
                ProfileListItem(
                  icon: Icons.settings_outlined,
                  text: 'Paramètres',
                ),
                ProfileListItem(
                  icon: LineAwesomeIcons.question_circle,
                  text: 'Aide ',
                ),
                ProfileListItem(
                  icon: LineAwesomeIcons.alternate_sign_out,
                  text: 'Deconnecter',
                  hasNavigation: false,
                ),
              ],
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                style:OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50) ,
                   shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20)),
                  backgroundColor:themeChange.darkTheme?Color(0xFF303030):Color(0xFFCFD8DC)
                ),
                onPressed: () {},
                child: Text("CANCEL",
                    style: TextStyle(
                        fontSize: 16.sp,
                        letterSpacing: 2.2.sp,
                        color:themeChange.darkTheme? Color(0xFF9FA8DA):Color(0XFF303030))),
              ),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor:themeChange.darkTheme?Color(0xFF006064) :Color(0XFF1DE9B6),
                  padding: EdgeInsets.symmetric(horizontal: 50.sp),
                  elevation: 2.sp,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.sp)),
                ),

                child: Text(
                  "EDIT PROFILE",
                  style: TextStyle(
                      fontSize: 16.sp,
                      letterSpacing: 2.2.sp,
                      color: Colors.white),
                ),
              )
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.1)
        ],
      ),
    );
  }
  // getSelectedPref() async {
  //   SharedPreferences pref=await SharedPreferences.getInstance();
  //   setState(() {
  //     _darkmode=pref.getBool('darkMode')! ;
  //   });
  // }
}
