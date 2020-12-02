import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:knu_movie_web/utils/padding.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';

import 'widget/nav_bar.dart';

void main() async {
  runApp(KnuMovieWeb());
}

class KnuMovieWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Knu Movie Web',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            backgroundColor: Colors.grey[300],
            body: SingleChildScrollView(
                child: Column(children: <Widget>[NavBar(), HomeBody()]))));
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final homeText = HomeText();
    final homeContainer = HomeContainer();
    bool isLarge = ResponsiveLayout.isLargeScreen(context);
    Size size = MediaQuery.of(context).size;
    Widget verticalSizedBox() {
      return SizedBox(height: size.height / 50);
    }

    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isLarge
              ? MyPadding.mediaWidth(context)
              : MyPadding.normalHorizontal,
        ),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: 10,
              ),
              homeText.homeText("High ratings")
            ]),
            verticalSizedBox(),
            homeContainer.homeContainer(size.width, size.height / 6),
            verticalSizedBox(),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: 10,
              ),
              homeText.homeText("Hot in Korea")
            ]),
            verticalSizedBox(),
            homeContainer.homeContainer(size.width, size.height / 6),
            verticalSizedBox(),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: 10,
              ),
              homeText.homeText("Classics")
            ]),
            verticalSizedBox(),
            homeContainer.homeContainer(size.width, size.height / 6),
          ],
        ));
  }
}

class HomeContainer {
  Widget homeContainer(width, height) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
          ],
        ));
  }
}

// class MovieListView{
//   StreamBuilder movieListView(){
//     return StreamBuilder(
//       stream: ,
//       builder: (context, snapshot){
//         return ListView.separated(
//           separatorBuilder: ,
//         )
//       },
//     )
//   }
// }

class HomeText {
  Widget homeText(text) {
    return Text(text,
        style: GoogleFonts.prompt(
          textStyle: TextStyle(
              color: Colors.red[200],
              fontWeight: FontWeight.w400,
              shadows: [
                Shadow(
                  color: Colors.grey[400],
                  offset: Offset(3.0, 3.0),
                  blurRadius: 3.0,
                ),
              ],
              fontSize: 20),
        ));
  }
}
