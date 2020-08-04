import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/providers/accept_invitation.dart';
import 'package:watcherooflutter/src/providers/profile.dart';

class AcceptInvitationScreen extends StatelessWidget {
  static const String routeName = '/accept-invitation';

  void _setData(context) async {
    final acceptInviation =
        Provider.of<AcceptInvitation>(context, listen: false);

    if (acceptInviation.friend != null) return;

    Map data = ModalRoute.of(context).settings.arguments;
    final profile = Provider.of<Profile>(context, listen: false);

    final String friendId = data['friendId'];
    final String roomId = data['roomId'];
    final String partyId = data['partyId'];

    final friend = profile.getFriendById(roomId);

    await acceptInviation.setInitData(friend, partyId, roomId);
  }

  @override
  Widget build(BuildContext context) {
    _setData(context);
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildMovieTitle(),
          _buildDetailsText(context),
          SizedBox(height: 35),
          _buildSelectVideo(),
          _buildButtonsRow(context),
        ],
      ),
    );
  }

  Widget _buildMovieTitle() {
    return Consumer<AcceptInvitation>(
      builder: (context, acceptInvitation, _) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: acceptInvitation.party == null
              ? CircularProgressIndicator()
              : FittedBox(
                  child: Text(
                    acceptInvitation.party.movieName,
                    style: TextStyle(
                      //color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildDetailsText(BuildContext context) {
    final friend = Provider.of<AcceptInvitation>(context).friend;
    return Container(
      child: FittedBox(
        child: friend == null
            ? CircularProgressIndicator()
            : Text(
                '${friend.firstName} ${friend.lastName} is inviting you to watch a movie with her'),
      ),
    );
  }

  Widget _buildSelectVideo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child:
          Consumer<AcceptInvitation>(builder: (context, acceptInvitation, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Text(
              acceptInvitation.url,
              style: TextStyle(),
            )),
            SizedBox(width: 20),
            RaisedButton(
              child: Text('Select File'),
              onPressed: acceptInvitation.selectFile,
            ),
          ],
        );
      }),
    );
  }

  Widget _buildButtonsRow(context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildAcceptButton(),
          _buildDeclineButton(context),
        ],
      ),
    );
  }

  Widget _buildAcceptButton() {
    return Consumer<AcceptInvitation>(
      builder: (context, acceptInvitation, _) {
        return Container(
          padding: EdgeInsets.all(20),
          child: FlatButton(
            color: Colors.green[700],
            child: Icon(Icons.check),
            onPressed: !acceptInvitation.isValidAccept
                ? null
                : () => acceptInvitation.acceptParty(context),
          ),
        );
      },
    );
  }

  Widget _buildDeclineButton(context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: FlatButton(
        color: Colors.red[900],
        child: Icon(Icons.close),
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Declining Party'),
                content: Text('Are you sure you want to decline this party ?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Yes'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      Navigator.of(ctx).pop();
                      // TODO: CHANGE STATE OF THE PARTY
                    },
                  ),
                  FlatButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
