import 'package:flutter/material.dart';
import 'package:ics_frontend/View/dashboad.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 150),
              Card(
                color: Colors.white,
                child: SizedBox(
                  width: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Log In",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),

                        emailTextField(),
                        const SizedBox(height: 20),

                        passwordTextField(),

                        const SizedBox(height: 40),

                        loginButton('Login'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Email TextField
  Widget emailTextField() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Your Username',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  // Password TextField
  Widget passwordTextField() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Your Password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(height: 8),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  // Login Button
  Widget loginButton(String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(200, 75),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      },
      child: Text(
        text,
        style: const TextStyle(fontSize: 22, color: Colors.white),
      ),
    );
  }
}
