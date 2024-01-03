import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222222),
      body: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 200.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Center(
                child: Text(
                  'Create Your Account',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 18),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      labelText: 'Name',
                      labelStyle: TextStyle(
                        color: Color(0xFF646464),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 18),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Color(0xFF646464),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 18),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Color(0xFF646464),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 18),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(
                        color: Color(0xFF646464),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size.fromHeight(40.0),
                    side: const BorderSide(width: 1.0, color: Colors.white),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Divider(
                  color: Colors.white,
                  thickness: 1.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size.fromHeight(40.0),
                    side: const BorderSide(width: 1.0, color: Colors.white),
                  ),
                  onPressed: () {},
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/images/google_logo.svg',
                          height: 28.0,
                          width: 28.0,
                        ),
                        const SizedBox(width: 20.0),
                        const Text(
                          'Sign Up with Google',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        )
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Already have an Account?',
                      style: TextStyle(
                        color: Color(0xFF646464),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFF75BC7B),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
