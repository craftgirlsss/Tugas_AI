import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uas_ai/src/components/alert_dialog.dart';
import 'package:uas_ai/src/components/loadings.dart';
import 'package:uas_ai/src/controllers/auth_controller.dart';
import 'package:uas_ai/src/views/success_page.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  AuthController authController = Get.find();
  final _formKey = GlobalKey<FormState>();
  bool visiblePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullnameController.dispose();
    nimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                leading: IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: const Icon(Icons.arrow_back, color: Colors.white)),
              ),
              body: SafeArea(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                      const Text("NIM", style: TextStyle(color: Colors.white),),
                                      CupertinoTextField(
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(color: Colors.black),
                                        placeholder: "Tulis NIM mu",
                                        controller: nimController,
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
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, top: 14, right: 20),
                                  child: Center(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Obx(() => ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            shape: BeveledRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              side: const BorderSide(color: Colors.blue)
                                            )
                                          ),
                                          onPressed: authController.isLoading.value ? (){} : ()async{
                                            if(fullnameController.text == '' || nimController.text == "" || emailController.text == "" || passwordController.text == ''){
                                              showAlertDialog(context);
                                            }else{
                                              if(await authController.register(
                                                email: emailController.text,
                                                fullName: fullnameController.text,
                                                nim: nimController.text,
                                                password: passwordController.text
                                              )){
                                                Future.delayed(Duration.zero, (){
                                                  Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => const SuccessPage()), (route) => false);
                                                });
                                              }
                                            }
                                          },

                                          child: const Text("Daftar", style: TextStyle(fontSize: 20, color: Colors.white),), 
                                        ),
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
                ),
                bottomNavigationBar: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Have account?"),
                    Obx(() => CupertinoButton(
                        padding: const EdgeInsets.only(left: 4),
                        onPressed: authController.isLoading.value ? (){} : ()async{
                          Navigator.pop(context);
                        },
                        child: const Text("Log In"), 
                      ),
                    )
                  ],
                ),
              ),
            ),
            Obx(() => authController.isLoading.value == true
              ? floatingLoading()
              : const SizedBox()
            ),
        ],
      ),
    );
  }
}