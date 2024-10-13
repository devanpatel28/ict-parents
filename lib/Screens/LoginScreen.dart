import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ict_mu_parents/Helper/Colors.dart';

import '../Controller/LoginController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = true;
  bool isLoading = false;

  // FocusNodes for text fields
  final FocusNode _enrollmentNumberFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  TextEditingController username = TextEditingController(text: "114617");
  TextEditingController password = TextEditingController(text: "Devan123");

  LoginController loginControl = Get.put(LoginController());
  @override
  void dispose() {
    // Clean up the focus nodes when the widget is disposed
    _enrollmentNumberFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage('assets/images/mu_logo.png'),
                    height: 100,
                  ),
                  const SizedBox(height: 50),
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.06,
                    width: MediaQuery.sizeOf(context).width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Light1.withOpacity(1),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      focusNode: _enrollmentNumberFocusNode,
                      keyboardType: TextInputType.number,
                      controller: username,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6), // Limit to 6 characters
                      ],
                      decoration: InputDecoration(
                        labelText: 'GR number',
                       labelStyle: const TextStyle(fontFamily: "mu_reg",color: Colors.black),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Dark1, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Light1, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: _enrollmentNumberFocusNode.hasFocus ? Dark1 : Light2,
                        ),
                        counterText: "", // Hide the counter
                      ),
                      style: const TextStyle(
                        fontSize: 17,
                        fontFamily: "mu_reg",
                        fontWeight: FontWeight.w500,
                      ),
                      onTap: () {
                        setState(() {});
                      },
                    ),

                  ),
                  const SizedBox(height: 25),
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.06,
                    width: MediaQuery.sizeOf(context).width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Light1.withOpacity(1),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      focusNode: _passwordFocusNode,
                      obscureText: isVisible,
                      controller: password,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(fontFamily: "mu_reg",color: Colors.black),
                        labelText: "Password",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Dark1, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Light1, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: _passwordFocusNode.hasFocus ? Dark1 : Light2, // Change icon color
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          child: Icon(
                            isVisible ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                            color: _passwordFocusNode.hasFocus ? Dark1 : Light2,
                            size: 20,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 17,
                        fontFamily: "mu_reg",
                        fontWeight: FontWeight.w500,
                      ),
                      onTap: () {
                        setState(() {}); // To trigger rebuild and change icon color on tap
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () => Get.toNamed("/forgotPass"),
                      child: Text("Forgot password?",
                          style: TextStyle(fontFamily: "mu_bold"))
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      if(await loginControl.login(username.text,password.text))
                      {
                          Get.offAllNamed("/dashboard");
                      }
                      else
                      {
                          Get.snackbar("Login Failed","Email or Password is invalid",
                          backgroundColor: Colors.red,
                            colorText: Colors.white
                      );
                      }
                      setState(() {
                      isLoading = false;
                      });
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.85,
                      height: MediaQuery.sizeOf(context).height * 0.06,
                      decoration: BoxDecoration(
                        color: Dark1,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Dark1.withOpacity(0.3),
                            spreadRadius: 0,
                            blurRadius: 5,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "mu_reg",
                            letterSpacing: 2,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          if (isLoading)
            Center(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.black45
                ),
                child: Image.asset('assets/gifs/loading.gif', scale: 1.25,),
              ),
            ),
        ],
      ),
    );
  }
}
