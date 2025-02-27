
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gmaps/authentication/login_page.dart';
import 'package:status_alert/status_alert.dart';

import '../../../const.dart';
class SingupPage extends StatefulWidget {
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isVisible = false;
  bool agreement = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email.text = "user1@gmail.com";
    password.text = "123456";
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: height * 0.06),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Create an account,',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Let’s help you set up your account, \nit won’t take long.",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " Name",
                      style: TextStyle(
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.009,
                    ),
                    TextFormField(
                      controller: name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 3) {
                          return "Enter Your Name";
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusColor: Colors.greenAccent,
                        contentPadding: EdgeInsets.symmetric(horizontal: 25),
                        hintText: 'Enter your Name',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      " Email",
                      style: TextStyle(
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.009,
                    ),
                    TextFormField(
                      controller: email,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 7 ||
                            !value.contains("@") ||
                            !value.contains(".com")) {
                          return "Enter a valid email address";
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusColor: Colors.greenAccent,
                        contentPadding: EdgeInsets.symmetric(horizontal: 25),
                        hintText: 'Enter Email',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      " Password",
                      style: TextStyle(
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.009,
                    ),
                    TextFormField(
                        obscureText: isVisible ? false : true,
                        controller: password,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.length < 5) {
                            return "Enter a valid Password";
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            iconSize: 15,
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: isVisible
                                ? Icon(FontAwesomeIcons.solidEyeSlash)
                                : Icon(FontAwesomeIcons.solidEye),
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusColor: Colors.greenAccent,
                          contentPadding: EdgeInsets.symmetric(horizontal: 25),
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'poppins',
                        )),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      " Confirm Password",
                      style: TextStyle(
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.009,
                    ),
                    TextFormField(
                      obscureText: isVisible ? false : true,
                      controller: password,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.length < 5) {
                          return "Enter a valid Password";
                        }
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          iconSize: 15,
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: isVisible
                              ? Icon(FontAwesomeIcons.solidEyeSlash)
                              : Icon(FontAwesomeIcons.solidEye),
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusColor: Colors.greenAccent,
                        contentPadding: EdgeInsets.symmetric(horizontal: 25),
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'poppins',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: primaryColor,
                        side: const BorderSide(
                          color: secondaryColor,
                        ),
                        value: agreement,
                        onChanged: (value) {
                          setState(() {
                            agreement = value!;
                          });
                        },
                      ),
                      const Text(
                        'Accept terms & Condition ?',
                        style: TextStyle(color: secondaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton.icon(
                  iconAlignment: IconAlignment.end,
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    if (formkey.currentState!.validate() && agreement == true) {
                      Get.offAll(
                        () => LoginPage(),
                        transition: Transition.cupertino,
                      );
                    }
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => DashboardPageAdmin()));
                    // if (formkey.currentState?.validate() ?? false) {
                    //   bool result = await AuthService()
                    //       .login(username.text, password.text);
                    //
                    //   print(result);
                    //   if (result) {
                    //
                    //     StatusAlert.show(
                    //       context,
                    //       margin: EdgeInsets.all(height * 0.1),
                    //       duration: Durations.long4,
                    //       title: "Login Successfull",
                    //       configuration: IconConfiguration(
                    //           icon: FontAwesomeIcons.circleCheck,
                    //           color: Colors.deepPurple.shade900,
                    //           size: 100),
                    //     );
                    //   } else {
                    //     StatusAlert.show(
                    //       context,
                    //       margin: EdgeInsets.all(height * 0.1),
                    //       duration: Durations.long4,
                    //       title: "Login Failed",
                    //       subtitle: "Please Try Again",
                    //       configuration: IconConfiguration(
                    //           icon: Icons.error,
                    //           color: Colors.redAccent,
                    //           size: 100),
                    //     );
                    //   }
                    // }
                  },
                  icon: const Icon(
                    IconlyBold.arrowRight3,
                    color: Colors.white,
                    size: 16,
                  ),
                  label: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Expanded(
                  //   child: Container(
                  //     height: 10,
                  //     decoration: BoxDecoration(color: Colors.black),
                  //   ),
                  // ),
                  Expanded(
                    child: Divider(
                      indent: 50,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Or Sign up With",
                      style: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade400,
                      endIndent: 50,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset(
                          'assets/images/Google.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: Center(
                          child: Image.asset(
                            'assets/images/Facebook.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already a member? ",
                    style: TextStyle(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(
                        () => const LoginPage(),
                        transition: Transition.cupertino,
                      );
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
