import 'package:flutter/material.dart';
import 'home_screen.dart';

/// Pantalla de login. Referencia a la página principal.

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Parte de arriba: el logo
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 110,
                              height: 110,
                              child: Image.asset("assets/logo_finance.png"),
                            ),
                          ],
                        ),
                      ),

                      // Parte de abajo: caja verde que contiene los demás elementos
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(50),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(232, 237, 234, 1.0),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // Username label
                              const Text(
                                "Username Or Email",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Username Field
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'example@example.com',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 40),
                                  filled: true,
                                  fillColor: Color.fromRGBO(207, 218, 226, 1.0),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Password label
                              const Text(
                                "Password",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Password Field
                              TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 40),
                                  filled: true,
                                  fillColor: Color.fromRGBO(207, 218, 226, 1.0),
                                ),
                              ),
                              const SizedBox(height: 30),

                              Center(
                                child: Column(
                                  children: [

                                    // Botón "Log in"
                                    SizedBox(
                                      width: 200,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => HomeScreen(),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromRGBO(2, 48, 36, 1.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                        ),
                                        child: const Text(
                                          'Log In',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    
                                    // Botón "Forgot Password"
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),

                                    // Botón "Sign Up "
                                    OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(color: Colors.transparent),
                                        backgroundColor: Color.fromRGBO(232, 237, 234, 1.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

