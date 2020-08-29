import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/models/friend.dart';
import 'package:watcherooflutter/src/providers/party.dart';
import 'package:watcherooflutter/src/providers/profile.dart';
import 'package:watcherooflutter/src/screens/previous_parties_screen.dart';
import 'package:watcherooflutter/src/widgets/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<Profile>(context, listen: false).getProfile();
    Provider.of<Party>(context, listen: false).getPrevParties();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Parties')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeader(),
            SizedBox(height: 30),
            // _buildPendingParties(),
            _buildPrevParties(),
          ],
        ),
      ),
      drawer: MainDrawer(),
    );
  }

  Widget _buildHeader() {
    final profile = Provider.of<Profile>(context, listen: false).user;
    return profile == null
        ? SizedBox()
        : FittedBox(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Row(
                children: <Widget>[
                  Text(
                    'Good ${_timing()},\n${profile.firstName} ${profile.lastName}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Image.asset(
                    'assets/images/sofa.png',
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ),
          );
  }

  Widget _buildPendingParties() {
    final profile = Provider.of<Profile>(context).user;
    if (profile == null) return SizedBox();
    final friends = profile.friends;
    final dummy_data = [
      {'movieName': 'Interstellar', 'friend': friends[0]},
      {'movieName': 'Battlestar Galactica', 'friend': friends[1]},
      {'movieName': 'Interstellar', 'friend': friends[0]},
      {'movieName': 'Battlestar Galactica', 'friend': friends[1]},
      {'movieName': 'Interstellar', 'friend': friends[0]},
      {'movieName': 'Battlestar Galactica', 'friend': friends[1]},
    ];
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.centerLeft,
          child: Text(
            'Pending Parties',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(height: 25),
        Container(
          height: 180,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            key: UniqueKey(),
            itemCount: dummy_data.length,
            itemBuilder: (ctx, i) {
              final friend = dummy_data[i]['friend'] as Friend;
              return Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.symmetric(vertical: 6),
                  elevation: 2,
                  child: Container(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(friend.imageUrl),
                      ),
                      title: Text(
                        dummy_data[i]['movieName'],
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(
                        'Invitation by ${friend.firstName}',
                        style: TextStyle(
                            fontSize: 14, fontStyle: FontStyle.italic),
                      ),
                      trailing: FlatButton(
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          size: 50,
                          color: Colors.grey,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPrevParties() {
    final profile = Provider.of<Profile>(context);
    final prevParties = Provider.of<Party>(context).prevParties;
    if (prevParties == null || profile == null) return SizedBox();
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Previous Parties',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              FlatButton(
                child: Text(
                  'See All',
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(PreviousPartiesScreen.routeName);
                },
              ),
            ],
          ),
        ),
        Container(
          height: 90,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15),
            itemCount: prevParties.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, i) {
              final friend = profile.getFriendByGuestOrCreator(
                prevParties[i].creator,
                prevParties[i].guest,
              );
              return Container(
                width: 250,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(friend.imageUrl),
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              prevParties[i].movieName,
                              style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              'Watched with ${friend.firstName}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              DateFormat.yMMMMEEEEd()
                                  .format(prevParties[i].createdAt),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _timing() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }
}
