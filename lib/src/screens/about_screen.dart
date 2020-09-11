import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/main_drawer.dart';

class AboutScreen extends StatelessWidget {
  static const String routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      drawer: MainDrawer(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          children: <Widget>[
            _buildHeader(),
            SizedBox(height: 20),
            _buildMiddleText(context),
            SizedBox(height: 20),
            _buildCredits(context),
            SizedBox(height: 30),
            _buildFindMe(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: <Widget>[
        Image.asset('assets/images/about_header.png'),
        Positioned(
          top: 20,
          child: Text(
            'About Us',
            style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w600,
                color: Color(0xFF3F3D56)),
          ),
        ),
      ],
    );
  }

  Widget _buildMiddleText(context) {
    return Column(
      children: <Widget>[
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF2F2E41),
            ),
            children: <TextSpan>[
              TextSpan(text: 'This app is brought to you by '),
              TextSpan(
                text: 'Omar Alaa.\n',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              TextSpan(
                  text:
                      'A 20-year-old computer engineering student from Alexandria who has a passion in coding.'),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'This app was created during the COVID-19 crisis in order to help make people connect through the pandemic.',
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF2F2E41),
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _buildCredits(context) {
    return Column(
      children: <Widget>[
        Text(
          'Credits',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(height: 20),
        _buildRole(
            'Mobile/Backend', 'Omar Alaa', 'https://github.com/HEROMORA'),
        _buildRole('Design', 'Yosra Emad', 'https://github.com/yosraemad'),
      ],
    );
  }

  Widget _buildRole(String role, String person, String url) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          role + ':',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2F2E41),
          ),
        ),
        SizedBox(width: 12),
        Text(
          person,
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF2F2E41),
          ),
        ),
        SizedBox(width: 5),
        InkWell(
          child: Icon(
            Icons.link,
            color: Colors.pink,
          ),
          onTap: () async {
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
        ),
      ],
    );
  }

  Widget _buildFindMe(context) {
    final facebookUrl = 'https://www.facebook.com/iceshadow03/';
    final instagramUrl = 'https://www.instagram.com/_omarralaa/';
    return Column(
      children: <Widget>[
        Text(
          'Where to find me',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.facebookSquare,
                color: Color(0xFF2F2E41),
                size: 60,
              ),
              onPressed: () async {
                if (await canLaunch(facebookUrl)) {
                  await launch(facebookUrl);
                } else {
                  throw 'Could not launch $facebookUrl';
                }
              },
            ),
            SizedBox(width: 80),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.instagram,
                color: Color(0xFF2F2E41),
                size: 60,
              ),
              onPressed: () async {
                if (await canLaunch(instagramUrl)) {
                  await launch(instagramUrl);
                } else {
                  throw 'Could not launch $instagramUrl';
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
