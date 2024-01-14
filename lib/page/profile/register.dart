import 'package:dinacom_2024/components/loading/loading.dart';
import 'package:dinacom_2024/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  final String emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String errorMessage = '';

  String? validatePassword(password) {
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(password)) {
      return 'Password must have at least one upper case';
    }
    if (!RegExp(r'(?=.*[a-z])').hasMatch(password)) {
      return 'Password must have at least one lower case';
    }
    if (!RegExp(r'(?=.*?[0-9])').hasMatch(password)) {
      return 'Password must have at least one digit';
    }
    if (!RegExp(r'(?=.*?[!@#\$&*~])').hasMatch(password)) {
      return 'Password must have at least one special character (!@#\\\$&*~)';
    }
    if (!RegExp(r'.{8,}').hasMatch(password)) {
      return 'Password must be at least 8 characters in length';
    }
    return null;
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: const Color(0xFF222222),
            body: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(30.0, 100.0, 30.0, 0.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Center(
                        child: Text(
                          'Create Your Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        validator: (val) {
                          if (val!.trim().isEmpty) {
                            return 'Name cannot be empty';
                          }

                          return null;
                        },
                        onChanged: (val) {
                          setState(() => name = val.trim());
                        },
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(12.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            color: Color(0xFF646464),
                            fontSize: 12,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        validator: (val) {
                          if (val!.trim().isEmpty) {
                            return 'Email cannot be empty';
                          }
                          if (!RegExp(emailRegex).hasMatch(val)) {
                            return 'Email format invalid';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() => email = val.trim());
                        },
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(12.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Color(0xFF646464),
                            fontSize: 12,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        validator: (val) {
                          if (val!.trim().isEmpty) {
                            return 'Password cannot be empty';
                          }

                          return validatePassword(val);
                        },
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(12.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Color(0xFF646464),
                            fontSize: 12,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        validator: (val) {
                          if (val!.trim().isEmpty) {
                            return 'Confirm Password cannot be empty';
                          }
                          if (val != password) {
                            return 'Password does not match';
                          }

                          return null;
                        },
                        onChanged: (val) {
                          setState(() => confirmPassword = val);
                        },
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(12.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                            color: Color(0xFF646464),
                            fontSize: 12,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 32),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          fixedSize: const Size.fromHeight(40.0),
                          side:
                              const BorderSide(width: 1.0, color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                                await _authService.registerWithEmailAndPassword(
                                    name, email, password);

                            if (result == null) {
                              setState(() {
                                errorMessage = 'Email address already in use';
                                loading = false;
                              });
                            } else {
                              GoRouter.of(context).go('/profile');
                            }
                          }
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(errorMessage,
                          style:
                              TextStyle(color: Colors.red[900], fontSize: 12)),
                      const SizedBox(height: 10),
                      const Divider(
                        color: Colors.white,
                        thickness: 1.0,
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          fixedSize: const Size.fromHeight(40.0),
                          side:
                              const BorderSide(width: 1.0, color: Colors.white),
                        ),
                        onPressed: () {},
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/logos/google_logo.svg',
                                height: 28.0,
                                width: 28.0,
                              ),
                              const SizedBox(width: 20.0),
                              const Text(
                                'Sign Up with Google',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              )
                            ]),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Already have an Account?',
                            style: TextStyle(
                              color: Color(0xFF646464),
                              fontSize: 14,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              GoRouter.of(context).go('/login');
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Color(0xFF75BC7B),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          );
  }
}
