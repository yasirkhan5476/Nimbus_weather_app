import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minbus_weather_app/Components/MyTextfieldcomponent.dart';
import 'package:minbus_weather_app/Components/MybuttonComponent.dart';
import 'package:minbus_weather_app/Controller/AuthenticationController.dart';
import 'package:minbus_weather_app/Screen/Auth/login_Screen.dart';
import 'package:minbus_weather_app/Utils/Appcolors.dart';
import 'package:minbus_weather_app/Utils/Appicons.dart';

class Signup_screen extends StatefulWidget {
  const Signup_screen({super.key});

  @override
  State<Signup_screen> createState() => _Signup_screenState();
}

class _Signup_screenState extends State<Signup_screen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Safe retrieval of the controller (ensure it was put or find works correctly)
  final authController = Get.find<AuthenticationController>();

  bool isPasswordHidden = true;
  bool isTermsAccepted = false;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top Form Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. Circular Icon Header
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
                            "Create your account",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Back up your expenses and use Kharcha on all your devices.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // 3. Full Name Input Component
                          Mytextfieldcomponent(
                            label: "Full name",
                            hintText: "Your name",
                            controller: fullNameController,
                          ),

                          const SizedBox(height: 16),

                          // 4. Email Input Component
                          Mytextfieldcomponent(
                            label: "Email",
                            hintText: "you@example.com",
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),

                          const SizedBox(height: 16),

                          // 5. Password Input Component
                          Mytextfieldcomponent(
                            label: "Password",
                            hintText: "Create a password",
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

                          const SizedBox(height: 16),

                          // 6. Terms & Conditions Checkbox
                          Row(
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Checkbox(
                                  value: isTermsAccepted,
                                  activeColor: Appcolors.Iconscolor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      isTermsAccepted = value ?? false;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade700,
                                    ),
                                    children: const [
                                      TextSpan(text: "I agree to the "),
                                      TextSpan(
                                        text: "Terms",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(text: " and "),
                                      TextSpan(
                                        text: "Privacy Policy",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(text: "."),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // 7. Create Account Button
                          Obx(() => Mybuttoncomponent(
                            text: authController.isLoading.value
                                ? "Creating account..."
                                : "Create account",
                            backgroundColor: Appcolors.Iconscolor,
                            onTap: authController.isLoading.value
                                ? () {}
                                : () {
                              // Simple validation checks
                              if (fullNameController.text.trim().isEmpty ||
                                  emailController.text.trim().isEmpty ||
                                  passwordController.text.trim().isEmpty) {
                                Get.snackbar(
                                  "Error",
                                  "Please fill in all fields",
                                  backgroundColor: Colors.redAccent,
                                  colorText: Colors.white,
                                );
                                return;
                              }

                              if (!isTermsAccepted) {
                                Get.snackbar(
                                  "Error",
                                  "You must accept the Terms and Privacy Policy",
                                  backgroundColor: Colors.redAccent,
                                  colorText: Colors.white,
                                );
                                return;
                              }

                              // Call signup method from controller
                              authController.signup(
                                fullNameController.text.trim(),
                                emailController.text.trim(),
                                passwordController.text.trim()
                              );
                            },
                          )),
                        ],
                      ),

                      // Bottom Section: Already have an account? Log in
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 15,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Log in",
                                style: TextStyle(
                                  color: Appcolors.Iconscolor,
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
          },
        ),
      ),
    );
  }
}