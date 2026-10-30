import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minbus_weather_app/Components/MyTextfieldcomponent.dart';
import 'package:minbus_weather_app/Components/MybuttonComponent.dart';
import 'package:minbus_weather_app/Controller/AuthenticationController.dart';
import 'package:minbus_weather_app/Screen/Auth/Signup_screen.dart';
import 'package:minbus_weather_app/Utils/Appcolors.dart';
import 'package:minbus_weather_app/Utils/Appicons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordHidden = true;

  // Clean single controller instance
  final AuthenticationController authController = Get.put(AuthenticationController());

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Scrollable Form Section (Prevents keyboard overflow)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Top Green Icon
                      Container(
                        width: 56,
                        height: 56,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Appcolors.Iconscolor,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: SvgPicture.asset(Appicons.Loginicons),
                      ),

                      const SizedBox(height: 24),

                      // 2. Heading & Subtitle
                      const Text(
                        "Welcome back",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Log in to see your expenses on any device.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 3. Email Input Component
                      Mytextfieldcomponent(
                        label: "Email",
                        hintText: "you@example.com",
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 20),

                      // 4. Password Input Component
                      Mytextfieldcomponent(
                        label: "Password",
                        hintText: "Enter your password",
                        controller: passwordController,
                        isPassword: isPasswordHidden,
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordHidden
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordHidden = !isPasswordHidden;
                            });
                          },
                        ),
                      ),

                      // 5. Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // TODO: Forgot password logic
                          },
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: Appcolors.Iconscolor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // 6. Primary Login Button (Observes loading state if desired)
                      Obx(() => Mybuttoncomponent(
                        text: authController.isLoading.value ? "Logging in..." : "Log in",
                        backgroundColor: Appcolors.Iconscolor,
                        onTap: authController.isLoading.value
                            ? () {}
                            : () {
                          authController.login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                        },
                      )),

                      const SizedBox(height: 16),

                      // 7. "or" Divider
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              "or",
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // 8. Continue with Google Button
                      Mybuttoncomponent(
                        text: "Continue with Google",
                        backgroundColor: Colors.white,
                        textColor: Colors.black87,
                        border: BorderSide(color: Colors.grey.shade300),
                        onTap: () {
                          // TODO: Handle Google Auth
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Section: Create account prompt
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New to Nimbus? ",
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Signup_screen()),
                        );
                      },
                      child: const Text(
                        "Create account",
                        style: TextStyle(
                          color: Color(0xff2F6BFF),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
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
    );
  }
}