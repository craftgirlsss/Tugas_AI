import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uas_ai/src/views/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20, top: 50),
                          child: Text("Woi", style: TextStyle(fontSize: 50, color: Colors.white),),
                        ),
                        const Padding(
                          padding:  EdgeInsets.only(left: 20),
                          child: Text("Jajal saiki aplikasi ga jelas gaweanku @putrabudianto23", style: TextStyle(fontSize: 15, color: Colors.white),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Email", style: TextStyle(color: Colors.white),),
                              CupertinoTextField(
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(color: Colors.black),
                                placeholder: "Tulis email mu",
                                controller: emailController,
                                clearButtonMode: OverlayVisibilityMode.editing,
                                keyboardAppearance: Brightness.light,
                              ),
                            ],
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 14, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Kata Sandi", style: TextStyle(color: Colors.white),),
                              CupertinoTextField(
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: showPassword,
                                placeholder: "Tulis kata sandi mu",
                                style: const TextStyle(color: Colors.black),
                                controller: passwordController,
                                clearButtonMode: OverlayVisibilityMode.editing,
                                keyboardAppearance: Brightness.light,
                              ),
                            ],
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 7, right: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    CupertinoCheckbox(value: !showPassword, onChanged: (value) {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    },),
                                    const Text("Ndelok password")
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: (){
                                  // Navigator.push(context, CupertinoPageRoute(builder: (context) => const ForgotPassword()));
                                },
                                child: const Text("Lali password?"), 
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 14, right: 20),
                          child: Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: (){
                                  // Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => const MainPage()), (route) => true);
                                },
                                child: const Text("Mlebu", style: TextStyle(fontSize: 20),), 
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have account?"),
              TextButton(
                onPressed: (){
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => const RegisterPage()));
                },
                child: const Text("Daftar"), 
              )
            ],
          ),
        ),
      ),
    );
  }
}