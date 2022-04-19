import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reels/Resourses/Auth_Methods.dart';
import 'package:reels/Screens/HomeScreen.dart';
import 'package:reels/Screens/LoginScreen.dart';
import 'package:reels/Widgets/ImagePickerCustom.dart';
import 'package:reels/Widgets/SnackBar.dart';
import 'package:reels/utils/constant.dart';

import '../utils/Widgets/TextInputField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController usernameController;
  Uint8List? img;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    usernameController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
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
              "Register",
              style: TextStyle(color: primaryColor, fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                img != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundColor: Colors.black,
                        backgroundImage: MemoryImage(img!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundColor: Colors.black,
                        backgroundImage: NetworkImage(
                            "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png"),
                      ),
                Positioned(
                    bottom: -6,
                    left: 70,
                    child: IconButton(
                      onPressed: () async {
                        Uint8List im = await pickImage(ImageSource.gallery);
                        setState(() {
                          img = im;
                        });
                      },
                      icon: const Icon(Icons.add_a_photo),
                    ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextInputField(
              controller: usernameController,
              icon: Icons.person,
              labelText: "Username",
              isObscure: false,
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
                String res = await Auth_Methods().signUp(emailController.text,
                    passwordController.text, img!, usernameController.text);

                if (res == "success") {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                } else {
                  customSnackBar(res, context);
                }
              },
              child: Container(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                width: double.infinity,
                color: Colors.red,
                child: const Center(
                    child: Text(
                  "Register",
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
                      builder: (context) => LoginScreen(),
                    ));
              },
              child: RichText(
                  text: const TextSpan(children: [
                TextSpan(
                    text: "Already have an account ?",
                    style: TextStyle(color: primaryColor, fontSize: 16)),
                TextSpan(
                    text: "   Login",
                    style: TextStyle(color: Colors.red, fontSize: 16))
              ])),
            )
          ],
        ),
      ),
    );
  }
}
