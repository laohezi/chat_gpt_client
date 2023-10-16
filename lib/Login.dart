import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controller for user name input

  TextEditingController _userController = TextEditingController();

  // Controller for password input
  TextEditingController _passwordController = TextEditingController();

  // Variables for saving user credentials
  bool _saveCredentials = false;
  String _savedUserName = '';
  String _savedPassword = '';

  // Function to validate user credentials
  bool _validateUser() {
    // Check if user name and password are correct
    if (_userController.text == _savedUserName && _passwordController.text == _savedPassword) {
      return true;
    } else {
      return false;
    }
  }

  // Function to handle login button press
  void _handleLogin() {
    if (_validateUser()) {
      // Navigate to home page if credentials are correct
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Show error message if credentials are incorrect
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login error'),
            content: Text('Invalid user name or password'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Load saved user credentials from storage
    _savedUserName = ''; // Load from storage
    _savedPassword = ''; // Load from storage
    _userController.text = _saveCredentials ? _savedUserName : '';
    _passwordController.text = _saveCredentials ? _savedPassword : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('User name:'),
            TextFormField(
              controller: _userController,
              decoration: InputDecoration(
                hintText: 'Enter your user name',
              ),
            ),
            SizedBox(height: 20.0),
            Text('Password:'),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Enter your password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Checkbox(
                  value: _saveCredentials,
                  onChanged: (value) {
                    setState(() {
                      _saveCredentials = value!;
                      if (!_saveCredentials) {
                        // Clear saved credentials if checkbox is unchecked
                        _savedUserName = '';
                        _savedPassword = '';
                      }
                    });
                  },
                ),
                Text('Remember me'),
              ],
            ),
            SizedBox(height: 20.0),
            TextButton(
              child: Text('Login'),
              onPressed: _handleLogin,
            ),
          ],
        ),
      ),
    );
  }
}
