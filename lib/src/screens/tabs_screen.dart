import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/providers/party.dart';
import 'package:watcherooflutter/src/screens/add_party_screen.dart';
import 'package:watcherooflutter/src/screens/home_screen.dart';
import 'package:watcherooflutter/src/utils/notificationHandlers.dart';

import '../screens/friends_screen.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = '/tabs';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': HomeScreen(),
        'title': 'Parties',
      },
      {
        'page': FriendsScreen(),
        'title': 'Friends',
      },
    ];

    NotificationHandlers().handleNotifications(context);
    super.initState();
  }

  void _changeScreen(int pageIndex) {
    setState(() {
      _selectedPageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        tooltip: "Create a party",
        elevation: 4,
        onPressed: () => Navigator.pushNamed(context, AddPartyScreen.routeName),
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _changeScreen,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _buildPartyIcon(),
            title: Text('Party'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Friends'),
          ),
        ],
      ),
    );
  }

  Widget _buildPartyIcon() {
    final pendingParties = Provider.of<Party>(context).pendingParties;
    return Stack(
      children: <Widget>[
        Icon(Icons.fastfood),
        pendingParties == null || pendingParties.length == 0
            ? SizedBox()
            : Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: Text(
                    '${pendingParties.length}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
      ],
    );
  }
}
