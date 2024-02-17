import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testproject/screens/FirebaseServices.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          titleTextStyle: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          title: Text('Sign In', style: GoogleFonts.poppins()),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Welcome Back!',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Please Inter your email address and \npassword for Login',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 149, 149, 149),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 173, 173, 173),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 54, 54, 54),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  prefixStyle: TextStyle(
                    color: Color.fromARGB(255, 118, 118, 118),
                  ),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Color.fromARGB(255, 173, 173, 173),
                    size: 18,
                  ),
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 181, 181, 181),
                  ),
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 100, 100, 100),
                  ),
                ),
                autofillHints: const [AutofillHints.email],
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 173, 173, 173),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 54, 54, 54),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  prefixStyle: TextStyle(
                    color: Color.fromARGB(255, 118, 118, 118),
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color.fromARGB(255, 173, 173, 173),
                    size: 18,
                  ),
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 181, 181, 181),
                  ),
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 100, 100, 100),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // Add the action you want when the "Forgot Password?" is tapped.
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 90, 90, 90),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSigning ? null : () async => _signIn(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    elevation: 10,
                    shadowColor: Colors.black,
                  ),
                  child: _isSigning
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    // Add the action you want when the "Forgot Password?" is tapped.
                  },
                  child: const Text(
                    'Or sign in with',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 90, 90, 90),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        // Add the action you want when the "Forgot Password?" is tapped.
                      },
                      child: const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.groups_outlined,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      )),
                  GestureDetector(
                    onTap: () {
                      // Add the action you want when the "Forgot Password?" is tapped.
                    },
                    child: const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.facebook,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 90, 90, 90),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Add the action you want when the "Forgot Password?" is tapped.
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = emailController.text;
    String password = passwordController.text;

    print(email);
    print(password);

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      // showToast(message: "User is successfully signed in");
      Navigator.pushNamed(context, "/bottom");
    } else {
      // showToast(message: "some error occurred");
    }
  }
}
