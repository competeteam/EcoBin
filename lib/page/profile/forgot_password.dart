import 'package:dinacom_2024/services/auth_service.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  final String emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF222222),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(30.0, 60.0, 30.0, 0.0),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Center(
                        child: Image(
                          image: AssetImage('assets/images/app_logo.png'),
                          width: 160.0,
                          height: 160.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Center(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Center(
                          child: Align(
                        child: Text(
                            'Please enter your email address to\nreceive a verification code',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                      )),
                      const SizedBox(height: 50.0),
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
                      const SizedBox(height: 40.0),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          fixedSize: const Size.fromHeight(40.0),
                          side:
                              const BorderSide(width: 1.0, color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            print(email);
                          }
                        },
                        child: const Text(
                          'Send Email',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ]))));
  }
}
