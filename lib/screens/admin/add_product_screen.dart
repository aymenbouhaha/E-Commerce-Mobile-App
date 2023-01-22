import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:testprofile/screens/shared/widgets/fieldArticle.dart';
import '../../darkThemeProvider.dart';
import '../constants/constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Add extends StatefulWidget {
  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  var nameArticleController = TextEditingController();

  var priceArticleController = TextEditingController();

  var decriptionArticleController = TextEditingController();
  File? image;
  IconData _iconLight=Icons.wb_sunny;
  IconData _iconDark=Icons.nights_stay;
  @override
  initState() {
    super.initState();
    image=null;
  }
  uploadImage() async {
    var pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(414, 896), minTextAdapt: true);
    final themeChange = Provider.of<DarkThemeProvider>(context);
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
              title: Text('Nouveau Produit', style: kTitleAppBarTextStyle),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(height: kSpacingUnit.w * 5),
                Text(
                  'Photo de l\'Article ',
                  style: kTitleTextStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  onPressed: uploadImage,
                  child: Icon(
                    // <-- Icon
                    Icons.add_a_photo_sharp,
                    size: 24.0,
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kAccentColor),
                      padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                      textStyle:
                          MaterialStateProperty.all(TextStyle(fontSize: 15))),
                ),
                SizedBox(
                  height: 20.0,
                ),
                image != null
                    ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height *0.3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(image!), fit: BoxFit.cover)),
                )
                    : Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height *0.3,
                    child: Image.asset('./assets/images/Logo.png')),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                FieldArticle(
                    icon: Icon(Icons.article_outlined),
                    text: 'Nom de l\' Article',
                    field_controller: nameArticleController,
                    keyboard: TextInputType.text),

                SizedBox(
                  height: 20.0,
                ),
                FieldArticle(
                    icon: Icon(Icons.attach_money),
                    text: 'Prix de l\'Article',
                    field_controller: priceArticleController,
                    keyboard: TextInputType.number),
                SizedBox(
                  height: 20.0,
                ),
                FieldArticle(
                    min: 5,
                    max: 8,
                    icon: Icon(Icons.description_outlined),
                    text: 'Description',
                    field_controller: decriptionArticleController,
                    keyboard: TextInputType.text),

                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: IconButton(
                    color: kAccentColor,
                    highlightColor: Colors.white38,
                    splashColor: Color(0xFF009688),
                    disabledColor: Color(0xFF009688),
                    iconSize: 60,
                    onPressed: () {},
                    icon: Icon(Icons.add_circle_sharp),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
