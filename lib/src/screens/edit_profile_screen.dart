import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/validations/auth_form_validation.dart';

import '../utils/utils.dart';
import '../providers/profile.dart';
import '../widgets/profile_picture_header.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = "/edit-profile";

  @override
  State<StatefulWidget> createState() {
    return EditProfileState();
  }
}

class EditProfileState extends State<EditProfileScreen>
    with Utils, AuthFormValidation {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isUpdating = false;

  void _setInitValues() {
    final profile = Provider.of<Profile>(context, listen: false).user;
    firstNameController.text = profile.firstName;
    lastNameController.text = profile.lastName;
    usernameController.text = profile.username;
  }

  @override
  void initState() {
    _setInitValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: buildSaveButton(),
      ),
    );
  }

  Widget buildBody() {
    return ListView(
      children: <Widget>[
        Consumer<Profile>(
          builder: (context, profile, child) {
            return ProfilePictureHeader(
              image: profile.user.imageUrl,
              editable: true,
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          labelText: 'First Name',
                        ),
                        controller: firstNameController,
                        validator: validateSingleName,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        labelText: 'Last Name',
                      ),
                      controller: lastNameController,
                      validator: validateSingleName,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor),
                  ),
                  labelText: 'Username',
                ),
                controller: usernameController,
                validator: validateUsername,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSaveButton() {
    return RaisedButton(
      disabledColor: Theme.of(context).accentColor,
      disabledTextColor: Colors.white,
      onPressed: _isUpdating ? null : _submitEditedProfile,
      child: Text('Save'),
    );
  }

  Future<void> _submitEditedProfile() async {
    // TODO: CHECK IF THERE IS A WAY TO NOT SUBMIT IF NO VALUE IS CHANGED
    if (_formKey.currentState.validate()) {
      try {
        setState(() => _isUpdating = true);

        final Map<String, dynamic> updatedFields = {
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'username': usernameController.text,
        };

        await Provider.of<Profile>(context, listen: false)
            .updateProfile(updatedFields);

        Navigator.of(context).pop();
      } catch (err) {
        showError(err, context);
      }

      setState(() => _isUpdating = false);
    }
  }
}
