import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController referalController = TextEditingController();
  bool visiblePassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullnameController.dispose();
    confirmPasswordController.dispose();
    referalController.dispose();
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
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back, color: Colors.white)),
          ),
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
                            padding: EdgeInsets.only(left: 20, top: 0),
                            child: Text("Woi, daftaro", style: TextStyle(fontSize: 40),),
                          ),
                          const Padding(
                            padding:  EdgeInsets.only(left: 20),
                            child: Text("Ayo marikno proses daftar e", style: TextStyle(fontSize: 15, color: Colors.white),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Jeneng Lengkap", style: TextStyle(color: Colors.white),),
                                CupertinoTextField(
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(color: Colors.black),
                                  placeholder: "Tulis jeneng lengkap",
                                  controller: fullnameController,
                                  clearButtonMode: OverlayVisibilityMode.editing,
                                  keyboardAppearance: Brightness.light,
                                ),
                              ],
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
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
                            padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Kata Sandi", style: TextStyle(color: Colors.white),),
                                CupertinoTextField(
                                  keyboardType: TextInputType.visiblePassword,
                                  suffixMode: OverlayVisibilityMode.editing,
                                  obscureText: visiblePassword,
                                  suffix: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        visiblePassword = !visiblePassword;
                                      });
                                    },
                                    child: visiblePassword ? const Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Icon(CupertinoIcons.eye, color: Colors.black54, size: 20),
                                    ) : const Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Icon(CupertinoIcons.eye_slash, color: Colors.black54, size: 20),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.black54),
                                  placeholder: "Tulis kata sandi mu",
                                  controller: passwordController,
                                  clearButtonMode: OverlayVisibilityMode.editing,
                                  keyboardAppearance: Brightness.light,
                                ),
                              ],
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Konfirmasi Kata Sandi", style: TextStyle(color: Colors.white),),
                                CupertinoTextField(
                                  keyboardType: TextInputType.visiblePassword,
                                  style: const TextStyle(color: Colors.black),
                                  placeholder: "Tulis maning kata sandi",
                                  obscureText: visiblePassword,
                                  suffix: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        visiblePassword = !visiblePassword;
                                      });
                                    },
                                    child: visiblePassword ? const Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Icon(CupertinoIcons.eye, color: Colors.black54, size: 20),
                                    ) : const Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Icon(CupertinoIcons.eye_slash, color: Colors.black54, size: 20),
                                    ),
                                  ),
                                  controller: confirmPasswordController,
                                  clearButtonMode: OverlayVisibilityMode.editing,
                                  keyboardAppearance: Brightness.light,
                                ),
                              ],
                            )
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 14, right: 20),
                            child: Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: (){
                                    // Navigator.push(context, CupertinoPageRoute(builder: (context) => const OTPPage()));
                                  },
                                  child: const Text("Submit", style: TextStyle(fontSize: 20),), 
                                ),
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
            bottomNavigationBar: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Have account?"),
                CupertinoButton(
                  padding: const EdgeInsets.only(left: 4),
                  onPressed: (){
                    // Get.off(() => const LoginPage());
                  },
                  child: const Text("Log In"), 
                )
              ],
            ),
          ),
        ),
    );
  }
}