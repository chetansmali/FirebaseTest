import 'package:flutter/material.dart';
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
  late String _email;
  late String _password;
  bool _saving = false;

  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
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
    return  Scaffold(
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Form(
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            children: [
                               CustomTextField(
                              textField: TextField(
                                  onChanged: (value) {
                                    _email = value;
                                  },
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: kTextInputDecoration.copyWith(
                                      hintText: 'Email')),
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
                                    hintText: 'Password'),
                              ),
                            ),
                            SizedBox(height: 20,),
                            CustomBottomScreen(
                                textButton: 'Login',
                                heroTag: 'login_btn',
                                question: 'Forgot password?',
                                buttonPressed: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  setState(() {
                                    _saving = true;
                                  });
                                  try {
                                    await _auth.signInWithEmailAndPassword(
                                        email: _email, password: _password);

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
                                    signUpAlert(
                                      context: context,
                                      onPressed: () {
                                        setState(() {
                                          _saving = false;
                                        });
                                        Navigator.popAndPushNamed(
                                            context, LoginScreen.id);
                                      },
                                      title: 'WRONG PASSWORD OR EMAIL',
                                      desc:
                                      'Confirm your email and password and try again',
                                      btnText: 'Try Now',
                                    ).show();
                                  }
                                },
                                questionPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("RESET YOUR PASSWORD"),
                                        content: SizedBox(
                                          height: 300,
                                          width: 300,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              TextFormField(
                                                obscureText: false,
                                                controller: _emailController,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Empty email';
                                                  }
                                                  return null;
                                                },
                                                autofocus: false,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                decoration: const InputDecoration(
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 20,
                                                      horizontal: 20),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              30.0))),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 1,
                                                    ),
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(
                                                        30.0,
                                                      ),
                                                    ),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide:
                                                    BorderSide(width: 2.0),
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(
                                                        30.0,
                                                      ),
                                                    ),
                                                  ),

                                                  isDense: true,
                                                  // fillColor: kPrimaryColor,
                                                  filled: true,
                                                  errorStyle:
                                                  TextStyle(fontSize: 15),
                                                  hintText: 'email address',
                                                  hintStyle: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                    20,
                                                child: Material(
                                                  elevation: 2,
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                  child: MaterialButton(
                                                    onPressed: () async {
                                                      // if (_key.currentState
                                                      //     !.validate()) {
                                                      final _status =
                                                      await resetPassword(
                                                          email:
                                                          _emailController
                                                              .text
                                                              .trim());
                                                      if (_status ==
                                                          AuthStatus.successful) {
                                                        print("Email Sent Success");
                                                        await FirebaseAuth
                                                            .instance
                                                            .sendPasswordResetEmail(
                                                            email: _emailController.value.text);

                                                      } else {
                                                        //your logic or show snackBar with error message
                                                        print("Email Sent Success");
                                                      }
                                                      // }
                                                    },
                                                    minWidth: double.infinity,
                                                    child: const Text(
                                                      'RECOVER PASSWORD',
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 16,
                                                          fontFamily: 'Poppins'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        buttonPadding: EdgeInsets.all(19),
                                      );
                                    },
                                  );
                                }),
                            SizedBox(height: 10,),
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
                                    child:
                                    Image.asset('assets/images/icons/google.png'),
                                  ),
                                ),

                              ],
                            ),
                            TextButton(onPressed: (){
                              Navigator.popAndPushNamed(
                                  context, SignUpScreen.id);
                            }, child: Text('Dont\'t have an account? Register ',style: TextStyle(color: Colors.grey),))
                            ],
                          ),
                        )
                      ],
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
