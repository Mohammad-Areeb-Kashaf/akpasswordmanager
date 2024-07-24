import 'package:ak_password_manager/screens/register.dart';
import 'package:ak_password_manager/utilities/auth_errors.dart';
import 'package:ak_password_manager/widgets/form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../constants.dart';
import 'home.dart';
import '../widgets/form.dart';

class Login extends StatefulWidget {
  const Login({this.loginForApp});
  final loginForApp;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String errorMessage = '';
  late String email;
  late String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: kTextStyle,
        ),
      ),
      body: LoadingOverlay(
        isLoading: showSpinner,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: MyForm().getFormForSignin(
                Text(errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    )),
                emailController,
                passwordController,
                'Login',
                TextButton(
                  onPressed: () {
                    Future.delayed(Duration.zero, () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()));
                    });
                  },
                  child: const Text('don\'t have an account, create now?'),
                ),
                onPressed: () {
                  if (widget.loginForApp) {
                    _loginForApp();
                  } else {
                    _loginForConfirmation();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _loginForApp() async {
    setState(() {
      showSpinner = true;
    });
    if (emailController.text.isEmpty & passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your Username and Password';
        showSpinner = false;
      });
    } else if (emailController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your Username';
        showSpinner = false;
      });
    } else if (passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your Password';
        showSpinner = false;
      });
    } else if (passwordController.text.length < 6) {
      setState(() {
        errorMessage = 'Password should at least contain 6 characters';
        showSpinner = false;
      });
    } else {
      email = emailController.text;
      password = passwordController.text;

      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        setState(() {
          showSpinner = false;
        });
        Future.delayed(Duration.zero, () async {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Home()));
        });
      } catch (e) {
        setState(() {
          errorMessage = checkLoginAuthError(e: e);
          showSpinner = false;
        });
      }
    }
  }

  void _loginForConfirmation() async {
    setState(() {
      showSpinner = true;
    });
    if (emailController.text.isEmpty & passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your Username and Password';
        showSpinner = false;
      });
    } else if (emailController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your Username';
        showSpinner = false;
      });
    } else if (passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your Password';
        showSpinner = false;
      });
    } else if (passwordController.text.length < 6) {
      setState(() {
        errorMessage = 'Password should at least contain 6 characters';
        showSpinner = false;
      });
    } else {
      email = emailController.text;
      password = passwordController.text;

      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        setState(() {
          showSpinner = false;
        });
        Navigator.pop(context, 'Success');
      } catch (e) {
        setState(() {
          errorMessage = checkLoginAuthError(e: e);
          showSpinner = false;
        });
      }
    }
  }
}
