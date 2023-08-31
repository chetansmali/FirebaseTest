import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_app/components/ui_components.dart';
import 'package:login_app/screens/signup_screen.dart';
import 'package:login_app/utils/auth.dart';
import 'package:login_app/utils/constants.dart';
import 'package:login_app/screens/dashboard_screen.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool _saving = false;
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordControllrt = TextEditingController();
  static final auth = FirebaseAuth.instance;
  static late AuthStatus _status;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<AuthStatus> resetPassword({required String email}) async {
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) => _status = AuthStatus.successful)
        .catchError(
            (e) => _status = AuthExceptionHandler.handleAuthException(e));

    return _status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        isLoading: _saving,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const TopScreenImage(screenImageName: 'welcome.jpg'),
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Form(
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            children: [
                              CustomTextfield(
                                  controller: _emailController,
                                  hintText: 'Email'),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextfield(
                                  controller: _passwordControllrt,
                                  hintText: 'Password'),
                              SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                  buttonText: 'Login',
                                  onPressed: () async {
                                    if (_emailController.text.isEmail == true &&
                                        _passwordControllrt.text.length >= 6) {
                                      try {
                                        await _auth.signInWithEmailAndPassword(
                                            email: _emailController.text,
                                            password: _passwordControllrt.text);

                                        if (context.mounted) {
                                          setState(() {
                                            _saving = false;
                                            Navigator.popAndPushNamed(
                                                context, LoginScreen.id);
                                          });
                                          Navigator.pushNamed(
                                              context, DashboardScreen.id);
                                        }
                                      } catch (e) {
                                        final snackBar = SnackBar(
                                          content:
                                              Center(child: Text(e.toString())),
                                          backgroundColor: Colors.red[400],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    } else {
                                      final snackBar = SnackBar(
                                        content: Center(
                                            child: const Text(
                                                'Check Email/Password')),
                                        backgroundColor: Colors.red[400],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  }),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: CircleAvatar(
                                      radius: 25,
                                      child: Image.asset(
                                          'assets/images/icons/facebook.png'),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                          'assets/images/icons/google.png'),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          title: Text("Reset your password"),
                                          content: SizedBox(
                                            height: 200,
                                            width: 300,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CustomTextfield(
                                                    controller:
                                                        _emailController,
                                                    hintText: 'Email'),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                CustomButton(
                                                    buttonText: 'Send email',
                                                    onPressed: () async {
                                                      if (_emailController.text.isEmail == true){
                                                        final _status = await resetPassword(email: _emailController.text.trim());
                                                        if (_status == AuthStatus.successful) {
                                                          final snackBar = SnackBar(
                                                            content: Center(
                                                                child: Text(
                                                                    'Email sent to the email')),
                                                            backgroundColor: Colors.red[400],
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(10)),
                                                          );
                                                          ScaffoldMessenger.of(context)
                                                              .showSnackBar(snackBar);
                                                          await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.value.text);
                                                        } else {
                                                          final snackBar = SnackBar(
                                                            content: Center(
                                                                child: const Text(
                                                                    'Email Failed')),
                                                            backgroundColor: Colors.red[400],
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(10)),
                                                          );
                                                          ScaffoldMessenger.of(context)
                                                              .showSnackBar(snackBar);
                                                        }
                                                      }else{
                                                        final snackBar = SnackBar(
                                                          content: Center(
                                                              child: const Text(
                                                                  'Email format')),
                                                          backgroundColor: Colors.red[400],
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(10)),
                                                        );
                                                        ScaffoldMessenger.of(context)
                                                            .showSnackBar(snackBar);
                                                      }
                                                    }
                                                    ),
                                              ],
                                            ),
                                          ),
                                          buttonPadding: EdgeInsets.all(19),
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    'Forget Passwors?',
                                    style: TextStyle(color: Colors.grey),
                                  )),
                              SizedBox(
                                height: 30,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.popAndPushNamed(
                                        context, SignUpScreen.id);
                                  },
                                  child: Text(
                                    'Dont\'t have an account? Register ',
                                    style: TextStyle(color: Colors.grey),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
