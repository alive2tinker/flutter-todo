import 'package:flutter/material.dart';
import 'package:todo_list_sqlite/screens/category_screen.dart';
import 'package:todo_list_sqlite/screens/home_screen.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text("Abdulmalik Alsufayran"),
                accountEmail: Text("a.alsufayran.c@nhc.sa"),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: Icon(Icons.filter_list, color: Colors.white,),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.red
              ),
            ),
            ListTile(
              title: Text("home"),
              leading: Icon(Icons.home_filled),
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new HomeScreen()));
              },
            ),
            ListTile(
              title: Text("categories"),
              leading: Icon(Icons.view_list),
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new CategoryScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
