import 'package:flutter/material.dart';
import 'package:reels/Resourses/Auth_Methods.dart';
import 'package:reels/Screens/HomeScreen.dart';
import 'package:reels/Screens/RegisterScreen.dart';
import 'package:reels/Widgets/SnackBar.dart';
import 'package:reels/utils/Widgets/TextInputField.dart';
import 'package:reels/utils/constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
                child: Text(
              "Gaming Shots",
              style: TextStyle(
                  color: Colors.red, fontSize: 40, fontWeight: FontWeight.w900),
            )),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Login",
              style: TextStyle(color: primaryColor, fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            TextInputField(
              controller: emailController,
              icon: Icons.email,
              labelText: "Email",
              isObscure: false,
            ),
            const SizedBox(
              height: 10,
            ),
            TextInputField(
              controller: passwordController,
              icon: Icons.lock,
              labelText: "Password",
              isObscure: true,
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () async {
                String response = await Auth_Methods()
                    .login(emailController.text, passwordController.text);
                if (response == "success") {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                } else {
                  customSnackBar(response, context);
                }
              },
              child: Container(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                width: double.infinity,
                color: Colors.red,
                child: const Center(
                    child: Text(
                  "LogIn",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ));
              },
              child: RichText(
                  text: const TextSpan(children: [
                TextSpan(
                    text: "Dont have an account ?",
                    style: TextStyle(color: primaryColor, fontSize: 16)),
                TextSpan(
                    text: "   Register",
                    style: TextStyle(color: Colors.red, fontSize: 16))
              ])),
            )
          ],
        ),
      ),
    );
  }
}
