import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_app/components/ui_components.dart';
import 'package:login_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/utils/constants.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String id = 'signup_screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  late String _email;
  late String _name;
  late String _password;
  late String _confirmPass;
  final _signupFormKey = GlobalKey<FormState>();
  bool _saving = false;
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        body: LoadingOverlay(
          isLoading: _saving,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const TopScreenImage(screenImageName: 'welcome.png'),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _signupFormKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const ScreenTitle(title: 'Sign Up'),
                              SizedBox(height: 15,),

                              CustomTextField(
                                textField: TextField(
                                  onChanged: (value) {
                                    _email = value;
                                  },
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: kTextInputDecoration.copyWith(
                                    hintText: 'Email',
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              CustomTextField(
                                textField: TextField(
                                  onChanged: (value) {
                                    _name = value;
                                  },
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: kTextInputDecoration.copyWith(
                                    hintText: 'Name',
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              CustomTextField(
                                textField: TextField(
                                  obscureText: true,
                                  onChanged: (value) {
                                    _password = value;
                                  },
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: kTextInputDecoration.copyWith(
                                    hintText: 'Password',
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              CustomTextField(
                                textField: TextField(
                                  obscureText: true,
                                  onChanged: (value) {
                                    _confirmPass = value;
                                  },
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: kTextInputDecoration.copyWith(
                                    hintText: 'Confirm Password',
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                      checkColor: Colors.white,
                                      value: value,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          this.value = value! ;
                                        });
                                      }),
                                  Text('I agree term and condition'),
                                ],
                              ),
                              SizedBox(height: 10,),
                              CustomBottomScreen(
                                textButton: 'Sign Up',
                                heroTag: 'signup_btn',
                                question: 'Have an account?',
                                buttonPressed: () async {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    setState(() {
                                      _saving = true;
                                    });
                                    if (_confirmPass == _password && value == true) {
                                      try {
                                        await _auth.createUserWithEmailAndPassword(
                                            email: _email, password: _password);
                                        _auth.currentUser?.updateDisplayName(_name);

                                        if (context.mounted) {
                                          signUpAlert(
                                            context: context,
                                            title: 'Registered',
                                            desc: 'Successfully registered',
                                            btnText: 'Login Now',
                                            onPressed: () {
                                              setState(() {
                                                _saving = false;
                                                Navigator.popAndPushNamed(
                                                    context, SignUpScreen.id);
                                              });
                                              Navigator.pushNamed(
                                                  context, LoginScreen.id);
                                            },
                                          ).show();
                                        }
                                      } catch (e) {
                                        signUpAlert(
                                            context: context,
                                            onPressed: () {
                                              SystemNavigator.pop();
                                            },
                                            title: 'SOMETHING WRONG',
                                            desc: 'Close the app and try again',
                                            btnText: 'Close Now');
                                      }
                                    }
                                    else {
                                      showAlert(
                                          context: context,
                                          title: 'WRONG PASSWORD/Term & Condition',
                                          desc:
                                          'Make sure fill all fields',
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }).show();
                                    }
                                },
                                questionPressed: () async {
                                  Navigator.pushNamed(context, LoginScreen.id);
                                },
                              ),

                            ],
                          ),
                        ),
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
