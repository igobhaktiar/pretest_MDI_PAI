import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretest_mdi_pai/pages/home_page.dart';
import 'package:provider/provider.dart';

import '../controller/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = 'login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // controller validasi textfield
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _usernameErrorText;
  String? _passwordErrorText;

  @override
  void didChangeDependencies() {
    _usernameErrorText = null;
    _passwordErrorText = null;
    super.didChangeDependencies();
  }

  bool _usernameValidate() {
    if (_usernameController.value.text.isEmpty) {
      _usernameErrorText = 'Can\'t be empty';
      return false;
    } else if (_usernameController.value.text.length < 4) {
      _usernameErrorText = 'Too short';
      return false;
    } else {
      _usernameErrorText = null;
      return true;
    }
  }

  bool _passwordValidate() {
    if (_passwordController.value.text.isEmpty) {
      _passwordErrorText = 'Can\'t be empty';
      return false;
    } else if (_passwordController.value.text.length < 4) {
      _passwordErrorText = 'Too short';
      return false;
    } else {
      _passwordErrorText = null;
      return true;
    }
  }

  bool _validate() {
    setState(() {});
    return (_usernameValidate() && _passwordValidate()) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    LoginController provider = Provider.of<LoginController>(context);
    AuthState state = provider.state;

    String username = _usernameController.value.text;
    String password = _passwordController.value.text;

    bool issPressable = !(username.isEmpty && password.isEmpty) ? true : false;

    void login() {
      if (_validate()) {
        provider.login(username, password).then((value) {
          if (value['status']) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 1),
                content: Text(
                  'User ${provider.user.username} ${provider.message.toLowerCase()}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          Navigator.pushReplacementNamed(context, HomePage.routeName);
          } else if (!value['status']) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 1),
                content: Text(
                  provider.message,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        });
      }
    }

    return Scaffold(
      body: SizedBox(
        height: 800,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              Container(
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                  ),
                  hintText: "Username",
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  hintText: "Password",
                ),

              ),
              const SizedBox(
                height: 32,
              ),
              if (state == AuthState.notLoggedIn) ...[
                Center(
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue,
                    ),
                    child: MaterialButton(
                      onPressed: login,
                      child:  Text("Login",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w700
                      ),),
                    ),
                  ),
                )
              ] else if (state == AuthState.authenticating)...[
                const Column(
                  children: [
                    Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text('Logging .....')
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
