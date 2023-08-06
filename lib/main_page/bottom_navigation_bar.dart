




import 'package:flutter/material.dart';
import 'package:themoviedb_tmdb/main_page/view.dart';
import 'package:themoviedb_tmdb/profile/view.dart';
import 'package:themoviedb_tmdb/utilities/colors_contant.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({super.key});


  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int ourSelectedIndex=0;
  List<Widget> listBottomNavBar=[MovieMainPage(),const NavChat(),const NavUser(),const ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:SafeArea(child: listBottomNavBar[ourSelectedIndex]),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ourSelectedIndex,
        onTap:(int i) {
          setState(() {
            ourSelectedIndex=i;
          });
        } ,
        backgroundColor: ConstantColors.ultraLightTextColor,
        type: BottomNavigationBarType.fixed, //only if the type is fixed,then background color is fixed
        unselectedItemColor: Colors.grey[700],
        // selectedItemColor: Colors.black,
        selectedItemColor:ConstantColors.highlightedColor,
        showUnselectedLabels: true, // to show label with icon
        items:const <BottomNavigationBarItem> [
          BottomNavigationBarItem(icon: Icon(Icons.home),
            //backgroundColor: Colors.red[200],
            label:"home",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search),
              //backgroundColor: Colors.black12,
              label:"search"
          ),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),
              //backgroundColor: Colors.black12,
              label:"activity"
          ),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle),
              //backgroundColor: Colors.black12,
              label:"profile"
          ),


        ],
      ),
    );
  }
}
class NavHome extends StatelessWidget {
  const NavHome({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[500],
        body:
        const Center(child: Column(
          children: [
            Text(" Home Bottom Nav Bar", style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),)
          ],
        ))
    );
  }
}
class NavChat extends StatelessWidget {
  const NavChat({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[700],
        body:
        const Center(child: Column(
          children: [
            Text(" Chat Bottom Nav Bar", style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),)
          ],
        ))
    );
  }
}
class NavUser extends StatelessWidget {
  const NavUser({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[200],
        body:
        Center(child: Column(
          children: [
            Text("User Bottom Nav Bar", style: TextStyle(
              color: Colors.blue[700],
            ),)
          ],
        ))
    );
  }
}
class NavSearch extends StatelessWidget {
  const NavSearch({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[700],
        body:
        Center(child: Column(
          children: [
            Text("Search Bottom Nav Bar", style: TextStyle(
              color: Colors.amber[800],
            ),)
          ],
        ))
    );
  }
}
