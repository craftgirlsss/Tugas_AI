import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uas_ai/src/components/alert_dialog.dart';
import 'package:uas_ai/src/components/loadings.dart';
import 'package:uas_ai/src/controllers/auth_controller.dart';
import 'package:uas_ai/src/views/index.dart';
import 'package:uas_ai/src/views/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthController authController = Get.find();
  TextEditingController nimController= TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = true;

  @override
  void dispose() {
    nimController.dispose();
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
      child: Stack(
        children: [
          GestureDetector(
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
                                  const Text("NIM", style: TextStyle(color: Colors.white),),
                                  CupertinoTextField(
                                    keyboardType: TextInputType.emailAddress,
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
                                        const Text("Ningali password")
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: (){
                                      showAlertDialogFiturStillDevelopment(context);
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
                                  child: Obx(() => ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shape: BeveledRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: const BorderSide(color: Colors.blue)
                                        )
                                      ),
                                      onPressed: authController.isLoading.value ? (){} : ()async{
                                        if(await authController.login(
                                          nim: nimController.text,
                                          password: passwordController.text
                                        )){
                                          Future.delayed(const Duration(seconds: 2), (){
                                            Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => const ChatRoomScreen()), (route) => false);
                                          });
                                        }else{
                                          Future.delayed(Duration.zero, (){
                                            showAlertDialogLogin(context);
                                          });
                                        }
                                      },
                                      child: const Text("Mlebu", style: TextStyle(fontSize: 20, color: Colors.white),), 
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
                )
              ),
              bottomNavigationBar: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Ora ndue akun?"),
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
          Obx(() => authController.isLoading.value == true
            ? floatingLoading()
            : const SizedBox()),
        ],
      ),
    );
  }
}