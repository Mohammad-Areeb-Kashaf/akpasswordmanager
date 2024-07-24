import 'package:ak_password_manager/utilities/auth_errors.dart';
import 'package:ak_password_manager/widgets/form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../constants.dart';
import 'home.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late String email;
  late String password;
  String errorMessage = '';
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
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
                'Register',
                TextButton(
                  onPressed: () {
                    Future.delayed(Duration.zero, () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    });
                  },
                  child: const Text('already have an account, Login?'),
                ),
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  if (emailController.text.isEmpty &
                      passwordController.text.isEmpty) {
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
                      errorMessage =
                          'Password should at least contain 6 characters';
                      showSpinner = false;
                    });
                  } else {
                    email = emailController.text;
                    password = passwordController.text;
                    try {
                      await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);

                      setState(() {
                        showSpinner = false;
                      });

                      Future.delayed(Duration.zero, () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()));
                      });
                    } catch (e) {
                      setState(() {
                        errorMessage = checkRegisterAuthError(e: e);
                        showSpinner = false;
                      });
                    }
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
